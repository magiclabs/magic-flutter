import 'dart:convert';
import 'dart:typed_data';
import 'package:blockchain_signer/signer/remote/remote_signer.dart';
import 'package:blockchain_signer/signer/response/signed_result.dart';
import 'package:magic_ext_tezos/types/public_key.dart';
import 'package:magic_sdk/magic_sdk.dart';
import 'package:magic_sdk/modules/blockchain/blockchain.dart';
import 'package:magic_sdk/modules/blockchain/supported_blockchain.dart';
import 'package:magic_sdk/provider/rpc_provider.dart';
import 'package:magic_sdk/provider/types/relayer_response.dart';

part 'types/tezos_method.dart';

/// Magic Signer re-routes signing requests to auth relayer and trigger ledger bridge signing
class TezosSigner extends BlockchainModule implements RemoteSigner {
  TezosSigner(RpcProvider provider, SupportedBlockchain blockchain)
      : super(provider, blockchain);

  late String _pk;
  late String _pkh;

  static TezosSigner? instance;

  @override
  // TODO: implement address
  String get address => _pkh;

  @override
  String get publicKey => _pk;


  @override
  String get secretKey =>
      throw UnsupportedError('Secret key is not available');

  /// sends unsigned payload to the Signer and wait for it to be signed
  ///
  /// @param [op] Operation to sign
  /// @param [magicByte] Magic bytes 1 for block, 2 for endorsement, 3 for generic, 5 for the PACK format of michelson


  Future<void> init() async {
    await sendToProvider(method: TezosMethod.taquito_getPublicKeyAndHash, params: [])
        .then((jsMsg) {
      var relayerResponse = RelayerResponse<PublicKey>.fromJson(
          json.decode(jsMsg.message),
              (json) => PublicKey.fromJson(json as Map<String, dynamic>));
      _pk = relayerResponse.response.result.pk;
      _pkh = relayerResponse.response.result.pkh;
      return relayerResponse.response.result;
    });
  }
  @override
  Future<SignedResult> sign(String op, Uint8List magicByte) {
    final params = {"bytes": op, "watermark": magicByte};

    return sendToProvider(method: TezosMethod.taquito_sign, params: [params])
        .then((jsMsg) {
      var relayerResponse = RelayerResponse<SignedResult>.fromJson(
          json.decode(jsMsg.message),
              (json) => SignedResult.fromJson(json as Map<String, dynamic>));
      return relayerResponse.response.result;
    });
  }
}

/// Append modules on runtime
/// Make singleton design to ensure remote signer is the only
extension TezosExtension on Magic {
  TezosSigner get tezos {

    if (TezosSigner.instance != null) {
      return TezosSigner.instance!;
    } else {
      TezosSigner.instance = TezosSigner(provider, SupportedBlockchain.tezos);
      return TezosSigner.instance!;
    }
  }
}
