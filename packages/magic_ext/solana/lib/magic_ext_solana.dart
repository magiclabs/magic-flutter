import 'dart:convert';
import 'dart:typed_data';
import 'package:magic_ext_solana/types/transaction_signature.dart';
import 'package:solana/dto.dart';
import 'package:solana/encoder.dart';
import 'package:magic_ext_solana/types/serialize_config.dart';
import 'package:magic_sdk/magic_sdk.dart';
import 'package:magic_sdk/modules/blockchain/blockchain.dart';
import 'package:magic_sdk/modules/blockchain/supported_blockchain.dart';
import 'package:magic_sdk/provider/rpc_provider.dart';
import 'package:magic_sdk/provider/types/relayer_response.dart';
import 'package:magic_sdk/utils/typed_array_for_json.dart';

part 'types/solana_method.dart';

/// Magic Signer re-routes signing requests to auth relayer and trigger ledger bridge signing
class SolanaSigner extends BlockchainModule {
  SolanaSigner(RpcProvider provider, SupportedBlockchain blockchain)
      : super(provider, blockchain);

  static SolanaSigner? instance;

  /// sends unsigned transaction to the Signer
  ///
  /// @param [recentBlockhash] recentBlockhash from node
  /// @param [message] Message of instructions
  /// @param [signers] signers without private key
  Future<TransactionSignature> signTransaction(RecentBlockhash recentBlockhash,
      Message message, List<AccountMeta> signers,
      {SerializeConfig config = const SerializeConfig()}) async {

    // Construct instructions JSON
    var instructionsJSON = message.instructions.map((i) {
      var typedArray =
          MgboxTypedArray(data: i.data.join(','), constructor: "Buffer");
      return {
        "programId": i.programId.toBase58(),
        "data": typedArray,
        "keys": i.accounts
            .map((acc) => {
                  "pubkey": acc.pubKey.toBase58(),
                  "isSigner": acc.isSigner,
                  "isWritable": acc.isWriteable
                })
            .toList()
      };
    }).toList();

    var params = {
      "feePayer": signers.first.pubKey.toBase58(),
      "instructions": instructionsJSON,
      "recentBlockhash": recentBlockhash.blockhash,
      "serializeConfig": config.toJson()
    };

    // compiled instructions
    final CompiledMessage compiledMessage = message.compile(
      recentBlockhash: recentBlockhash.blockhash,
      feePayer: signers.first.pubKey,
    );

    return sendToProviderWithMap(
            method: SolanaMethod.sol_signTransaction, params: params)
        .then((jsMsg) {
      var relayerResponse = RelayerResponse<MgboxTransactionSignature>.fromJson(
          json.decode(jsMsg.message),
          (json) =>
              MgboxTransactionSignature.fromJson(json as Map<String, dynamic>));
      var result = relayerResponse.response.result;
      return TransactionSignature(
          messageBytes: compiledMessage.data,
          rawTransaction: result.rawTransaction.convertToUint8List(),
          signature: result.signature
              .map((e) => SolanaSignature(
                  signature: e.signature.convertToUint8List(),
                  publicKey: e.publicKey))
              .toList());
    });
  }

  Future<Uint8List> signMessage(Uint8List message) {
    var typedArray = MgboxTypedArray.from(message);
    return sendToProviderWithMap(
        method: SolanaMethod.sol_signMessage,
        params: {"message": typedArray}).then((jsMsg) {
      var relayerResponse = RelayerResponse<MgboxTypedArray>.fromJson(
          json.decode(jsMsg.message),
          (json) => MgboxTypedArray.fromJson(json as Map<String, dynamic>));
      return relayerResponse.response.result.convertToUint8List();
    });
  }
}

/// Append modules on runtime
/// Make singleton design to ensure remote signer is the only
extension SolanaExtension on Magic {
  SolanaSigner get solana {
    if (SolanaSigner.instance != null) {
      return SolanaSigner.instance!;
    } else {
      SolanaSigner.instance =
          SolanaSigner(provider, SupportedBlockchain.solana);
      return SolanaSigner.instance!;
    }
  }
}
