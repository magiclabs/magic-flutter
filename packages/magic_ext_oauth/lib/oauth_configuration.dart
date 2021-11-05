/// OAuth Configuration
class OAuthConfiguration {
  OAuthProvider provider;
  String redirectURI;
  List<String>? scope;
  String? loginHint;

  OAuthConfiguration(
      {required this.provider,
      required this.redirectURI,
      this.scope,
      this.loginHint});
}

/// OAuth Supported Provider
enum OAuthProvider {
  GOOGLE,
  FACEBOOK,
  GITHUB,
  APPLE,
  LINKEDIN,
  BITBUCKET,
  GITLAB,
  TWITTER,
  DISCORD,
  TWITCH,
  MICROSOFT
}

extension ParseOAuthProviderToString on OAuthProvider {
  String toShortString() {
    return toString().split('.').last.toLowerCase();
  }
}
