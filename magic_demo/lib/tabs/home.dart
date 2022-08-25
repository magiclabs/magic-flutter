import 'package:flutter/material.dart';
import 'package:magic_demo/tabs/web3.dart';
import 'package:magic_demo/tabs/tezos.dart';
import 'package:magic_demo/tabs/solana.dart';
import 'package:magic_sdk/magic_sdk.dart';

import 'magic.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Magic magic = Magic.instance;

  final myController = TextEditingController(text: 'your.email@example.com');

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
        title: const Text('Home'),
        bottom: const TabBar(
          tabs: [
            Tab(icon: Icon(Icons.portrait)),
            Tab(icon: Icon(Icons.account_balance_wallet_rounded)),
          ]
        )
      ),
      body: const TabBarView(
        children: [
          MagicPage(),
          Web3Page(),
          // TezosPage(),
          // SolanaPage()
        ]
      ),
    )
    );
  }
}
