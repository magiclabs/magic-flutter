import 'dart:async';
import 'package:magic_sdk/utils/string.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../provider/rpc_provider.dart';
import '../../provider/types/rpc_request.dart';

class BaseModule {
  late RpcProvider provider;

  BaseModule(this.provider);

  /// Returns <JavascriptMessage> here to decode in the last step.
  /// As Dart doesn't support method return type inference. So we need to surface raw message and
  /// let the type in interface call to deserialize
  Future<dynamic> sendToProvider(
      {required Enum method, List<dynamic>? params}) async {
    MagicRPCRequest<List<dynamic>> request = MagicRPCRequest<List<dynamic>>(
        method: toShortString(method), params: params ?? []);
    return provider.send(
        request: request, completer: Completer<dynamic>());
  }

  Future<dynamic> sendToProviderWithMap(
      {required Enum method, Map<String, dynamic>? params}) async {
    MagicRPCRequest<Map<String, dynamic>> request =
        MagicRPCRequest<Map<String, dynamic>>(
            method: toShortString(method), params: params ?? {});
    return provider.send(
        request: request, completer: Completer<dynamic>());
  }
}
