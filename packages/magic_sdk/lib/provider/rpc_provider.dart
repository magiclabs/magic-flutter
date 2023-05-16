import 'dart:async';
import 'dart:convert';

import '../../provider/types/relayer_request.dart';
import '../../provider/types/relayer_response.dart';
import '../../provider/types/rpc_request.dart';
import '../../relayer/url_builder.dart';
import '../../relayer/webview.dart';

import 'package:web3dart/json_rpc.dart';
import 'package:webview_flutter/webview_flutter.dart';

part 'types/outbound_message.dart';

/// Rpc Provider
class RpcProvider implements RpcService {
  final WebViewRelayer _overlay;
  String rpcUrl;

  RpcProvider(this._overlay, {this.rpcUrl = ""});

  /// Sends message to relayer
  Future<JavaScriptMessage> send(
      {required MagicRPCRequest request,
      required Completer<JavaScriptMessage> completer}) async {
    var msgType = OutboundMessageType.MAGIC_HANDLE_REQUEST;
    var encodedParams = await URLBuilder.instance.encodedParams;

    var relayerRequest = RelayerRequest(
        msgType: '${msgType.toString().split('.').last}-$encodedParams',
        payload: request);

    _overlay.enqueue(
        relayerRequest: relayerRequest, id: request.id, completer: completer);

    return completer.future;
  }

  /* web3dart wrapper */
  @override
  Future<RPCResponse> call(String function, [List? params]) {
    params ??= [];

    var request = MagicRPCRequest(method: function, params: params);

    /* Send the RPCRequest to Magic Relayer and decode it by using RPCResponse from web3dart */
    return send(request: request, completer: Completer<JavaScriptMessage>())
        .then((jsMsg) {
      var relayerResponse = RelayerResponse<dynamic>.fromJson(
          json.decode(jsMsg.message), (json) => json as dynamic);
      return relayerResponse.response;
    });
  }
}
