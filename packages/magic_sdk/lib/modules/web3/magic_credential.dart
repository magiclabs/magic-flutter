import 'dart:typed_data';

import '../../provider/rpc_provider.dart';

import 'package:web3dart/credentials.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

/// MagicCredential class to
class MagicCredential extends CredentialsWithKnownAddress
    implements CustomTransactionSender {
  /// The provider that relays requests to the relayer
  RpcProvider provider;

  @override
  late EthereumAddress address;

  MagicCredential(this.provider);

  @override

  /// An override to the signToSignature, but it's not supported
  /// as the signing is done in the relayer.
  Future<MsgSignature> signToSignature(Uint8List payload,
      {int? chainId, bool? isEIP1559}) {
    throw UnsupportedError('Not supported');
  }

  @override

  /// An override to the signPersonalMessage, personal sign would do the same
  /// trick without the necessity of chainId
  Future<Uint8List> signPersonalMessage(Uint8List payload, {int? chainId}) {
    throw UnsupportedError('Please use "MagicCredential.personalSign" method');
  }

  /// Personal Sign
  Future<String> personalSign({required Uint8List payload}) {
    return _makeRPCCall<String>(
        'personal_sign', [_bytesToData(payload), address.hex]);
  }

  /// Eth Sign
  Future<String> ethSign({required Uint8List payload}) {
    return _makeRPCCall<String>(
        'eth_sign', [address.hex, _bytesToData(payload)]);
  }

  /// SignTypedDataV1
  Future<String> signTypedDataLegacy({required Map payload}) {
    return _makeRPCCall<String>('eth_signTypedData', [
      [payload]
    ]);
  }

  /// SignTypedDataV3
  Future<String> signTypedData({required Map payload}) {
    return _makeRPCCall<String>('eth_signTypedData_v3', [address.hex, payload]);
  }

  /// Get account needs to be called to initiate account field.
  Future<EthereumAddress> getAccount() {
    return _makeRPCCall<List<dynamic>>('eth_accounts', []).then((list) {
      address = EthereumAddress.fromHex(list.first);
      return address;
    });
  }

  /// SendTransaction
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

  /// Provider call wrapper to parse result
  Future<T> _makeRPCCall<T>(String function, [List<dynamic>? params]) async {
    try {
      final data = await provider.call(function, params);
      if (data is Error || data is Exception) throw data;

      return data.result as T;
    } catch (e) {
      rethrow;
    }
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
