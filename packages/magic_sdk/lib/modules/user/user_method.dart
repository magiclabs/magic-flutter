part of "user_module.dart";

enum UserMethod {
  magic_auth_get_id_token,
  magic_auth_generate_id_token,
  magic_auth_get_metadata,
  magic_auth_is_logged_in,
  magic_auth_update_email,
  magic_auth_logout
}

extension ParseUserMethodToString on UserMethod {
  String toShortString() {
    return toString().split('.').last;
  }
}
