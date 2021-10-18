class OAuthConfiguration {
  late OAuthProvider provider;
  late String redirectURI;
  List<String>? scope;
  String? loginHint;

  OAuthConfiguration({required this.provider, required this.redirectURI, this.scope, this.loginHint});
}

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
