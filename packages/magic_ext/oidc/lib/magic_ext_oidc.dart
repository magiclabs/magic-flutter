import 'dart:convert';

import 'package:magic_ext_oidc/open_id_configuration.dart';
import 'package:magic_sdk/magic_sdk.dart';
import 'package:magic_sdk/modules/base_module.dart';
import 'package:magic_sdk/provider/rpc_provider.dart';
import 'package:magic_sdk/provider/types/relayer_response.dart';

part 'types/oidc_method.dart';

/// Extension to support login with oidc
class OidcExtension extends BaseModule {
  OidcExtension(RpcProvider provider) : super(provider);

  Future<String> loginWithOIDC(OpenIdConfiguration configuration) async {
    return await sendToProvider(
        method: OidcMethod.magic_auth_login_with_oidc,
        params: [
          {'jwt': configuration.jwt, 'providerId': configuration.providerId}
        ]).then((jsMsg) {
      var relayerResponse = RelayerResponse<String>.fromJson(
          json.decode(jsMsg.message),
          (json) => json.toString()); //DIDToken.fromJson(json)
      return relayerResponse.response.result;
    });
  }
}

/// Magic extends oauth extension
extension MagicOidcExtension on Magic {
  OidcExtension get oidc => OidcExtension(provider);
}
