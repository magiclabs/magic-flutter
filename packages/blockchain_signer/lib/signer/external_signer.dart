import 'dart:typed_data';

abstract class ExternalSigner {

  Future<String> signAsync(String op, Uint8List bytes);
}
