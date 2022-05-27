import 'dart:typed_data';
import 'package:blockchain_signer/signer/signer.dart';
import '../response/sign_result.dart';

/// Remote Sign
/// A remote signer layer that provides signature service from non-custodial key management solutions
abstract class RemoteSigner extends Signer {

  @override
  Future<SignResult> sign(String op, Uint8List bytes);

  @override
  String? get publicKey;

  @override
  String? get address;

  @override
  String? get secretKey;

  // <Bool>verifySignature
}

