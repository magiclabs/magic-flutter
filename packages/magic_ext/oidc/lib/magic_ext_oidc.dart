import 'dart:convert';

import 'package:magic_sdk/magic_sdk.dart';
import 'package:magic_sdk/modules/base_module.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:magic_sdk/provider/rpc_provider.dart';
import 'types/open_id_configuration.dart';

part 'types/oidc_method.dart';

class OIDCExtension extends BaseModule {
  OIDCExtension(RpcProvider provider) : super(provider);

  Future<String> loginWithOIDC(OpenIdConfiguration configuration) async {
    var configJson = configuration.toJson();

    JavaScriptMessage response = await sendToProviderWithList(
      method: OIDCMethod.magic_auth_login_with_oidc,
      params: [configJson],
    );

    // Parse the JSON response
    var decodedResponse = json.decode(response.message);

    // Extract the DID from the decoded response
    var result = decodedResponse['response']['result'];

    return result; // Return the DID
  }

}

/// Magic extends oidc extension
extension MagicOIDCExtension on Magic {
  OIDCExtension get openid => OIDCExtension(provider);
}
