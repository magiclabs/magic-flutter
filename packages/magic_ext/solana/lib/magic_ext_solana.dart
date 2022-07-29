import 'dart:convert';
import 'dart:typed_data';
// import 'package:blockchain_signer/signer/remote/remote_signer.dart';
// import 'package:blockchain_signer/signer/response/signed_result.dart';
// import 'package:magic_ext_solana/types/public_key.dart';
import 'package:magic_sdk/magic_sdk.dart';
import 'package:magic_sdk/modules/blockchain/blockchain.dart';
import 'package:magic_sdk/modules/blockchain/supported_blockchain.dart';
import 'package:magic_sdk/provider/rpc_provider.dart';
import 'package:magic_sdk/provider/types/relayer_response.dart';

part 'types/solana_method.dart';

/// Magic Signer re-routes signing requests to auth relayer and trigger ledger bridge signing
class SolanaSigner extends BlockchainModule {
  SolanaSigner(RpcProvider provider, SupportedBlockchain blockchain)
      : super(provider, blockchain);

  static SolanaSigner? instance;

  /// sends unsigned payload to the Signer and wait for it to be signed
  ///
  /// @param [op] Operation to sign
  /// @param [magicByte] Magic bytes 1 for block, 2 for endorsement, 3 for generic, 5 for the PACK format of michelson

  Future<void> init() async {}

  Future<void> sendAndConfirmTransaction(Object transaction, Object? options) async {
    // return sendToProvider(method:)
  }

  Future<String> signMessage(message) {
    return sendToProviderWithMap(method: SolanaMethod.sol_signMessage, params: { "message": message }).then((jsMsg) {
      var relayerResponse = RelayerResponse<String>.fromJson(
          json.decode(jsMsg.message), (json) => json as String);
      return relayerResponse.response.result;
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
      SolanaSigner.instance = SolanaSigner(provider, SupportedBlockchain.solana);
      return SolanaSigner.instance!;
    }
  }
}
