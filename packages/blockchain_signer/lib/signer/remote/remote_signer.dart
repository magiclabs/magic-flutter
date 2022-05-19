import 'dart:typed_data';
import 'package:blockchain_signer/signer/sign_result.dart';
import 'package:blockchain_signer/signer/signer.dart';

/// Remote Sign
/// A remote signer layer that provides signature service from non-custodial key management solutions
abstract class RemoteSigner extends Signer {

  @override
  Future<SignResult> sign(String op, Uint8List bytes);

  @override
  Future<String> get publicKey;

  @override
  Future<String> get address;

  @override
  Future<String> get secretKey;

  // <Bool>verifySignature
}

