import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:magic_sdk/provider/types/message_types.dart';
import 'package:magic_sdk/provider/types/relayer_request.dart';
import 'package:magic_sdk/provider/types/relayer_response.dart';
import 'package:magic_sdk/relayer/url_builder.dart';
import 'package:magic_sdk/relayer/webview_loader_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

final Completer _controller =
Completer();

class WebViewRelayer extends StatefulWidget {

  Map<int, Future> messageHandlers = {};
  List<RelayerRequest> queue = [];

  bool overlayReady = false;
  bool isOverlayVisible = false;

  late WebViewController webViewCtrl;

  void enqueue({required RelayerRequest relayerRequest, required int id, required Future callback}) {
    queue.add(relayerRequest);
    messageHandlers[id] = callback;
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
    debugPrint('here');
    isOverlayVisible = true;
  }

  void hideOverlay() {
    isOverlayVisible = false;
  }

  void handleResponse(Map<String, dynamic> json) {
    var payload = json['payload'];
    var id = payload['id'].toInt();
    debugPrint(id);
  }


  WebViewRelayer({Key? key}) : super(key: key);

  @override
  WebViewRelayerState createState() => WebViewRelayerState();
}

class WebViewRelayerState extends State<WebViewRelayer> {

  // @override
  // void initState() {
  //   super.initState();
  //   // Enable hybrid composition.
  //   if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  // }

  @override
  Widget build(BuildContext context) {

    void onMessageReceived(JavascriptMessage message) {

      debugPrint("message, ${message.message}");

      if(message.getMsgType() == IncomingMessageType.MAGIC_OVERLAY_READY.toShortString()) {
        widget.overlayReady = true;
        // widget.dequeue();
      } else if (message.getMsgType() == IncomingMessageType.MAGIC_SHOW_OVERLAY.toShortString()){
        // widget.showOverlay();
        setState((){
          widget.isOverlayVisible = true;
        });
      } else if (message.getMsgType() == IncomingMessageType.MAGIC_HIDE_OVERLAY.toShortString()){
        // widget.hideOverlay();
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
        initialUrl: URLBuilder.instance.url,
        javascriptMode: JavascriptMode.unrestricted,
        javascriptChannels: {
          JavascriptChannel(name: 'magicFlutter', onMessageReceived: onMessageReceived)},
        onWebViewCreated: (WebViewController w) {
          _controller.complete(w);
          widget.webViewCtrl = w;
        },
        onPageFinished: (String url) {
          //TODO: events after page loading finished
        })
    );

    // return ValueListenableBuilder<bool>(valueListenable: Loader.appLoader.loaderShowingNotifier, builder: (context, value, child) {
    //   if (value) {
    //
    //   } else {
    //     return Container();
    //   }
    // });
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
