import 'package:flutter/material.dart';
import 'package:magic_sdk/magic_sdk.dart';

import 'login.dart';

void main() {
  runApp(const MyApp());

  // Magic.instance = Magic("pk_test_6109DF2B98280CBB");
  Magic.instance = Magic("pk_live_D5EA1E346A791DB7");
}

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

