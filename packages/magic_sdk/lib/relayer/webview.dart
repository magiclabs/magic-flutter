import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:magic_sdk/modules/user/user_response.dart';
import 'package:magic_sdk/provider/types/message_types.dart';
import 'package:magic_sdk/provider/types/relayer_request.dart';
import 'package:magic_sdk/provider/types/relayer_response.dart';
import 'package:magic_sdk/provider/types/rpc_response.dart';
import 'package:magic_sdk/relayer/url_builder.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewRelayer extends StatefulWidget {

  final Map<int, Completer> _messageHandlers = {};
  final List<RelayerRequest> _queue = [];

  bool _overlayReady = false;
  bool _isOverlayVisible = false;

  late WebViewController webViewCtrl;

  void enqueue({required RelayerRequest relayerRequest, required int id, required Completer completer}) {
    _queue.add(relayerRequest);
    _messageHandlers[id] = completer;
    _dequeue();
  }

  void _dequeue() {

    if (_queue.isNotEmpty && _overlayReady) {
      var message = _queue.removeAt(0);

      String jsonString = json.encode({"data": message});

      // debugPrint("Send Message $jsonString");

      webViewCtrl.evaluateJavascript("window.dispatchEvent(new MessageEvent('message', $jsonString));");

      // Recursive call till queue is Empty
      _dequeue();
    }
  }

  void showOverlay() {
    _isOverlayVisible = true;
  }

  void hideOverlay() {
    _isOverlayVisible = false;
  }

  void handleResponse(JavascriptMessage message) {
    try {
      var json = message.decode();

      // parse JSON into General RelayerResponse to fetch id first, result will handled in the function interface
      RelayerResponse relayerResponse = RelayerResponse<dynamic>.fromJson(json, (json) => json as Object);
      RPCResponse rpcResponse = relayerResponse.response;

      var result = rpcResponse.result;
      var id = rpcResponse.id;

      // get callbacks in the handlers map
      var completer = _messageHandlers[id];

      // Surface the Raw JavascriptMessage back to the function call
      if (result != null) {
        completer!.complete(message);
      }

      if (rpcResponse.error != null) {
        completer!.completeError(rpcResponse.error!.toJson());
      }

    } catch (err) {
      debugPrint("parse Error ${err.toString()}");
    }
  }


  WebViewRelayer({Key? key}) : super(key: key);

  @override
  WebViewRelayerState createState() => WebViewRelayerState();
}

class WebViewRelayerState extends State<WebViewRelayer> {

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {

    void onMessageReceived(JavascriptMessage message) {

      // debugPrint("Received message, ${message.message}");

      if(message.getMsgType() == IncomingMessageType.MAGIC_OVERLAY_READY.toShortString()) {
        widget._overlayReady = true;
        widget._dequeue();
      } else if (message.getMsgType() == IncomingMessageType.MAGIC_SHOW_OVERLAY.toShortString()){
        setState((){ // setState can only be accessed in this context
          widget._isOverlayVisible = true;
        });
      } else if (message.getMsgType() == IncomingMessageType.MAGIC_HIDE_OVERLAY.toShortString()){
        setState(() {
          widget._isOverlayVisible = false;
        });
      } else if (message.getMsgType() == IncomingMessageType.MAGIC_HANDLE_EVENT.toShortString()) {
        //Todo PromiseEvent
      } else if (message.getMsgType() == IncomingMessageType.MAGIC_HANDLE_RESPONSE.toShortString()) {
          widget.handleResponse(message);
      }
    }

    return Visibility(
      visible: widget._isOverlayVisible,
        maintainState: true,
        child: WebView(
          debuggingEnabled: true,
        initialUrl: URLBuilder.instance.url,
        javascriptMode: JavascriptMode.unrestricted,
        javascriptChannels: {
          JavascriptChannel(name: 'magicFlutter', onMessageReceived: onMessageReceived)},
        onWebViewCreated: (WebViewController w) {
          widget.webViewCtrl = w;
        },
        onPageFinished: (String url) {
          //TODO: events after page loading finished
        })
    );
  }
}

extension MessageType on JavascriptMessage {
  Map<String, dynamic> decode() {
    return json.decode(message);
  }
  String getMsgType () {
    var json = decode();
    var msgType = json['msgType'].split('-').first;
    return msgType;
  }
}
