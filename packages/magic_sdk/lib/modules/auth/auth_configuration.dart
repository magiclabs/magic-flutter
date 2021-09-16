import 'package:magic_sdk/modules/base_configuration.dart';

class LoginWithMagicLinkConfiguration extends BaseConfiguration {
  String email;
  bool showUI;

  LoginWithMagicLinkConfiguration({required this.email, this.showUI = true});
}
