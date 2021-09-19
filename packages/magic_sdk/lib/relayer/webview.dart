import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:magic_sdk/relayer/url_builder.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewController extends StatefulWidget {
  const WebViewController({Key? key}) : super(key: key);

  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewController> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {

    // Const will make sure widget never rebuild
    return WebView(
      initialUrl: URLBuilder.instance.url,
    );
  }
}
