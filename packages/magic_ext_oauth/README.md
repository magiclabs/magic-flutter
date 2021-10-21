Magic empowers developers to protect their users via an innovative, passwordless authentication flow without the UX compromises that burden traditional OAuth implementations.

## Features

This is your entry-point to secure, passwordless authentication for your iOS or Android-based Flutter app.

## Installation

Add `magic_sdk` to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  magic_sdk: ^0.1.0
```

Run the following command to install dependencies

```text
$ dart pub get
```

## Create an SDK Instance

In `main.dart`, instantiate Magic with your publishable key

```dart

void main() {
  runApp(const MyApp());

  Magic.instance = Magic("YOUR_PUBLISHABLE_KEY");
}
```

Use `Stack` in the top level and add `Magic.instance.relayer` to the children of Stack to ensure the best performance

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

Authenticate your first user!

```dart
var token = await magic.auth.loginWithMagicLink(email: textController.text);
```

## Additional information

For more detail, please check the [Magic Link Flutter doc](https://magic.link/docs/client-sdk/flutter/get-started)
