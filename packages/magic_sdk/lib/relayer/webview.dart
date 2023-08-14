import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

import '../../provider/types/relayer_request.dart';
import '../../provider/types/relayer_response.dart';
import '../../provider/types/rpc_response.dart';
import '../../relayer/url_builder.dart';

part '../provider/types/inbound_message.dart';

class WebViewRelayer extends StatefulWidget {
  final Map<int, Completer> _messageHandlers = {};
  final List<RelayerRequest> _queue = [];

  bool _overlayReady = false;
  bool _isOverlayVisible = false;

  final WebViewController _webViewCtrl = WebViewController();

  void enqueue(
      {required RelayerRequest relayerRequest,
      required int id,
      required Completer completer}) {
    _queue.add(relayerRequest);
    _messageHandlers[id] = completer;
    _dequeue();
  }

  void _dequeue() {
    if (_queue.isNotEmpty && _overlayReady) {
      var message = _queue.removeAt(0);
      var messageMap = message.toJson((value) => value);
      //double encoding results in extra backslash. Remove them
      String jsonString =
          json.encode({"data": messageMap}).replaceAll("\\", "");
      // debugPrint("Send Message ===> \n $jsonString");

      _webViewCtrl.runJavaScript(
          "window.dispatchEvent(new MessageEvent('message', $jsonString));");

      // Recursively dequeue till queue is Empty
      _dequeue();
    }
  }

  void showOverlay() {
    _isOverlayVisible = true;
  }

  void hideOverlay() {
    _isOverlayVisible = false;
  }

  void handleResponse(JavaScriptMessage message) {
    try {
      var json = message.decode();

      // parse JSON into General RelayerResponse to fetch id first, result will handled in the function interface
      RelayerResponse relayerResponse =
          RelayerResponse<dynamic>.fromJson(json, (result) => result);
      MagicRPCResponse rpcResponse = relayerResponse.response;

      var result = rpcResponse.result;
      var id = rpcResponse.id;

      // get callbacks in the handlers map
      var completer = _messageHandlers[id];

      // Surface the Raw JavaScriptMessage back to the function call so it can converted back to Result type
      // Only decode when result is not null, so the result is not null
      if (result != null) {
        completer!.complete(message);
      }

      if (rpcResponse.error != null) {
        completer!.completeError(rpcResponse.error!.toJson());
      }
    } catch (err) {
      //Todo Add internal error collector
      debugPrint("parse Error ${err.toString()}");
    }
  }

  WebViewRelayer({Key? key}) : super(key: key);

  @override
  WebViewRelayerState createState() => WebViewRelayerState();
}

class WebViewRelayerState extends State<WebViewRelayer> {
  String? url;

  @override
  void initState() {
    super.initState();
    initializeURL();
  }

  Future<void> initializeURL() async {
    try {
      url = await URLBuilder.instance.url;
      if (url != null) {
        loadWebView();
      } else {
        setState(() {
          // Show an error message or handle the absence of URL
        });
      }
    } catch (error) {
      print('Error occurred: $error');
      setState(() {
        // Show an error message or handle the error
      });
    }
  }

  void loadWebView() {
    // enable inspector
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      final WebKitWebViewController webKitController =
      widget._webViewCtrl.platform as WebKitWebViewController;
      webKitController.setInspectable(true);
    } else if (WebViewPlatform.instance is AndroidWebViewPlatform) {
      AndroidWebViewController.enableDebugging(true);
    }

    widget._webViewCtrl.setJavaScriptMode(JavaScriptMode.unrestricted);
    widget._webViewCtrl.addJavaScriptChannel('magicFlutter',
        onMessageReceived: (JavaScriptMessage message) {
      onMessageReceived(message);
    });
    widget._webViewCtrl.loadRequest(Uri.parse(url!));
  }

  void onMessageReceived(JavaScriptMessage message) {
    // debugPrint("Received message <=== \n ${message.message}");

    if (message.getMsgType() ==
        InboundMessageType.MAGIC_OVERLAY_READY.toShortString()) {
      widget._overlayReady = true;
      widget._dequeue();
    } else if (message.getMsgType() ==
        InboundMessageType.MAGIC_SHOW_OVERLAY.toShortString()) {
      setState(() {
        // setState can only be accessed in this context
        widget._isOverlayVisible = true;
      });
    } else if (message.getMsgType() ==
        InboundMessageType.MAGIC_HIDE_OVERLAY.toShortString()) {
      setState(() {
        widget._isOverlayVisible = false;
      });
    } else if (message.getMsgType() ==
        InboundMessageType.MAGIC_HANDLE_EVENT.toShortString()) {
      //Todo PromiseEvent
    } else if (message.getMsgType() ==
        InboundMessageType.MAGIC_HANDLE_RESPONSE.toShortString()) {
      widget.handleResponse(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget._isOverlayVisible,
      maintainState: true,
      child: WebViewWidget(controller: widget._webViewCtrl),
    );
  }
}

/// Extended utilities to help to decode JS Message
extension MessageType on JavaScriptMessage {
  Map<String, dynamic> decode() {
    return json.decode(message);
  }

  String getMsgType() {
    var json = decode();
    var msgType = json['msgType'].split('-').first;
    return msgType;
  }
}
