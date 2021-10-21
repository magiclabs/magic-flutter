import 'dart:math';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class OAuthChallenge {
  String state = createRandomString(128);
  String verifier = createRandomString(128);
  late String challenge;

  OAuthChallenge() {
    // SHA256 encrypt and encode to base64
    var base64Str = base64Encode(sha256.convert(utf8.encode(verifier)).bytes);
    challenge = base64Str.replaceAll('+', '-').replaceAll('/', '_').replaceAll('=', '');
  }
}

String createRandomString(int length) {
  const letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~";
  Random _rnd = Random();
  return String.fromCharCodes(Iterable.generate(
      length, (_) => letters.codeUnitAt(_rnd.nextInt(letters.length))));
}
