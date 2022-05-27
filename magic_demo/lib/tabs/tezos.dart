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
  final tezosSigner = Magic.instance.tezos;
  final client = TezartClient('https://ithacanet.smartpy.io/');

  @override
  void initState () {
    super.initState();
    tezosSigner.fetchRemoteSigner();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            /// get public address
            ElevatedButton(
              onPressed: () async {
                String? address = tezosSigner.publicKey;
                print(address);
              },
              child: const Text('Public Key'),
            ),
            /// send Transaction
            ElevatedButton(
              onPressed: () async {
                final operationsList = await client.transferOperation(
                  source: Keystore.fromRemoteSigner(tezosSigner),
                  destination: tezosSigner.address,
                  amount: 10001,
                );
                await operationsList.executeAndMonitor();
              },
              child: const Text('send Transaction'),
            ),
            /// Deposit
            ElevatedButton(
              onPressed: () async {
                const amount = 100;
                final operationsList = await client.transferOperation(
                  source: Keystore.fromSecretKey('edskRpm2mUhvoUjHjXgMoDRxMKhtKfww1ixmWiHCWhHuMEEbGzdnz8Ks4vgarKDtxok7HmrEo1JzkXkdkvyw7Rtw6BNtSd7MJ7'), // private key from tezart
                  destination: tezosSigner.address,
                  amount: amount,
                );
                await operationsList.executeAndMonitor();
              },
              child: const Text('deposit'),
            ),
            /// Get balance
            ElevatedButton(
              onPressed: () async {
                final balance = await client.getBalance(address: tezosSigner.address);
                print('balance for ${tezosSigner.address}, $balance');
              },
              child: const Text('get balance'),
            ),
          ])),
    );
  }
}
