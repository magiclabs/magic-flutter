import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:magic_sdk/provider/types/message_types.dart';
import 'package:magic_sdk/provider/types/relayer_request.dart';
import 'package:magic_sdk/provider/types/rpc_response.dart';
import 'package:magic_sdk/relayer/url_builder.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewRelayer extends StatefulWidget {

  Map<int, Completer> messageHandlers = {};
  List<RelayerRequest> queue = [];

  bool overlayReady = false;
  bool isOverlayVisible = false;

  late WebViewController webViewCtrl;

  void enqueue({required RelayerRequest relayerRequest, required int id, required Completer completer}) {
    queue.add(relayerRequest);
    messageHandlers[id] = completer;
    dequeue();
  }

  void dequeue() {

    if (queue.isNotEmpty && overlayReady) {
      var message = queue.removeAt(0);

      String jsonString = json.encode({"data": message});

      debugPrint("Send Message $jsonString");

      webViewCtrl.evaluateJavascript("window.dispatchEvent(new MessageEvent('message', $jsonString));");

      // Recursive call till queue is Empty
      dequeue();
    }
  }

  void showOverlay() {
    isOverlayVisible = true;
  }

  void hideOverlay() {
    isOverlayVisible = false;
  }

  void handleResponse(Map<String, dynamic> json) {
    try {
      var response = json['response'];
      var id = response['id'].toInt();

      // get callbacks in the handlers map
      var completer = messageHandlers[id];

      var rpcResponse = RPCResponse.fromJson(response);

      // Surface Response back to the function call
      if (rpcResponse.result != null) {
        completer!.complete(rpcResponse.result);
      }

      if (rpcResponse.error != null) {
        completer!.completeError(rpcResponse.error!.toJson());
      }

    } catch (err) {
      debugPrint(err.toString());
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

      debugPrint("Received message, ${message.message}");

      if(message.getMsgType() == IncomingMessageType.MAGIC_OVERLAY_READY.toShortString()) {
        widget.overlayReady = true;
        widget.dequeue();
      } else if (message.getMsgType() == IncomingMessageType.MAGIC_SHOW_OVERLAY.toShortString()){
        setState((){
          widget.isOverlayVisible = true;
        });
      } else if (message.getMsgType() == IncomingMessageType.MAGIC_HIDE_OVERLAY.toShortString()){
        setState(() {
          widget.isOverlayVisible = false;
        });
      } else if (message.getMsgType() == IncomingMessageType.MAGIC_HANDLE_EVENT.toShortString()) {
        //Todo PromiseEvent
      } else if (message.getMsgType() == IncomingMessageType.MAGIC_HANDLE_RESPONSE.toShortString()) {
          widget.handleResponse(message.decode());
      }
    }

    return Visibility(
      visible: widget.isOverlayVisible,
        maintainState: true,
        child: WebView(
          debuggingEnabled: true,
        initialUrl: URLBuilder.instance.url,
        javascriptMode: JavascriptMode.unrestricted,
        javascriptChannels: {
          JavascriptChannel(name: 'magicFlutter', onMessageReceived: onMessageReceived)},
        onWebViewCreated: (WebViewController w) {
          widget.webViewCtrl = w;
          w.clearCache();
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
