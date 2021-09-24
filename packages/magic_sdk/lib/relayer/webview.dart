import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:magic_sdk/provider/types/message_types.dart';
import 'package:magic_sdk/relayer/url_builder.dart';
import 'package:magic_sdk/relayer/webview_loader_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

final Completer _controller =
Completer();

class WebViewRelayer extends StatelessWidget {
  WebViewRelayer({Key? key}) : super(key: key);

//   @override
//   WebViewRelayerState createState() => WebViewRelayerState();
// }
//
// class WebViewRelayerState extends State<WebViewRelayer> {

  Map messageHandlers = {};
  List<String> queue = [];

  bool overlayReady = false;

  late WebViewController webViewCtrl;

  void enqueue({required String message, required int id, required Future callback}) {
    queue.add(message);
    messageHandlers[id] = callback;
    dequeue();
  }

  void dequeue() {

    if (queue.isNotEmpty && overlayReady) {
      var message = queue.removeAt(0);

      String jsonString = json.encode({"data": message});

      webViewCtrl.evaluateJavascript("window.dispatchEvent(new MessageEvent('message', $jsonString));");

      // Recursive call till queue is Empty
      dequeue();
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   // Enable hybrid composition.
  //   if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  // }

  void showWebView() {

  }

  void hideWebView() {

  }

  void handleResponse(String message) {
    // message
  }


  @override
  Widget build(BuildContext context) {

    void onMessageReceived(JavascriptMessage message) {
      debugPrint("message ${message.message}");
      try {
        var obj = json.decode(message.message);
        debugPrint(obj);
      } catch (e) {
        debugPrint(e.toString());
      }

      var receivedMsg = message.message;

      if(receivedMsg.contains(IncomingMessageType.MAGIC_OVERLAY_READY.toShortString())) {
        overlayReady = true;
        dequeue();
      } else if (receivedMsg.contains(IncomingMessageType.MAGIC_SHOW_OVERLAY.toShortString())){
        showWebView();
      } else if (receivedMsg.contains(IncomingMessageType.MAGIC_HIDE_OVERLAY.toShortString())){
        hideWebView();
      } else if (receivedMsg.contains(IncomingMessageType.MAGIC_HANDLE_EVENT.toShortString())) {
        //Todo PromiseEvent
      } else if (receivedMsg.contains(IncomingMessageType.MAGIC_HANDLE_RESPONSE.toShortString())) {
        handleResponse(receivedMsg);
      }
    }

    return WebView(
        initialUrl: URLBuilder.instance.url,
        javascriptMode: JavascriptMode.unrestricted,
        javascriptChannels: {
          JavascriptChannel(name: 'magicFlutter', onMessageReceived: onMessageReceived)},
        onWebViewCreated: (WebViewController w) {
          _controller.complete(w);
          webViewCtrl = w;
        },
        onPageFinished: (String url) {
          //TODO: events after page loading finished
        });

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
  String decode() {
    return json.decode(message);
  }
  String getMsgType () {
    debugPrint(decode());
    return decode();

  }
}
