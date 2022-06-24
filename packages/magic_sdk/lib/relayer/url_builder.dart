import 'dart:convert';
import 'package:package_info_plus/package_info_plus.dart';

import '../../modules/web3/eth_network.dart';
import '../../relayer/locale.dart';
import '../modules/blockchain/supported_blockchain.dart';

class URLBuilder {
  final String _host = "https://box.magic.link";
  // final String _host = "http://192.168.1.18:3016";

  static late URLBuilder instance;

  String apiKey;
  MagicLocale locale;

  Map? _network;
  Map? _ext;

  Future<String> get encodedParams async {
    var urlObj = {};
    urlObj['API_KEY'] = apiKey;
    urlObj['host'] = _host;
    urlObj['sdk'] = 'magic-sdk-flutter';
    urlObj['locale'] = locale.toString().split('.').last;
    var packageInfo = await PackageInfo.fromPlatform();
    urlObj['bundleId'] = packageInfo.packageName;

    if (_network != null) {
      urlObj['ETH_NETWORK'] = _network;
    }

    if (_ext != null) {
      urlObj['ext'] = _ext;
    }

    // Encode params to base64
    var jsonStr = json.encode(urlObj);
    var bytes = utf8.encode(jsonStr);
    return base64.encode(bytes);
  }

  Future<String> get url async {
    return '$_host/send/?params=${await encodedParams}';
  }

  URLBuilder(this.apiKey, this.locale);

  URLBuilder.custom(this.apiKey, String rpcUrl, int? chainId, this.locale) {
    _network = {"rpcUrl": rpcUrl, "chainId": chainId};
  }

  URLBuilder.eth(this.apiKey, EthNetwork network, this.locale) {
    _network = {"network": network.toString().split('.').last};
  }

  URLBuilder.blockchain(
      this.apiKey, SupportedBlockchain chain, String rpcUrl, this.locale) {
    String key;

    /// Compatible blockchain name mapping
    switch (chain) {
      case SupportedBlockchain.tezos:
        key = 'taquito';
        break;
      default:
        key = chain.toString().split('.').last;
    }

    _ext = {
      key: {"rpcUrl": rpcUrl}
    };
  }
}
