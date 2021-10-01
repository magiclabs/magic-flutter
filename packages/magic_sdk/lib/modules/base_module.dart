import 'dart:async';

import 'package:magic_sdk/provider/rpc_provider.dart';
import 'package:magic_sdk/provider/types/rpc_request.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BaseModule {
  late RpcProvider provider;

  BaseModule(this.provider);

  /// Returns <JavascriptMessage> here to decode in the last step.
  /// As Dart doesn't support method return type inference. So we need to surface raw message and
  /// let the type in interface call to deserialize
  Future<JavascriptMessage> sendToProvider({required String method, dynamic params}) async {

    RPCRequest request = RPCRequest(method: method, params: [params]);
    return provider.send(request: request, completer: Completer<JavascriptMessage>());
  }
}
