import 'package:flutter/material.dart';
import 'package:magic_sdk/magic_sdk.dart';
import 'package:magic_sdk/modules/blockchain/supported_blockchain.dart';

import 'login.dart';

void main() {
  runApp(const MyApp());

  Magic.instance = Magic.blockchain("YOUR_PUBLISHABLE_KEY", rpcUrl: "https://api.devnet.solana.com", chain: SupportedBlockchain.solana);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Magic Demo',
        home: Stack(children: [
          const LoginPage(),
          Magic.instance.relayer
    ]));
  }
}

