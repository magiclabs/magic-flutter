import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:uuid/uuid.dart';
import 'package:secp256r1/secp256r1.dart';

final _alias = "link.magic.auth.dpop";

String base64UrlEncoded(List<int> data) {
  var b64 = base64.encode(data);
  b64 = b64.replaceAll('+', '-');
  b64 = b64.replaceAll('/', '_');
  b64 = b64.replaceAll('=', '');
  return b64;
}

Future<String?> createJwt() async {
  try {
    // Get the public key.
    final publicKey = await SecureP256.getPublicKey(_alias);
    
    // Get the public key, raw representation.
    final rawPublicKey = publicKey.rawKey;

    // Extract the x and y coordinates.
    final xCoordinateData = rawPublicKey.sublist(1, 33);
    final yCoordinateData = rawPublicKey.sublist(33, 65);

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

    final claims = {
      "iat": iat,
      "jti": jti
    };
    final claimsData = utf8.encode(json.encode(claims));
    final claimsB64 = base64UrlEncoded(claimsData);

    // sign
    final signingInput = headersB64 + "." + claimsB64;
    final signature = await SecureP256.sign(_alias, Uint8List.fromList(utf8.encode(signingInput)));

    final signatureB64 = base64UrlEncoded(signature);

    final jwt = signingInput + "." + signatureB64;

    return jwt;

  } catch (error) {
    // handle error
    print(error);
    return null;
  }
}
