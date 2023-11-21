import 'dart:async';
import 'package:magic_sdk/utils/string.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../provider/rpc_provider.dart';
import '../../provider/types/rpc_request.dart';

class BaseModule {
  late RpcProvider provider;

  BaseModule(this.provider);

  /// Returns <JavaScriptMessage> here to decode in the last step.
  /// As Dart doesn't support method return type inference. So we need to surface raw message and
  /// let the type in interface call to deserialize
  Future<JavaScriptMessage> sendToProvider(
      {required Enum method, List<dynamic>? params}) async {
    MagicRPCRequest<List<dynamic>> request = MagicRPCRequest<List<dynamic>>(
        method: toShortString(method), params: params ?? []);
    return provider.send(
        request: request, completer: Completer<JavaScriptMessage>());
  }

  Future<JavaScriptMessage> sendToProviderWithMap(
      {required Enum method, Map<String, dynamic>? params}) async {
    MagicRPCRequest<Map<String, dynamic>> request =
        MagicRPCRequest<Map<String, dynamic>>(
            method: toShortString(method), params: params ?? {});
    return provider.send(
        request: request, completer: Completer<JavaScriptMessage>());
  }

  Future<JavaScriptMessage> sendToProviderWithList({
    required Enum method, 
    List<dynamic>? params
  }) async {
    // Prepare the RPC request
    MagicRPCRequest<List<dynamic>> request = MagicRPCRequest<List<dynamic>>(
        method: toShortString(method), params: params ?? []);

    // Create a Completer to handle the asynchronous response
    Completer<JavaScriptMessage> completer = Completer<JavaScriptMessage>();

    // Send the request
    return provider.send(
        request: request, completer: completer);
  }
}
