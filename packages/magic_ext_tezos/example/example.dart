import 'package:flutter/material.dart';
import 'package:magic_ext_tezos/magic_ext_tezos.dart';
import 'package:magic_sdk/magic_sdk.dart';
import 'package:tezart/tezart.dart';


class _TezosPageState extends State<TezosPage> {
  final tezosSigner = Magic.instance.tezos;
  final client = TezartClient('https://ithacanet.smartpy.io/');

  @override
  void initState() {
    super.initState();
    tezosSigner.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        /// get public address
        ElevatedButton(
          onPressed: () async {
            String? address = tezosSigner.address;
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

        /// Get balance
        ElevatedButton(
          onPressed: () async {
            final balance =
                await client.getBalance(address: tezosSigner.address);
            print('balance for ${tezosSigner.address}, $balance');
          },
          child: const Text('get balance'),
        ),
      ])),
    );
  }
}
