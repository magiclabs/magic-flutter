import 'dart:convert';
import 'dart:typed_data';

import 'package:blockchain_signer/signer/remote/remote_signer.dart';
import 'package:blockchain_signer/signer/sign_result.dart';
import 'package:magic_sdk/magic_sdk.dart';
import 'package:magic_sdk/modules/base_module.dart';
import 'package:magic_sdk/provider/rpc_provider.dart';
import 'package:magic_sdk/provider/types/relayer_response.dart';

part 'types/tezos_method.dart';

/// Magic Signer re-routes signing requests to auth relayer and trigger ledger bridge signing
class TezosExtension extends BaseModule implements RemoteSigner  {

  TezosExtension(RpcProvider provider) : super(provider);

  /// sends unsigned payload to the Signer and wait for it to be signed
  ///
  /// @param [op] Operation to sign
  /// @param [magicByte] Magic bytes 1 for block, 2 for endorsement, 3 for generic, 5 for the PACK format of michelson
  @override
  Future<SignResult> sign(String op, Uint8List magicByte){
    final params = {
      "bytes": op,
      "watermark": magicByte
    };

    return sendToProvider(
        method: TezosMethod.taquito_sign,
        params: [params]).then((jsMsg) {
      var relayerResponse = RelayerResponse<SignResult>.fromJson(
          json.decode(jsMsg.message),
              (json) => SignResult.fromJson(json as Map<String, dynamic>));
      return relayerResponse.response.result;
    });
  }

  @override
  // TODO: implement address
  Future<String> get address => throw UnimplementedError();

  @override
  // TODO: implement publicKey
  Future<String> get publicKey => throw UnimplementedError();

  @override
  Future<String> get secretKey => throw UnsupportedError('Secret key is not available');
}

/// Append basic modules on runtime
extension MagicTezosExtension on Magic {
  TezosExtension get tezos => TezosExtension(provider);
}
