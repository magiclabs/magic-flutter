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

  // @override
  // Future<void> initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedButton(
              onPressed: () async {
                var cred = await credential.getAccount();
                showResult(context, "account, ${cred.hex}");
              },
              child: const Text('getAccount'),
            ),
            ElevatedButton(
              onPressed: () async {
                var hash = await client.sendTransaction(credential, Transaction(
                  to: EthereumAddress.fromHex('0x01568bf1c1699bb9d58fac67f3a487b28ab4ab2d'),
                  gasPrice: EtherAmount.inWei(BigInt.two),
                  maxGas: 100000,
                  value: EtherAmount.fromUnitAndValue(EtherUnit.gwei, 2),
                ),);
                showResult(context, "transaction, $hash");
              },
              child: const Text('sendTransaction'),
            ),
            ElevatedButton(
              onPressed: () async {
                var balance = await client.getBalance(credential.address);
                showResult(context, "balance, ${balance.toString()}");
              },
              child: const Text('getBalance'),
            ),
            ElevatedButton(
              onPressed: () async {
                var id = await client.getNetworkId();
                showResult(context, "network id, $id");
              },
              child: const Text('network Id'),
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
