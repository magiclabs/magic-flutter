/// OIDC Configuration
class OpenIdConfiguration {
  final String jwt;
  final String providerId;

  OpenIdConfiguration({required this.jwt, required this.providerId});

  Map<String, dynamic> toJson() {
    return {
      'jwt': jwt,
      'providerId': providerId,
    };
  }
}
