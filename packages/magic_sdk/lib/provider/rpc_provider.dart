import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:magic_sdk/provider/types/message_types.dart';
import 'package:magic_sdk/provider/types/relayer_request.dart';
import 'package:magic_sdk/provider/types/relayer_response.dart';
import 'package:magic_sdk/provider/types/rpc_request.dart';
import 'package:magic_sdk/provider/types/rpc_response.dart';
import 'package:magic_sdk/relayer/url_builder.dart';
import 'package:magic_sdk/relayer/webview.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Rpc Provider
class RpcProvider {

  final WebViewRelayer _overlay;

  RpcProvider(this._overlay);

   Future<JavascriptMessage> send({required RPCRequest request, required Completer<JavascriptMessage> completer}){

     var msgType = OutgoingMessageType.MAGIC_HANDLE_REQUEST;

     var relayerRequest = RelayerRequest(msgType: '${msgType.toString().split('.').last}-${URLBuilder.instance.encodedParams}', payload: request);

     _overlay.enqueue(relayerRequest: relayerRequest, id: request.id, completer: completer);

    return completer.future;
  }
}

