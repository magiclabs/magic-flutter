import 'package:magic_sdk/provider/rpc_request.dart';
import 'package:magic_sdk/relayer/url_builder.dart';
import 'package:magic_sdk/relayer/webview.dart';

///
///

class RpcProvider {

  late WebViewController _overlay;

  RpcProvider(WebViewController overlay){
    _overlay = overlay;
  }

   Future<String> send({required RPCRequest request}){
    String foo () {
      return '';
    }
    return Future(foo);
  }
}

