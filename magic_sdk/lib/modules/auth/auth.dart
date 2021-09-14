import 'package:magic_sdk/magic_sdk.dart';
import 'package:magic_sdk/provider/rpc_provider.dart';

import '../base_module.dart';
export 'package:magic_sdk/magic_sdk.dart';

/// Allows users to login with magic link.
/// pass `email`, and `showLoadingUI` to true to show out of the box loading UI,
/// Upon successful login, returns
/// [Future] of [String].
class AuthModule extends BaseModule {
  AuthModule(RpcProvider provider) : super(provider);

  // Future<String> loginWithMagicLink(
  // {required String email, required bool showLoadingUI}) async {
  // return await
  // }
}
