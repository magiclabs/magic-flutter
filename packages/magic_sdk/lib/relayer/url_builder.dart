import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:magic_sdk/modules/web3/eth_network.dart';
import 'package:magic_sdk/relayer/locale.dart';


class URLBuilder {
  final String _host = "https://box.magic.link";
  late String apiKey;
  late String encodedParams;

  URLBuilder(String apiKey, MagicLocale locale){
    init(apiKey, locale);
  }

  URLBuilder.custom(String apiKey, String rpcUrl, int? chainId, MagicLocale locale){
    var network = {};
    network['rpcUrl'] = rpcUrl;
    network['chainId'] = chainId;
    init(apiKey, locale, network: network);
  }

  URLBuilder.eth(String apiKey, EthNetwork network, MagicLocale locale) {
    var network = {};
    network['network'] = network.toString();
    init( apiKey, locale, network: network);
  }

  init(String apiKey, MagicLocale locale, {Map? network}) {
    var urlObj = {};
    urlObj['API_KEY'] = apiKey;
    urlObj['host'] = _host;
    urlObj['sdk'] = 'magic-sdk-flutter';
    urlObj['locale'] = locale.toString().split('.').last;
    urlObj['ETH_NETWORK'] = network;
    encodedParams = json.encode(urlObj);
    debugPrint(encodedParams);
    this.apiKey = apiKey;
  }
}
