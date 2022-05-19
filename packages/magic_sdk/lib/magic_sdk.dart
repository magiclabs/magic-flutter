import 'package:magic_sdk/modules/web3/blockchain.dart';

import 'modules/auth/auth_module.dart';
import 'modules/user/user_module.dart';
import 'modules/web3/eth_network.dart';
import 'provider/rpc_provider.dart';
import 'relayer/locale.dart';
import 'relayer/url_builder.dart';
import 'relayer/webview.dart';

export 'package:magic_sdk/magic_sdk.dart';
export 'modules/web3/magic_credential.dart';

/// The entry point for accessing Magic SDK.
class Magic {
  /// Singleton proerty that can be accessed anywhere
  static late Magic instance;

  /// rpcProvider that routes payload for sign and send to the node
  late RpcProvider provider;

  /// Expose this property to display Webview
  WebViewRelayer relayer = WebViewRelayer();

  /// Initializes a new Magic SDK instance using the given [publishableKey],
  Magic(String apiKey, {MagicLocale locale = MagicLocale.en_US}) {
    URLBuilder.instance = URLBuilder(apiKey, locale);
    provider = RpcProvider(relayer);
  }

  ///Initializes a new Magic SDK instance using the given [publishableKey] and ETG network,
  Magic.eth(String apiKey,
      {required EthNetwork network, MagicLocale locale = MagicLocale.en_US}) {
    URLBuilder.instance = URLBuilder.eth(apiKey, network, locale);
    provider = RpcProvider(relayer);
  }

  /// for custom node configuration provide chain id[String] and rpc url[String
  Magic.custom(String apiKey,
      {required String rpcUrl,
      int? chainId,
      MagicLocale locale = MagicLocale.en_US}) {
    URLBuilder.instance = URLBuilder.custom(apiKey, rpcUrl, chainId, locale);
    provider = RpcProvider(relayer);
  }

  /// for custom node configuration provide chain id[String] and rpc url[String
  Magic.blockchain(String apiKey,
      {required String rpcUrl,
       required SupportedBlockchain chain,
        MagicLocale locale = MagicLocale.en_US}) {
    URLBuilder.instance = URLBuilder.blockchain(apiKey, chain, rpcUrl, locale);
    provider = RpcProvider(relayer);
  }
}

/// Append basic modules on runtime
/// so that core sdk does not depend on these these modules
/// This is important to keep magic_sdk light weight
extension MagicBaseModule on Magic {
  AuthModule get auth => AuthModule(provider);
  UserModule get user => UserModule(provider);
}
