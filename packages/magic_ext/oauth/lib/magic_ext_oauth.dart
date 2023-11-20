import 'dart:convert';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:magic_sdk/magic_sdk.dart';
import 'package:magic_sdk/modules/base_module.dart';
import 'package:magic_sdk/provider/rpc_provider.dart';
import 'package:magic_sdk/provider/types/relayer_response.dart';
import 'package:magic_sdk/relayer/url_builder.dart';
import 'package:magic_sdk/utils/string.dart';
import 'package:uri/uri.dart';

import 'oauth_configuration.dart';
import 'types/oauth_response.dart';
import 'utils/oauth_challenge.dart';

export 'package:magic_ext_oauth/magic_ext_oauth.dart';
export 'package:magic_ext_oauth/oauth_configuration.dart';

part 'types/oauth_method.dart';

/// The entry point for accessing Magic SDK.
class OAuthExtension extends BaseModule {
  OAuthExtension(RpcProvider provider) : super(provider);

  /// Invoke authSession in IOS and custom browser in Android to start oauth flow
  Future<OAuthResponse> loginWithRedirect(OAuthConfiguration configuration) async {
    OAuthChallenge oauthChallenge = OAuthChallenge();

    // Create Auth Session
    String successUri = await _createAuthenticationSession(
        oauthChallenge: oauthChallenge, configuration: configuration);

    // Parse Redirect Result
    return _parseRedirectResult(successUri, oauthChallenge);
  }

  /// Create Authentication Session to process social login request
  Future<String> _createAuthenticationSession(
      {required OAuthChallenge oauthChallenge,
      required OAuthConfiguration configuration}) async {
    var packageInfo = await PackageInfo.fromPlatform();
    var uri = UriBuilder();
    uri.scheme = 'https';
    uri.host = 'auth.magic.link';
    uri.port = 443;

    uri.path =
        '/v1/oauth2/${toShortString(configuration.provider).toLowerCase()}/start';

    uri.queryParameters = {
      'magic_api_key': URLBuilder.instance.apiKey,
      'magic_challenge': oauthChallenge.challenge,
      'state': oauthChallenge.state,
      'redirect_uri': configuration.redirectURI,
      'platform': 'rn',
      'bundleId': packageInfo.packageName
    };

    if (configuration.scope != null && configuration.scope!.isNotEmpty) {
      uri.queryParameters.addAll({'scope': configuration.scope!.join(' ')});
    }

    if (configuration.loginHint != null &&
        configuration.loginHint!.isNotEmpty) {
      uri.queryParameters
          .addAll({'login_hint': configuration.loginHint as String});
    }

    // clean callbackUrlScheme to make sure there's no ':' or '//'
    var index = configuration.redirectURI.indexOf(':');

    var redirectURI = index != -1
        ? configuration.redirectURI.substring(0, index)
        : configuration.redirectURI;

    return await FlutterWebAuth.authenticate(
        url: uri.build().toString(), callbackUrlScheme: redirectURI);
  }

  /// Parse redirect results
  Future<OAuthResponse> _parseRedirectResult(
      String successResult, OAuthChallenge challenge) async {
    Uri successUri = Uri.parse(successResult);

    return await sendToProvider(
        method: OAuthMethod.magic_oauth_parse_redirect_result,
        params: [
          "?${successUri.query}",
          challenge.verifier,
          challenge.state
        ]).then((jsMsg) {
      var relayerResponse = RelayerResponse<OAuthResponse>.fromJson(
          json.decode(jsMsg.message),
          (result) => OAuthResponse.fromJson(result as Map<String, dynamic>));
      return relayerResponse.response.result;
    });
  }
}

/// Magic extends oauth extension
extension MagicOAuthExtension on Magic {
  OAuthExtension get oauth => OAuthExtension(provider);
}
