import 'dart:async';
import 'dart:convert';

import '../../modules/base_module.dart';
import '../../modules/user/user_response_type.dart';
import '../../provider/rpc_provider.dart';
import '../../provider/types/relayer_response.dart';

part 'user_method.dart';

/// User Module includes user authentication apis
class UserModule extends BaseModule {
  UserModule(RpcProvider provider) : super(provider);

  /// Returns [Future] of [String], Generates a Decentralized Id Token which
  /// acts as a proof of authentication to resource servers.
  Future<String> getIdToken({int lifespan = 900}) async {
    var params = {
      'lifespan': lifespan,
    };
    return sendToProvider(
        method: UserMethod.magic_auth_get_id_token,
        params: [params]).then((jsMsg) {
      var relayerResponse = RelayerResponse<String>.fromJson(
          json.decode(jsMsg.message), (json) => json as String);
      return relayerResponse.response.result;
    });
  }

  /// Returns [Future] of [String], Decentralized Id Token with optional serialized data
  Future<String> generateIdToken(
      {int lifespan = 900, String attachment = 'none'}) async {
    var params = {'lifespan': lifespan, 'attachment': attachment};
    return sendToProvider(
        method: UserMethod.magic_auth_generate_id_token,
        params: [params]).then((jsMsg) {
      var relayerResponse = RelayerResponse<String>.fromJson(
          json.decode(jsMsg.message), (json) => json as String);
      return relayerResponse.response.result;
    });
  }

  /// Returns [Future] of [UserInfo], Retrieves information for the authenticated user.
  Future<UserInfo> getInfo() async {
    return sendToProvider(method: UserMethod.magic_get_info)
        .then((jsMsg) {
      var relayerResponse = RelayerResponse<UserInfo>.fromJson(
          json.decode(jsMsg.message),
          (json) => UserInfo.fromJson(json as Map<String, dynamic>));
      return relayerResponse.response.result;
    });
  }

  /// Returns [Future] of [bool], which denotes if user has already logged in, or not.
  Future<bool> isLoggedIn() async {
    return sendToProvider(method: UserMethod.magic_auth_is_logged_in)
        .then((jsMsg) {
      var relayerResponse = RelayerResponse<bool>.fromJson(
          json.decode(jsMsg.message), (json) => json as bool);
      return relayerResponse.response.result;
    });
  }

  /// Returns [Future] of [bool], Initiates the update email flow that
  /// allows a user to change their email address and returns if the update is successful
  Future<bool> updateEmail({required String email, bool showUI = true}) async {
    var params = {'email': email, 'showUI': showUI};

    return sendToProvider(
        method: UserMethod.magic_auth_update_email,
        params: [params]).then((jsMsg) {
      var relayerResponse = RelayerResponse<bool>.fromJson(
          json.decode(jsMsg.message), (json) => json as bool);
      return relayerResponse.response.result;
    });
  }

  /// Returns [Future] of [bool], Logs out the currently authenticated Magic user
  Future<bool> logout() async {
    return sendToProvider(method: UserMethod.magic_auth_logout).then((jsMsg) {
      var relayerResponse = RelayerResponse<bool>.fromJson(
          json.decode(jsMsg.message), (json) => json as bool);
      return relayerResponse.response.result;
    });
  }

  /// Returns [Future] of [bool], Reveals the user's private key
  Future<bool> revealPrivateKey() async {
    return sendToProvider(method: UserMethod.magic_reveal_key).then((jsMsg) {
      var relayerResponse = RelayerResponse<bool>.fromJson(
          json.decode(jsMsg.message), (json) => json as bool);
      return relayerResponse.response.result;
    })
  }
}
