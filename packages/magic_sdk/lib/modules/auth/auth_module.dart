import 'dart:async';
import 'dart:convert';

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
  Future<String> loginWithMagicLink(
      {required String email, bool showUI = true}) async {
    var params = {'email': email, 'showUI': showUI};
    return sendToProvider(
        method: AuthMethod.magic_auth_login_with_magic_link.toShortString(),
        params: [params]).then((jsMsg) {
      var relayerResponse = RelayerResponse<String>.fromJson(
          json.decode(jsMsg.message), (json) => json as String);
      return relayerResponse.response.result;
    });
  }

  /// Login with SMS
  Future<String> loginWithSMS({required String phoneNumber}) async {
    var params = {'phoneNumber': phoneNumber, 'showUI': true};
    return sendToProvider(
        method: AuthMethod.magic_auth_login_with_sms.toShortString(),
        params: [params]).then((jsMsg) {
      var relayerResponse = RelayerResponse<String>.fromJson(
          json.decode(jsMsg.message), (json) => json as String);
      return relayerResponse.response.result;
    });
  }

  /// Login with Email OTP
  Future<String> loginWithEmailOTP({required String email}) async {
    var params = {'email': email};
    return sendToProvider(
        method: AuthMethod.magic_auth_login_with_email_otp.toShortString(),
        params: [params]).then((jsMsg) {
      var relayerResponse = RelayerResponse<String>.fromJson(
          json.decode(jsMsg.message), (json) => json as String);
      return relayerResponse.response.result;
    });
  }
}
