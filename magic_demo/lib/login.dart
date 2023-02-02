import 'package:flutter/material.dart';
import 'package:magic_demo/tabs/home.dart';

import 'package:magic_sdk/magic_sdk.dart';
import 'package:magic_ext_oauth/magic_ext_oauth.dart';

import 'alert.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Magic magic = Magic.instance;

  final emailInput = TextEditingController(text: 'your.email@example.com');
  final phoneNumberInput = TextEditingController(text: '+18888888888');
  String dropdownValue = 'google';

  @override
  void initState() {
    super.initState();
    var future = magic.user.isLoggedIn();
    future.then((isLoggedIn) {
      if (isLoggedIn) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Magic Demo Login'),
          automaticallyImplyLeading: false,
        ),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: TextFormField(
              controller: emailInput,
              decoration: const InputDecoration(
                hintText: 'Enter your email',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
          ),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
            onPressed: () async {
              var token =
                  await magic.auth.loginWithMagicLink(email: emailInput.text);
              showResult(context, 'token, $token');

              if (token.isNotEmpty) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              }
            },
            child: const Text('Login With Magic Link'),
          ),
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    onPressed: () async {
                      var token =
                      await magic.auth.loginWithEmailOTP(email: emailInput.text);
                      showResult(context, 'token, $token');

                      if (token.isNotEmpty) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const HomePage()));
                      }
                    },
                    child: const Text('Login With Email OTP'),
                  ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: TextFormField(
              controller: phoneNumberInput,
              decoration: const InputDecoration(
                hintText: 'Enter your phone number',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Enter your phone number';
                }
                return null;
              },
            ),
          ),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
            onPressed: () async {
              var token =
                  await magic.auth.loginWithSMS(phoneNumber: phoneNumberInput.text);
              showResult(context, 'token, $token');

              if (token.isNotEmpty) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              }
            },
            child: const Text('Login With SMS'),
          ),
          DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
            items: OAuthProvider.values
                .map<DropdownMenuItem<String>>((OAuthProvider value) {
              return DropdownMenuItem<String>(
                value: value.toShortString(),
                child: Text(value.toShortString().toUpperCase()),
              );
            }).toList(),
          ),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
            onPressed: () async {
              var configuration = OAuthConfiguration(
                  provider: OAuthProvider.values.firstWhere((element) => element.toString().toLowerCase() == 'OAuthProvider.$dropdownValue'.toLowerCase()),
                  redirectURI: 'link.magic.demo://');
              var result = await magic.oauth.loginWithPopup(configuration);


              if (result.magic!.userMetadata!.email != null || result.magic!.idToken != null) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              }
              showResult(context,
                  'publicAddress, ${result.magic!.userMetadata!.publicAddress}');
            },
            child: const Text('Social Login'),
          ),
        ])));
  }
}
