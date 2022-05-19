import 'package:flutter/material.dart';
import 'package:magic_sdk/magic_sdk.dart';
import 'package:tezart/tezart.dart';
import 'package:magic_ext_tezos/magic_ext_tezos.dart';

class TezosPage extends StatefulWidget {
  const TezosPage({Key? key}) : super(key: key);

  @override
  State<TezosPage> createState() => _TezosPageState();
}

class _TezosPageState extends State<TezosPage> {
  final magic = Magic.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            /// get account
            ElevatedButton(
              onPressed: () async {
                final client = TezartClient.signer('https://ithacanet.smartpy.io/', magic.tezos);
                final amount = 10001;
                final sourceKeystore = Keystore.random();
                final destinationKeystore = Keystore.random();
                final operationsList = await client.transferOperation(
                  source: sourceKeystore,
                  destination: destinationKeystore.address,
                  amount: amount,
                );
                await operationsList.executeAndMonitor();
                print(await client.getBalance(address: sourceKeystore.address));
              },
              child: const Text('send Transaction'),
            ),
          ])),
    );
  }
}
