Magic empowers developers to protect their users via an innovative, passwordless authentication flow without the UX compromises that burden traditional OAuth implementations.

## Features

This is your passwordless authentication for your iOS or Android-based Flutter app and enables you to interact with Solana

## Installation

Add `magic_sdk` to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  magic_sdk: ^2.0.0
  magic_ext_solana: ^0.3.0

  # Magic Flutter SDK depends on crypto-please Solana SDK to construct instructions.  
  solana: ^0.26.0
```

Run the following command to install dependencies

```text
$ dart pub get
```

## Create an SDK Instance

In `main.dart`, instantiate Magic with your publishable key, and Solana.

```dart

void main() {
  runApp(const MyApp());

  Magic.instance = Magic.blockchain("YOUR_PUBLISHABLE_KEY", rpcUrl: "https://api.devnet.solana.com", chain: SupportedBlockchain.solana);
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
        title: 'Magic Demo',
        home: Stack(children: [
          const LoginPage(),
          Magic.instance.relayer
        ]));
  }
}
```

Authenticate your first user!

```dart
var token = await magic.auth.loginWithMagicLink(email: textController.text);
```

After authenticated a new user, now it's time to interact with Solana.

```dart
// Create Solana signer
final magic = Magic.instance;
  
// Now send a transaction! 

// Get the authenticated wallet public key
UserMetadata metadata = await magic.user.getMetadata();

// Construct an instruction
Ed25519HDPublicKey solanaWallet = Ed25519HDPublicKey.fromBase58(metadata.publicAddress!);
var instruction = SystemInstruction.transfer(fundingAccount: solanaWallet, recipientAccount: solanaWallet, lamports: 1);

// recentBlockhash
var recentBlockhash = await client.getRecentBlockhash();

// Message of instructions
var message = Message.only(instruction);

// Sign Transaction Remotely using Magic Auth
var transactionSignature = await magic.solana.signTransaction(
    recentBlockhash,
    message,
    instruction.accounts
);

// Create Base64 string from the signature
var signature = await client.sendTransaction(
    transactionSignature.encode()
);

print(signature);
```

## Additional information
For other solana functions please check [Dart library for Solana](https://github.com/cryptoplease/cryptoplease-dart/tree/master/packages/solana)
