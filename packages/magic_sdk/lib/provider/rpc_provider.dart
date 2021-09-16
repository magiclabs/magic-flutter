import 'package:magic_sdk/provider/rpc_request.dart';
import 'package:magic_sdk/relayer/url_builder.dart';
import 'package:magic_sdk/relayer/webview.dart';

///
///

class RpcProvider {

  late WebViewController _overlay;
  late URLBuilder _urlBuilder;

  RpcProvider(WebViewController overlay, URLBuilder urlBuilder){
    _overlay = overlay;
    _urlBuilder = urlBuilder;
  }

   send({required RPCRequest request}){

  }
}

