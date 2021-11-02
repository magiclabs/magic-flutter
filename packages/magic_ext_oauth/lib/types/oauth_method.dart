part of '../magic_ext_oauth.dart';

enum OAuthMethod { magic_oauth_parse_redirect_result }

extension ParseOAuthMethodToString on OAuthMethod {
  String toShortString() {
    return toString().split('.').last;
  }
}
