import 'dart:typed_data';
import 'package:blockchain_signer/signer/sign_result.dart';

/// Basic Signer that provides developers with signing interfaces for any blockchain.
/// This is not yet the final version yet. Anything would be subjected to change
///
abstract class Signer {

  Future<SignResult> sign(String op, Uint8List bytes);

  Future<String> get publicKey;
  Future<String> get address;
  Future<String> get secretKey;

// <Bool>verifySignature
}

