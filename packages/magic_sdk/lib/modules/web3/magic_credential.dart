import 'dart:typed_data';

import 'package:magic_sdk/provider/rpc_provider.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/src/crypto/secp256k1.dart';

class MagicCredential extends CredentialsWithKnownAddress {

  RpcProvider provider;

  MagicCredential(this.provider);

  @override
  // TODO: implement address
  EthereumAddress get address => throw UnimplementedError();

  @override
  Future<MsgSignature> signToSignature(Uint8List payload, {int? chainId}) {
    // TODO: implement signToSignature
    throw UnimplementedError();
  }

  Future<EthereumAddress> getAccount() {
    return _makeRPCCall('eth_accounts', []);
  }

  Future<T> _makeRPCCall<T>(String function, [List<dynamic>? params]) async {
    try {
      final data = await provider.call(function, params);
      // ignore: only_throw_errors
      if (data is Error || data is Exception) throw data;

      return data.result as T;
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      rethrow;
    }
  }
}
