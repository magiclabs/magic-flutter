import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:magic_demo/login.dart';
import 'package:magic_sdk/magic_sdk.dart';

import '../alert.dart';

class MagicPage extends StatefulWidget {
  const MagicPage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MagicPage> createState() => _MagicPageState();
}

class _MagicPageState extends State<MagicPage> {
  Magic magic = Magic.instance;

  final myController = TextEditingController(text: 'your.email@example.com');

  @override
  Widget build(BuildContext context) {
    final jsonEncoder = JsonEncoder();

    return Scaffold(
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        ElevatedButton(
          onPressed: () async {
            var isLoggedIn = await magic.user.isLoggedIn();
            showResult(context, "isLoggedIn, $isLoggedIn");
          },
          child: const Text('isLoggedIn'),
        ),
        ElevatedButton(
          onPressed: () async {
            var info = await magic.user.getInfo();
            print(info.publicAddress);
            showResult(context, "info: ${jsonEncoder.convert(info)}");
          },
          child: const Text('getInfo'),
        ),
        ElevatedButton(
          onPressed: () async {
            var token = await magic.user.getIdToken();
            showResult(context, "token, $token");
          },
          child: const Text('getIdToken'),
        ),
        ElevatedButton(
          onPressed: () async {
            var token = await magic.user.generateIdToken();
            showResult(context, "token, $token");
          },
          child: const Text('generateIdToken'),
        ),
        ElevatedButton(
          onPressed: () async {
            var isUpdated =
                await magic.user.updateEmail(email: "jerry@fortmatic.com");
            showResult(context, "isEmailUpdated, $isUpdated");
          },
          child: const Text('updateEmail'),
        ),
        ElevatedButton(
          onPressed: () async {
            var isLoggedOut = await magic.user.logout();
            if (isLoggedOut) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            }
          },
          child: const Text('logout'),
        ),
      ])),
    );
  }
}
