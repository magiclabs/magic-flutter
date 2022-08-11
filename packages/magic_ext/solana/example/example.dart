import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:magic_sdk/magic_sdk.dart';
import 'package:magic_ext_solana/magic_ext_solana.dart';
import 'package:magic_sdk/modules/user/user_response_type.dart';
import 'package:solana/solana.dart';

class SolanaPage extends StatefulWidget {
  const SolanaPage({Key? key}) : super(key: key);

  @override
  State<SolanaPage> createState() => _SolanaPageState();
}

class _SolanaPageState extends State<SolanaPage> {
  final magic = Magic.instance;
  // final client = SolanaClient(rpcUrl: rpcUrl, websocketUrl: websocketUrl)

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        /// get public address
        ElevatedButton(
          onPressed: () async {
            List<int> list = utf8.encode("hello world");
            Uint8List message = Uint8List.fromList(list);
            var signature = await magic.solana.signMessage(message);
            print(signature);
          },
          child: const Text('Sign Message'),
        ),

        /// get public address
        ElevatedButton(
          onPressed: () async {
            UserMetadata metadata = await magic.user.getMetadata();
            Ed25519HDPublicKey solanaWallet =
                Ed25519HDPublicKey.fromBase58(metadata.publicAddress!);
            var instruction = SystemInstruction.transfer(
                fundingAccount: solanaWallet,
                recipientAccount: solanaWallet,
                lamports: 1);
            var signature = await magic.solana
                .signTransaction([instruction], instruction.accounts);
            print(signature);
          },
          child: const Text('Sign Transaction'),
        ),
      ])),
    );
  }
}
