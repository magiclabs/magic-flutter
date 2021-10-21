import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:magic_ext_oauth/types/oauth_method.dart';
import 'package:magic_ext_oauth/types/oauth_response.dart';
import 'package:magic_sdk/modules/auth/auth_module.dart';
import 'package:magic_sdk/modules/base_module.dart';
import 'package:magic_sdk/modules/user/user_module.dart';
import 'package:magic_sdk/provider/rpc_provider.dart';
import 'package:magic_sdk/provider/types/relayer_response.dart';
import 'package:magic_sdk/relayer/url_builder.dart';
import 'package:uri/uri.dart';

import 'utils/oauth_challenge.dart';
import 'oauth_configuration.dart';
export 'package:magic_sdk/magic_sdk.dart';

/// The entry point for accessing Magic SDK.
class OAuthExtension extends BaseModule {

  OAuthExtension(RpcProvider provider) : super(provider);


  // // Disables the platform override in order to use a manually registered
  // // See https://github.com/flutter/flutter/issues/52267 for more details.
  // Magic._();

  Future<OAuthResponse> loginWithPopup(OAuthConfiguration configuration) async {
    OAuthChallenge oauthChallenge = OAuthChallenge();

    // Create Auth Session
    String successUri = await _createAuthenticationSession(oauthChallenge: oauthChallenge, configuration: configuration);

    // Parse Redirect Result
    return _parseRedirectResult(successUri, oauthChallenge);
  }

  /// Create Authentication Session to process social login request
  Future<String> _createAuthenticationSession ({required OAuthChallenge oauthChallenge, required OAuthConfiguration configuration}) async {

    var uri = UriBuilder();
    uri.scheme = 'https';
    uri.host = 'auth.magic.link';
    uri.port = 443;

    uri.path = '/v1/oauth2/${configuration.provider.toShortString()}/start';

    uri.queryParameters = {
      'magic_api_key': URLBuilder.instance.apiKey,
      'magic_challenge': oauthChallenge.challenge,
      'state':  oauthChallenge.state,
      'redirect_uri': configuration.redirectURI,
      'platform': 'rn'
    };

    if (configuration.scope != null && configuration.scope!.isNotEmpty) {
      uri.queryParameters.addAll({'scope': configuration.scope!.join(' ')});
    }

    if (configuration.loginHint != null && configuration.loginHint!.isNotEmpty) {
      uri.queryParameters.addAll({'login_hint': configuration.loginHint as String});
    }

    // clean callbackUrlScheme to make sure there's no ':' or '//'
    var index = configuration.redirectURI.indexOf(':');

    var redirectURI = index != -1 ? configuration.redirectURI.substring(0, index) : configuration.redirectURI;

    return await FlutterWebAuth.authenticate(url: uri.build().toString(), callbackUrlScheme: redirectURI);
  }

  /// Parse redirect results
  Future<OAuthResponse> _parseRedirectResult(String successResult, OAuthChallenge challenge) async {
    Uri successUri = Uri.parse(successResult);

    return await sendToProvider(method: OAuthMethod.magic_oauth_parse_redirect_result.toShortString(), params: [
      "?${successUri.query}",
      challenge.verifier,
      challenge.state
    ]).then((jsMsg) {
      var relayerResponse = RelayerResponse<OAuthResponse>.fromJson(json.decode(jsMsg.message), (result) =>
          OAuthResponse.fromJson(result as Map<String, dynamic>));
      return relayerResponse.response.result;
    });
  }
}

extension MagicOAuthExtension on Magic {
  OAuthExtension get oauth => OAuthExtension(provider);
}
