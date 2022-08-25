import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:magic_sdk/magic_sdk.dart';
import 'package:web3dart/web3dart.dart';

import '../alert.dart';

class Web3Page extends StatefulWidget {
  const Web3Page({Key? key}) : super(key: key);

  @override
  State<Web3Page> createState() => _Web3PageState();
}

class _Web3PageState extends State<Web3Page> {
  final magic = Magic.instance;

  final client = Web3Client.custom(Magic.instance.provider);
  final credential = MagicCredential(Magic.instance.provider);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text('ETH', style: TextStyle(fontSize: 30)),
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
            var signature = await credential.ethSign(payload: payload);
            showResult(context, "eth_sign signature, $signature");
          },
          child: const Text('eth sign'),
        ),

        /// Personal Sign
        ElevatedButton(
          onPressed: () async {
            List<int> list = utf8.encode("hello world");
            Uint8List payload = Uint8List.fromList(list);
            var signature = await credential.personalSign(payload: payload);
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
            var signature =
                await credential.signTypedDataLegacy(payload: payload);
            showResult(context, "sign Typed Data V1 signature, $signature");
          },
          child: const Text('sign Typed Data V1'),
        ),

        /// Sign Typed Data V3
        ElevatedButton(
          onPressed: () async {
            var signature =
                await credential.signTypedData(payload: signTypedDataV3Payload);
            showResult(context, "sign Typed Data V3 signature, ${(signature)}");
          },
          child: const Text('sign Typed Data V3'),
        ),

        /// Contract
        ///
        /// Contract read
        ElevatedButton(
          onPressed: () async {
            final contract = DeployedContract(
                ContractAbi.fromJson(TestContract.contractAbi, ''),
                TestContract.deployedAddress);
            final messageFunction = contract.function('message');
            var message = await client.call(
                contract: contract, function: messageFunction, params: []);
            showResult(context, "Contract Read Message, $message");
          },
          child: const Text('Contract read'),
        ),

        /// Contract write
        ElevatedButton(
          onPressed: () async {
            final contract = DeployedContract(
                ContractAbi.fromJson(TestContract.contractAbi, ''),
                TestContract.deployedAddress);
            final updateFunction = contract.function('update');
            var message = await client.sendTransaction(
                credential,
                Transaction.callContract(
                    contract: contract,
                    function: updateFunction,
                    parameters: ["NEW_MESSAGE"]));
            showResult(context, "Contract write, ${(message)}");
          },
          child: const Text('Contract write'),
        ),

        /// Deploy Contract
        ElevatedButton(
          onPressed: () async {
            var list = utf8.encode(TestContract.byteCode);
            Uint8List payload = Uint8List.fromList(list);
            final Transaction transaction = Transaction(
                to: null,
                from: credential.address,
                data: payload,
                maxGas: 2000000);
            final String transactionId =
                await client.sendTransaction(credential, transaction);
            showResult(context, "Deploy Contract, $transactionId");
          },
          child: const Text('deploy Contract'),
        ),
      ])),
    );
  }
}

class TestContract {
  static final deployedAddress =
      EthereumAddress.fromHex("0x8b211dfebf490a648f6de859dfbed61fa22f35e0");
  static const contractAbi =
      '[{"constant":false,"inputs":[{"name":"newMessage","type":"string"}],"name":"update","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"message","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"inputs":[{"name":"initMessage","type":"string"}],"payable":false,"stateMutability":"nonpayable","type":"constructor"}]';
  static const byteCode =
      "0x608060405234801561001057600080fd5b5060405161047f38038061047f8339818101604052602081101561003357600080fd5b81019080805164010000000081111561004b57600080fd5b8281019050602081018481111561006157600080fd5b815185600182028301116401000000008211171561007e57600080fd5b5050929190505050806000908051906020019061009c9291906100a3565b5050610148565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f106100e457805160ff1916838001178555610112565b82800160010185558215610112579182015b828111156101115782518255916020019190600101906100f6565b5b50905061011f9190610123565b5090565b61014591905b80821115610141576000816000905550600101610129565b5090565b90565b610328806101576000396000f3fe608060405234801561001057600080fd5b5060043610610053576000357c0100000000000000000000000000000000000000000000000000000000900480633d7403a314610058578063e21f37ce14610113575b600080fd5b6101116004803603602081101561006e57600080fd5b810190808035906020019064010000000081111561008b57600080fd5b82018360208201111561009d57600080fd5b803590602001918460018302840111640100000000831117156100bf57600080fd5b91908080601f016020809104026020016040519081016040528093929190818152602001838380828437600081840152601f19601f820116905080830192505050505050509192919290505050610196565b005b61011b6101b0565b6040518080602001828103825283818151815260200191508051906020019080838360005b8381101561015b578082015181840152602081019050610140565b50505050905090810190601f1680156101885780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b80600090805190602001906101ac92919061024e565b5050565b60008054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156102465780601f1061021b57610100808354040283529160200191610246565b820191906000526020600020905b81548152906001019060200180831161022957829003601f168201915b505050505081565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f1061028f57805160ff19168380011785556102bd565b828001600101855582156102bd579182015b828111156102bc5782518255916020019190600101906102a1565b5b5090506102ca91906102ce565b5090565b6102f091905b808211156102ec5760008160009055506001016102d4565b5090565b9056fea265627a7a7230582003ae1ef5a63bf058bfd2b31398bdee39d3cbfbb7fbf84235f4bc2ec352ee810f64736f6c634300050a0032";
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
    "verifyingContract": "0x35dd2932454449b14cee11a94d3674a936d5d7b2"
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
    "feeRecipientAddress": "0xa258b39954cef5cb142fd567a46cddb31a670124",
    "expirationTimeSeconds": "1553808833"
  },
  "primaryType": "Order"
};
