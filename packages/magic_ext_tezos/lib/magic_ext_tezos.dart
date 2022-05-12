import 'dart:convert';
import 'dart:typed_data';

import 'package:blockchain_signer/signer/external_signer.dart';
import 'package:magic_sdk/magic_sdk.dart';
import 'package:magic_sdk/modules/base_module.dart';
import 'package:magic_sdk/provider/rpc_provider.dart';
import 'package:magic_sdk/provider/types/relayer_response.dart';

part 'types/tezos_method.dart';

/// Magic Signer re-routes signing requests to auth relayer and trigger ledger bridge signing
class TezosExtension extends BaseModule implements ExternalSigner  {

  TezosExtension(RpcProvider provider) : super(provider);

  /// sends unsigned payload to the Signer and wait for it to be signed
  ///
  /// @param [op] Operation to sign
  /// @param [magicByte] Magic bytes 1 for block, 2 for endorsement, 3 for generic, 5 for the PACK format of michelson
  @override
  Future<String> signAsync(String op, Uint8List magicByte){
    final params = {
      "bytes": op,
      "watermark": magicByte
    };

    return sendToProvider(
        method: TezosMethod.taquito_sign,
        params: [params]).then((jsMsg) {
      var relayerResponse = RelayerResponse<String>.fromJson(
          json.decode(jsMsg.message), (json) => json as String);
      return relayerResponse.response.result;
    });
  }
}

/// Append basic modules on runtime
extension MagicTezosExtension on Magic {
  TezosExtension get tezos => TezosExtension(provider);
}
