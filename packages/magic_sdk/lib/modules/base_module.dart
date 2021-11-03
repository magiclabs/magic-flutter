import 'dart:async';
import 'package:webview_flutter/webview_flutter.dart';

import '../../provider/rpc_provider.dart';
import '../../provider/types/rpc_request.dart';

class BaseModule {
  late RpcProvider provider;

  BaseModule(this.provider);

  /// Returns <JavascriptMessage> here to decode in the last step.
  /// As Dart doesn't support method return type inference. So we need to surface raw message and
  /// let the type in interface call to deserialize
  Future<JavascriptMessage> sendToProvider(
      {required String method, List<dynamic>? params}) async {
    MagicRPCRequest request =
        MagicRPCRequest(method: method, params: params ?? []);
    return provider.send(
        request: request, completer: Completer<JavascriptMessage>());
  }
}
