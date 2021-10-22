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

  // // Disables the platform override in order to use a manually registered
  // // See https://github.com/flutter/flutter/issues/52267 for more details.
  // Magic._();

  /// Internal Property
  // String? _publishableKey;

  static late Magic instance;

  /// External Property
  late UserModule user;
  late AuthModule auth;
  late RpcProvider provider;

  /// Expose this property to display Webview
  WebViewRelayer relayer = WebViewRelayer();

  /// Initializes a new Magic SDK instance using the given [publisherKey],
  ///
  /// for custom node configuration provide chain id[String] and rpc url[String]
  ///
  /// On initializing successfully, it will return `true`.
  ///

  Magic(String apiKey, {MagicLocale locale = MagicLocale.en_US}) {
    URLBuilder.instance = URLBuilder(apiKey, locale);
    provider = RpcProvider(relayer);

    auth = AuthModule(provider);
    user = UserModule(provider);
  }

  Magic.eth(String apiKey, { required EthNetwork network, MagicLocale locale = MagicLocale.en_US}) {
    URLBuilder.instance = URLBuilder.eth(apiKey, network, locale);
    provider = RpcProvider(relayer);

    auth = AuthModule(provider);
    user = UserModule(provider);
  }

  Magic.custom(String apiKey, { required String rpcUrl, int? chainId, MagicLocale locale = MagicLocale.en_US}) {
    URLBuilder.instance = URLBuilder.custom(apiKey, rpcUrl, chainId, locale);
    provider = RpcProvider(relayer);

    auth = AuthModule(provider);
    user = UserModule(provider);
  }
}
