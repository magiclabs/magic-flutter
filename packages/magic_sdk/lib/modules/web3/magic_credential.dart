import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:magic_sdk/provider/rpc_provider.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/src/crypto/secp256k1.dart';
import 'package:web3dart/web3dart.dart';

class MagicCredential extends CredentialsWithKnownAddress implements CustomTransactionSender {

  RpcProvider provider;

  @override
  late EthereumAddress address;

  MagicCredential(this.provider);

  @override
  Future<MsgSignature> signToSignature(Uint8List payload, {int? chainId}) {
    // TODO: implement signToSignature
    throw UnimplementedError();
  }

  Future<EthereumAddress> getAccount() {
    return _makeRPCCall<List<dynamic>>('eth_accounts', []).then((list) {
      address = EthereumAddress.fromHex(list.first);
      return address;
    });
  }

  Future<T> _makeRPCCall<T>(String function, [List<dynamic>? params]) async {
    try {
      final data = await provider.call(function, params);
      if (data is Error || data is Exception) throw data;

      return data.result as T;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> sendTransaction(Transaction transaction) {
    final param = {
      "from": (transaction.from ?? address).hex,
      "to": transaction.to?.hex,
      "gasPrice": _bigIntToQuantity(transaction.gasPrice?.getInWei),
      "gas": _intToQuantity(transaction.maxGas),
      "value": _bigIntToQuantity(transaction.value?.getInWei),
      "data": _bytesToData(transaction.data)
    };

    return _makeRPCCall<String>('eth_sendTransaction', [param]);
  }
}

String? _bigIntToQuantity(BigInt? int) {
  return int != null ? '0x${int.toRadixString(16)}' : null;
}

String? _intToQuantity(int? int) {
  return int != null ? '0x${int.toRadixString(16)}' : null;
}

Uint8List _responseToBytes(dynamic response) {
  return hexToBytes(response as String);
}

String? _bytesToData(Uint8List? data) {
  return data != null
      ? bytesToHex(data, include0x: true, padToEvenLength: true)
      : null;
}
