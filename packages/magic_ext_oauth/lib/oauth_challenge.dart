import 'dart:math';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class OAuthChallenge {
  String get state => createRandomString(128);
  String get verifier => createRandomString(128);
  late String challenge;

  OAuthChallenge() {
    var base64Str = sha256.convert(utf8.encode(verifier)).toString();
    challenge = base64Str.replaceAll('+', '-').replaceAll('/', '_').replaceAll('=', '');
  }
}

String createRandomString(int length) {
  const letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~";
  Random _rnd = Random();
  return String.fromCharCodes(Iterable.generate(
      length, (_) => letters.codeUnitAt(_rnd.nextInt(letters.length))));
}
