import 'dart:async';

import 'package:magic_sdk/modules/base_module.dart';
import 'package:magic_sdk/modules/user/user_method.dart';
import 'package:magic_sdk/modules/user/user_response.dart';
import 'package:magic_sdk/provider/rpc_provider.dart';
export 'package:magic_sdk/magic_sdk.dart';

class UserModule extends BaseModule {
  UserModule(RpcProvider provider) : super(provider);

  /// Returns [Future] of [String], Generates a Decentralized Id Token which
  /// acts as a proof of authentication to resource servers.
  Future<String> getIdToken({int lifespan = 900}) async {
  var params = {
    'lifespan': lifespan,
  };
  return sendToProvider(method: UserMethod.magic_auth_get_id_token.toShortString(), params: params) as Future<String>;
}

  /// Returns [Future] of [String], which gets current
  Future<String> generateIdToken({int lifespan = 900, String attachment = 'none'}) async {
    var params = {
      'lifespan': lifespan,
      'attachment': attachment
    };
    return sendToProvider(method: UserMethod.magic_auth_generate_id_token.toShortString(), params: params) as Future<String>;
  }


  /// Returns [Future] of [bool], which denotes if user has already logged in, or not.
  Future<UserMetadata> getMetadata() async {

    return sendToProvider(method: UserMethod.magic_auth_get_metadata.toShortString()) as Future<UserMetadata>;
  }

  /// Returns [Future] of [bool], which denotes if user has already logged in, or not.
  Future<bool> isLoggedIn() async {

    return sendToProvider(method: UserMethod.magic_auth_is_logged_in.toShortString()) as Future<bool>;
  }

  /// Returns [Future] of [bool], which denotes if user has already logged in, or not.
  Future<bool> updateEmail({required String email, bool showUI = true}) async {
    var params = {
      'email': email,
      'showUI': showUI
    };

    return sendToProvider(method: UserMethod.magic_auth_is_logged_in.toShortString(), params: params) as Future<bool>;
  }

  /// Returns [Future] of [bool], which denotes if user has already logged in, or not.
  Future<bool> logout() async {

    return sendToProvider(method: UserMethod.magic_auth_logout.toShortString()) as Future<bool>;
  }
}
