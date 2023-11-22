import 'package:flutter/material.dart';

import 'package:magic_sdk/magic_sdk.dart';
import 'package:magic_ext_oidc/magic_ext_oidc.dart';
import 'package:magic_ext_oidc/types/open_id_configuration.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Magic magic = Magic.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Magic OIDC Demo Login'),
          automaticallyImplyLeading: false,
        ),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
            onPressed: () async {
              var configuration = OpenIdConfiguration(
                jwt: 'JWT_FROM_YOUR_OPEN_ID PROVIDER',
                providerId:'YOUR_MAGIC_PROVIDER_ID');

              var did = await magic.openid.loginWithOIDC(configuration);

              debugPrint('Your DID is: $did');
            },
            child: const Text('OIDC Login'),
          ),
        ])));
  }
}
