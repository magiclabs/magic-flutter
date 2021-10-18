import 'package:magic_sdk/modules/auth/auth_module.dart';
import 'package:magic_sdk/modules/base_module.dart';
import 'package:magic_sdk/modules/user/user_module.dart';
import 'package:magic_sdk/provider/rpc_provider.dart';
import 'package:magic_sdk/relayer/url_builder.dart';
import 'package:uri/uri.dart';

import 'oauth_challenge.dart';
import 'oauth_configuration.dart';
export 'package:magic_sdk/magic_sdk.dart';

/// The entry point for accessing Magic SDK.
class OAuthExtension extends BaseModule {

  OAuthExtension(RpcProvider provider) : super(provider);


  // // Disables the platform override in order to use a manually registered
  // // See https://github.com/flutter/flutter/issues/52267 for more details.
  // Magic._();

  loginWithPopup(OAuthConfiguration configuration) {
    OAuthChallenge oauthChallenge = OAuthChallenge();

    var uri = UriBuilder();
    uri.scheme = 'https';
    uri.host = 'auth.magic.link';

    // uri.scheme = 'http';
    // uri.host = '192.168.0.106';
    // uri.port = '3014';

    uri.path = '/v1/oauth2/${configuration.provider.toShortString()}';

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


  }
}

extension MagicOAuthExtension on Magic {
  OAuthExtension get oauth => OAuthExtension(provider);
}
