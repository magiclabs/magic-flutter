import 'package:magic_sdk/magic_sdk.dart';
import 'package:magic_sdk/modules/base_module.dart';
import 'package:magic_sdk/provider/rpc_provider.dart';
export 'package:magic_sdk/magic_sdk.dart';

/// Allows users to login with magic link.
/// pass `email`, and `showLoadingUI` to true to show out of the box loading UI,
/// Upon successful login, returns
/// [Future] of [String].
class UserModule extends BaseModule {
  UserModule(RpcProvider provider) : super(provider);

  // /// Returns [Future] of [bool], which denotes if user has already logged in, or not.
  // Void Future<bool> isLoggedIn() async {
  //   // return await
  // }
  //
  // /// Method to logout, if user is logged in. Returns [Future] of [bool] to denote,
  // /// whether user has successfully logged out.
  // Future<bool> logout() async {
  //   // return await
  // }
  //
  // /// Method to update email id of already logged in user. The method should
  // /// be used if user is already logged int.
  // Future<bool> updateEmail({required String email}) async {
  //   // return await
  // }

  // /// Method to get meta data of already logged in user. Returns
  // /// [Future] of [GetMetaDataResponse] on success.
  // static Future<GetMetaDataResponse> getMetaData() async {
  //   return await
  // }
}
