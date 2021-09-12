import 'dart:async';
import 'package:magic_sdk/modules/auth/auth.dart';
import 'package:magic_sdk/modules/user/user.dart';
import 'package:magic_sdk/magic_sdk.dart';
import 'package:magic_sdk/modules/web3/eth_network.dart';
import 'package:magic_sdk/rpc_provider.dart';
export 'package:magic_sdk/magic_sdk.dart';

/// The entry point for accessing Magic SDK.
class Magic {

  late UserModule user;
  late AuthModule auth;
  late RpcProvider provider;

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

  Magic({required String apiKey, String? locale}) {
    provider = RpcProvider(apiKey);

    auth = AuthModule(provider);
    user = UserModule(provider);
  }

  // Magic() {
  //
  // }
}
