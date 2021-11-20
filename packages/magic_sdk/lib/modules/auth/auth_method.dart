part of "auth_module.dart";

/// Auth Method
enum AuthMethod {
  magic_auth_login_with_magic_link,
  magic_auth_login_with_sms
}

extension ParseAuthMethodToString on AuthMethod {
  String toShortString() {
    return toString().split('.').last;
  }
}
