import 'dart:convert';
import 'dart:typed_data';

import 'package:pointycastle/export.dart';
import 'package:convert/convert.dart';
import 'package:uuid/uuid.dart';

final _alias = "link.magic.auth.dpop";

String base64UrlEncoded(List<int> data) {
  var b64 = base64.encode(data);
  b64 = b64.replaceAll('+', '-');
  b64 = b64.replaceAll('/', '_');
  b64 = b64.replaceAll('=', '');
  return b64;
}

// Function to convert BigInt to fixed-size byte array
Uint8List bigIntToBytes(BigInt number, int length) {
  var result = Uint8List(length);
  for (var i = length - 1; i >= 0; i--) {
    result[i] = number.toUnsigned(256).toInt() & 0xff;
    number = number >> 8;
  }
  return result;
}

Future<String?> createJwt() async {
  try {
    final keyParams = ECKeyGeneratorParameters(ECCurve_secp256r1());
    final random = FortunaRandom();
    random.seed(KeyParameter(Uint8List.fromList(List.generate(32, (_) => 0))));
    final keyGen = ECKeyGenerator()
      ..init(ParametersWithRandom(keyParams, random));
    final keyPair = keyGen.generateKeyPair();
    final ecPublicKey = keyPair.publicKey as ECPublicKey;
    final ecPrivateKey = keyPair.privateKey as ECPrivateKey;

    final xCoordinateHex = ecPublicKey.Q!.x!.toBigInteger()!.toRadixString(16);
    final yCoordinateHex = ecPublicKey.Q!.y!.toBigInteger()!.toRadixString(16);

    final xCoordinateData = hex.decode(xCoordinateHex);
    final yCoordinateData = hex.decode(yCoordinateHex);

    // If you need base64-encoded strings for JWK:
    final xCoordinateBase64 = base64UrlEncoded(xCoordinateData);
    final yCoordinateBase64 = base64UrlEncoded(yCoordinateData);

    // Convert the public key to JWK format.
    var headers = {
      "typ": "dpop+jwt",
      "alg": "ES256",
      "jwk": {
        "kty": "EC",
        "crv": "P-256",
        "x": xCoordinateBase64,
        "y": yCoordinateBase64
      }
    };

    final headersData = utf8.encode(json.encode(headers));
    final headersB64 = base64UrlEncoded(headersData);

    // construct claims
    final iat = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    var uuid = Uuid();
    final jti = uuid.v4().toLowerCase();

    final claims = {"iat": iat, "jti": jti};
    final claimsData = utf8.encode(json.encode(claims));
    final claimsB64 = base64UrlEncoded(claimsData);

    // sign
    final signingInput = headersB64 + "." + claimsB64;

    // Sign the data
    final signer = Signer("SHA-256/DET-ECDSA")
      ..init(true, PrivateKeyParameter<ECPrivateKey>(ecPrivateKey));
    final signature =
        signer.generateSignature(Uint8List.fromList(utf8.encode(signingInput)))
            as ECSignature;

    final rBytes =
        bigIntToBytes(signature.r, 32); // Convert BigInt to 32-byte array
    final sBytes =
        bigIntToBytes(signature.s, 32); // Convert BigInt to 32-byte array

    final rBase64 = base64UrlEncoded(rBytes);
    final sBase64 = base64UrlEncoded(sBytes);
    final signatureB64 = "$rBase64.$sBase64";

    final jwt = "$signingInput.$signatureB64";

    return jwt;
  } catch (error) {
    // handle error
    print(error);
    return null;
  }
}
