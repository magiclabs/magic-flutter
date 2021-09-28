import 'package:flutter/cupertino.dart';
import 'package:magic_sdk/provider/types/message_types.dart';
import 'package:magic_sdk/provider/types/relayer_request.dart';
import 'package:magic_sdk/provider/types/relayer_response.dart';
import 'package:magic_sdk/provider/types/rpc_request.dart';
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

     var msgType = OutgoingMessageType.MAGIC_HANDLE_REQUEST;

     var relayerRequest = RelayerRequest(msgType: '${msgType.toString().split('.').last}-${URLBuilder.instance.encodedParams}', payload: request);

     var callback = Future(foo);

     _overlay.enqueue(relayerRequest: relayerRequest, id: request.id, callback: callback);

    return callback;
  }
}

