package com.example.app_attestation

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "app_attestation_channel"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            if (call.method == "attest") {
                val attestationCheck = attest()
                result.success(attestationCheck)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun attest(): Boolean {
        print("Call to attest reached in Android")
        return true
    }
}
