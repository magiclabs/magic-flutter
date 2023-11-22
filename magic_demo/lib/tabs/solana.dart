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
  final client = RpcClient('https://api.devnet.solana.com');

  @override
  void initState () {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text('Solana', style: TextStyle(fontSize: 30)),
            /// get public address
            ElevatedButton(
              onPressed: () async {
                List<int> list = utf8.encode("hello world");
                Uint8List message = Uint8List.fromList(list);
                var signature = await magic.solana.signMessage(message);
                print("signature: $signature");
              },
              child: const Text('Sign Message'),
            ),
            /// get public address
            ElevatedButton(
              onPressed: () async {

                // Get public key
                UserInfo info = await magic.user.getInfo();

                // Construct an instruction
                Ed25519HDPublicKey solanaWallet = Ed25519HDPublicKey.fromBase58(info.publicAddress!);
                var instruction = SystemInstruction.transfer(fundingAccount: solanaWallet, recipientAccount: solanaWallet, lamports: 1);

                // recentBlockhash
                var recentBlockhash = await client.getRecentBlockhash();

                // Message of instructions
                var message = Message.only(instruction);

                // Sign Transaction Remotely using Magic Auth
                var transactionSignature = await magic.solana.signTransaction(
                    recentBlockhash.value,
                    message,
                    instruction.accounts
                );

                // Create Base64 string from the signature
                var signature = await client.sendTransaction(
                    transactionSignature.encode()
                );

                print("signature: $signature");
              },
              child: const Text('Sign Transaction'),
            ),
            ElevatedButton(
              onPressed: () async {

                var sampleSigner = await Ed25519HDKeyPair.random();

                final instruction = SystemInstruction.transfer(
                  fundingAccount: sampleSigner.publicKey,
                  recipientAccount: sampleSigner.publicKey,
                  lamports: 1,
                );

                // recentBlockhash
                var recentBlockhashWithCommitment = await client.getRecentBlockhash(commitment: Commitment.confirmed);

                final tx = await signTransaction(
                  recentBlockhashWithCommitment.value,
                  Message(instructions: [instruction]),
                  [sampleSigner],
                );

                debugPrint('tx encode, ${tx.encode()}');
                debugPrint('tx encode list, ${tx.signatures.toList()}');

                final signature = await client.sendTransaction(
                  tx.encode()
                );

                print("signature: $signature");
              },
              child: const Text('Original Sign Transaction'),
            ),
          ])),
    );
  }
}
