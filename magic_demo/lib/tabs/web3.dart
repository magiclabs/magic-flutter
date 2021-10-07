import 'package:flutter/material.dart';
import 'package:magic_demo/login.dart';
import 'package:magic_sdk/magic_sdk.dart';
import 'package:magic_sdk/modules/web3/magic_credential.dart';
import 'package:web3dart/web3dart.dart';

import '../alert.dart';

class Web3Page extends StatefulWidget {
  const Web3Page({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<Web3Page> createState() => _Web3PageState();
}

class _Web3PageState extends State<Web3Page> {

  final magic = Magic.instance;

  final client = Web3Client.custom(Magic.instance.provider);
  final credential = MagicCredential(Magic.instance.provider);

  final myController = TextEditingController(text: 'jerry@magic.link');

  @override
  Widget build(BuildContext context) {

    @override
    initState(){
      super.initState();
      var account = credential.getAccount();
      debugPrint(account.toString());
    }

    return Scaffold(
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedButton(
              onPressed: () async {
                var cred = await credential.getAccount();
                debugPrint(cred.toString());
                // client.sendTransaction(cred, transaction);
              },
              child: const Text('getAccount'),
            ),
            ElevatedButton(
              onPressed: () async {
                var metadata = await magic.user.getMetadata();
                showResult(context, "metadata email, ${metadata.email}");
              },
              child: const Text('sendTransaction'),
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
