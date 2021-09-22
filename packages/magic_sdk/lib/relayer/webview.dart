import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
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

  @override
  Widget build(BuildContext context) {

    debugPrint(URLBuilder.instance.url);

    return WebView(
        initialUrl: URLBuilder.instance.url,
        javascriptMode: JavascriptMode.unrestricted,
        javascriptChannels: {
          JavascriptChannel(name: 'magicFlutter', onMessageReceived: (JavascriptMessage message) {
            debugPrint("received message: ${message.message}");
          })
        },
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
