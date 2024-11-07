import 'package:flutter/services.dart';
import 'package:magic_sdk/modules/base_module.dart';

class AppAttestationExtension extends BaseModule {
  static const MethodChannel _channel = MethodChannel('app_attestation_channel');

  static Future<bool> attest() async {
    try {
        final String result = await _channel.invokeMethod<bool>('attest');
        print("Attestation called with result: $result");
        return result;
    } on PlatformException catch (e) {
        print("Failed to call attestation: '${e.message}'.");
    }
  }
}
