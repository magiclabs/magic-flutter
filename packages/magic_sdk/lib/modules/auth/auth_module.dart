import 'dart:async';
import 'dart:convert';

import '../../magic_sdk.dart';
import '../../provider/rpc_provider.dart';
import '../../provider/types/relayer_response.dart';
import '../base_module.dart';

part 'auth_method.dart';

/// Allows users to login with magic link.
/// pass `email`, and `showUI` to true to show out of the box loading UI,
/// Upon successful login, returns
/// [Future] of [String].
class AuthModule extends BaseModule {
  /// constructor
  AuthModule(RpcProvider provider) : super(provider);

  /// Login with magic link
  Future<String> loginWithMagicLink({ required String email, bool showUI = true}) async {
    var params = {
      'email': email,
      'showUI': showUI
    };
    return sendToProvider(method: AuthMethod.magic_auth_login_with_magic_link.toShortString(), params: [params]).then((jsMsg) {
      var relayerResponse = RelayerResponse<String>.fromJson(json.decode(jsMsg.message), (json) => json as String);
      return relayerResponse.response.result;
    });
  }
}


