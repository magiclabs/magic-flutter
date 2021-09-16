import 'dart:async';
import 'package:magic_sdk/modules/auth/auth.dart';
import 'package:magic_sdk/modules/user/user.dart';
import 'package:magic_sdk/magic_sdk.dart';
import 'package:magic_sdk/modules/web3/eth_network.dart';
import 'package:magic_sdk/provider/rpc_provider.dart';
import 'package:magic_sdk/relayer/locale.dart';
import 'package:magic_sdk/relayer/url_builder.dart';
import 'package:magic_sdk/relayer/webview.dart';
export 'package:magic_sdk/magic_sdk.dart';

/// The entry point for accessing Magic SDK.
class Magic {

  // // Disables the platform override in order to use a manually registered
  // // See https://github.com/flutter/flutter/issues/52267 for more details.
  // Magic._();

  /// Internal Property
  // String? _publishableKey;

  // //
  // static set publishableKey(String value) {
  //   if (value == instance._publishableKey) {
  //     return;
  //   }
  //   instance._publishableKey = value;
  // }
  //
  // //
  // static set locale(String value) {
  //   if (value == instance._publishableKey) {
  //     return;
  //   }
  //   instance._publishableKey = value;
  // }

  // //
  // static set

  static late Magic instance;

  /// External Property
  late UserModule user;
  late AuthModule auth;
  late RpcProvider provider;
  late WebViewController _overlay;

  /// Initializes a new Magic SDK instance using the given [publisherKey],
  ///
  /// for custom node configuration provide chain id[String] and rpc url[String]
  ///
  /// On initializing successfully, it will return `true`.
  ///
  // Magic({required String apiKey, EthNetwork network, String? locale}) {
  //
  // }
  //
  // Magic({required String apiKey, CustomNode customNode, String? locale}) {
  //
  // }

  Magic(String apiKey, {MagicLocale locale = MagicLocale.en_US}) {
    _overlay = const WebViewController();
    var urlBuilder = URLBuilder(apiKey, locale);
    provider = RpcProvider(_overlay, urlBuilder);


    auth = AuthModule(provider);
    user = UserModule(provider);
  }

  Magic.eth(String apiKey, EthNetwork network, {MagicLocale locale = MagicLocale.en_US}) {
    var urlBuilder = URLBuilder.eth(apiKey, network, locale);
    provider = RpcProvider(_overlay, urlBuilder);

    auth = AuthModule(provider);
    user = UserModule(provider);
  }

  Magic.custom({required String apiKey, required String rpcUrl, int? chainId, MagicLocale locale = MagicLocale.en_US}) {
    var urlBuilder = URLBuilder.custom(apiKey, rpcUrl, chainId, locale);
    provider = RpcProvider(_overlay, urlBuilder);

    auth = AuthModule(provider);
    user = UserModule(provider);
  }
}
