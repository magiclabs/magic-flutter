import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:magic_sdk/modules/web3/eth_network.dart';
import 'package:magic_sdk/relayer/locale.dart';

class URLBuilder {
  // final String _host = "https://box.magic.link";
  final String _host = "http://192.168.31.215:3016";

  static late URLBuilder instance;

  String apiKey;
  MagicLocale locale;

  Map? _network;

  String get encodedParams {
    var urlObj = {};
    urlObj['API_KEY'] = apiKey;
    urlObj['host'] = _host;
    urlObj['sdk'] = 'magic-sdk-flutter';
    urlObj['locale'] = locale.toString().split('.').last;
    urlObj['ETH_NETWORK'] = _network;

    // Encode params to base64
    var jsonStr = json.encode(urlObj);
    var bytes = utf8.encode(jsonStr);
    return base64.encode(bytes);
  }

  String get url {
    return '$_host/send/?params=$encodedParams';
  }

  URLBuilder(this.apiKey, this.locale);

  URLBuilder.custom(this.apiKey, String rpcUrl, int? chainId, this.locale){
    _network = {
      rpcUrl: rpcUrl,
      chainId: chainId
    };
  }

  URLBuilder.eth(this.apiKey, EthNetwork network, this.locale) {
    var network = {};
    network['network'] = network.toString().split('.').last;
  }
}
