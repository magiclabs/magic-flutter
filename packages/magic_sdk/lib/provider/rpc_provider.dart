import 'package:flutter/cupertino.dart';
import 'package:magic_sdk/provider/message_types.dart';
import 'package:magic_sdk/provider/relayer_request.dart';
import 'package:magic_sdk/provider/relayer_response.dart';
import 'package:magic_sdk/provider/rpc_request.dart';
import 'package:magic_sdk/relayer/url_builder.dart';
import 'package:magic_sdk/relayer/webview.dart';

///
///
///
// this._overlay
String foo () {
  return '';
}

class RpcProvider {

  final WebViewRelayer _overlay;

  RpcProvider(this._overlay);

   Future<String> send({required RPCRequest request}){

     var msgType = OutgoingMessageType.magicHandleRequest;

     var payloadMessage = RelayerRequest(msgType: '${msgType.toString().split('.').last}-${URLBuilder.instance.encodedParams}', payload: request);

     var callback = Future(foo);

     _overlay.enqueue(message: payloadMessage.toString(), id: request.id, callback: callback);

    return callback;
  }
}

