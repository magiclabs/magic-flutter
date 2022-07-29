Magic empowers developers to protect their users via an innovative, passwordless authentication flow without the UX compromises that burden traditional OAuth implementations.

## Features

This is your passwordless authentication for your iOS or Android-based Flutter app and enables you to interact with Tezos

## Installation

Add `magic_sdk` to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  magic_sdk: ^1.0.0
  magic_ext_tezos: ^0.1.0

  # Please use a forked version of tezart, that have Remote signer enabled
  tezart:
    git: https://github.com/Ethella/tezart.git
```

Run the following command to install dependencies

```text
$ dart pub get
```

## Create an SDK Instance

In `main.dart`, instantiate Magic with your publishable key, and Tezos.

```dart

void main() {
  runApp(const MyApp());

  Magic.instance = Magic.blockchain("YOUR_PUBLISHABLE_KEY", rpcUrl: "https://ithacanet.smartpy.io/", chain: SupportedBlockchain.tezos);
}
```

Use `Stack` in the top level and add `Magic.instance.relayer` to the children of Stack to ensure the best performance

Note: Relayer is required to establish communication between apps and Magic service. Make sure to have it in a stack whenever you need to authenticate or interact with blockchain

```dart
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Stack(children: [ // Use Stack here to make sure
          MaterialApp(
            title: 'Magic Demo',
            home: const LoginPage(),
          ),
          Magic.instance.relayer // Insert relayer here
        ]));
  }
}
```

Authenticate your first user via OAuth!

```dart
var token = await magic.auth.loginWithMagicLink(email: textController.text);
```

After authenticated a new user, now it's time to interact with Tezos.

```dart
  // Create Tezos signer
  final tezosSigner = Magic.instance.tezos;

  // Create Tezart instance
  final client = TezartClient('https://ithacanet.smartpy.io/');
  
  // Fetch public key and address from the logged in user
  await tezosSigner.init(); 
  
  // Now send a transaction! 
    final operationsList = await client.transferOperation(
        source: Keystore.fromRemoteSigner(tezosSigner),
        destination: tezosSigner.address,
        amount: 10001,
    );
    await operationsList.executeAndMonitor();
```

## Additional information

For more implementation on Tezart, please check the [Tezart doc](https://moneytrackio.github.io/tezart/#/)
