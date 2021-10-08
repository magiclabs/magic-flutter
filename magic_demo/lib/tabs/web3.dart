import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:magic_demo/login.dart';
import 'package:magic_sdk/magic_sdk.dart';
import 'package:magic_sdk/modules/web3/magic_credential.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web3dart/crypto.dart';

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
        /// get account
        ElevatedButton(
          onPressed: () async {
            var cred = await credential.getAccount();
            showResult(context, "account, ${cred.hex}");
          },
          child: const Text('getAccount'),
        ),

        /// send Transaction
        ElevatedButton(
          onPressed: () async {
            var hash = await client.sendTransaction(
              credential,
              Transaction(
                to: EthereumAddress.fromHex(
                    '0x01568bf1c1699bb9d58fac67f3a487b28ab4ab2d'),
                gasPrice: EtherAmount.inWei(BigInt.two),
                maxGas: 100000,
                value: EtherAmount.fromUnitAndValue(EtherUnit.gwei, 2),
              ),
            );
            showResult(context, "transaction, $hash");
          },
          child: const Text('sendTransaction'),
        ),

        /// get balance
        ElevatedButton(
          onPressed: () async {
            var balance = await client.getBalance(credential.address);
            showResult(context, "balance, ${balance.toString()}");
          },
          child: const Text('getBalance'),
        ),

        /// network id
        ElevatedButton(
          onPressed: () async {
            var id = await client.getNetworkId();
            showResult(context, "network id, $id");
          },
          child: const Text('network Id'),
        ),

        /// eth sign
        ElevatedButton(
          onPressed: () async {
            List<int> list = utf8.encode("hello world");
            Uint8List payload = Uint8List.fromList(list);
            var signature = await credential.ethSign(payload);
            showResult(context, "eth_sign signature, $signature");
          },
          child: const Text('eth sign'),
        ),

        /// Personal Sign
        ElevatedButton(
          onPressed: () async {
            List<int> list = utf8.encode("hello world");
            Uint8List payload = Uint8List.fromList(list);
            var signature = await credential.personalSign(payload);
            showResult(context, "personal sign signature, $signature");
          },
          child: const Text('personal sign'),
        ),

        /// Sign Typed Data V1
        ElevatedButton(
          onPressed: () async {
            var payload = {
              "type": "string",
              "name": "Hello from Magic Labs",
              "value": "This message will be assigned by you"
            };
            var signature = await credential.signTypedDataLegacy(payload);
            showResult(context, "sign Typed Data V1 signature, $signature");
          },
          child: const Text('sign Typed Data V1'),
        ),

        /// Sign Typed Data V3
        ElevatedButton(
          onPressed: () async {
            var signature = await credential.signTypedData(signTypedDataV3Payload);
            showResult(context, "sign Typed Data V3 signature, ${(signature)}");
          },
          child: const Text('sign Typed Data V3'),
        ),
      ])),
    );
  }
}

var signTypedDataV3Payload = {
  "types": {
    "EIP712Domain": [
      {"name": "name", "type": "string"},
      {"name": "version", "type": "string"},
      {"name": "verifyingContract", "type": "address"}
    ],
    "Order": [
      {"name": "makerAddress", "type": "address"},
      {"name": "takerAddress", "type": "address"},
      {"name": "feeRecipientAddress", "type": "address"},
      {"name": "senderAddress", "type": "address"},
      {"name": "makerAssetAmount", "type": "uint256"},
      {"name": "takerAssetAmount", "type": "uint256"},
      {"name": "makerFee", "type": "uint256"},
      {"name": "takerFee", "type": "uint256"},
      {"name": "expirationTimeSeconds", "type": "uint256"},
      {"name": "salt", "type": "uint256"},
      {"name": "makerAssetData", "type": "bytes"},
      {"name": "takerAssetData", "type": "bytes"}
    ]
  },
  "domain": {
    "name": "0x Protocol",
    "version": "2",
    "verifyingContract":
    "0x35dd2932454449b14cee11a94d3674a936d5d7b2"
  },
  "message": {
    "exchangeAddress": "0x35dd2932454449b14cee11a94d3674a936d5d7b2",
    "senderAddress": "0x0000000000000000000000000000000000000000",
    "makerAddress": "0x338be8514c1397e8f3806054e088b2daf1071fcd",
    "takerAddress": "0x0000000000000000000000000000000000000000",
    "makerFee": "0",
    "takerFee": "0",
    "makerAssetAmount": "97500000000000",
    "takerAssetAmount": "15000000000000000",
    "makerAssetData":
    "0xf47261b0000000000000000000000000d0a1e359811322d97991e03f863a0c30c2cf029c",
    "takerAssetData":
    "0xf47261b00000000000000000000000006ff6c0ff1d68b964901f986d4c9fa3ac68346570",
    "salt": "1553722433685",
    "feeRecipientAddress":
    "0xa258b39954cef5cb142fd567a46cddb31a670124",
    "expirationTimeSeconds": "1553808833"
  },
  "primaryType": "Order"
};
