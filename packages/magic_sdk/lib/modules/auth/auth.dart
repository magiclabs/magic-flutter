import 'package:magic_sdk/magic_sdk.dart';
import 'package:magic_sdk/modules/auth/auth_methods.dart';
import 'package:magic_sdk/provider/rpc_provider.dart';
import 'package:magic_sdk/provider/rpc_request.dart';

import '../base_module.dart';
export 'package:magic_sdk/magic_sdk.dart';

/// Allows users to login with magic link.
/// pass `email`, and `showLoadingUI` to true to show out of the box loading UI,
/// Upon successful login, returns
/// [Future] of [String].
class AuthModule extends BaseModule {
  /// constructor
  AuthModule(RpcProvider provider) : super(provider);

  /// Login with magic link
  Future<String> loginWithMagicLink({ required String email, bool? showUI = true}) async {
    var params = {
      email: email,
      showUI: showUI
    };
    RPCRequest request = RPCRequest(method: AuthMethod.magicAuthLoginWithMagicLink.toString(), params: [params]);
    return provider.send(request: request);
    return '';
  }
}
