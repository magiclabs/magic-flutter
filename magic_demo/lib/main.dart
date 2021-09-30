import 'package:flutter/material.dart';
import 'package:magic_sdk/magic_sdk.dart';

import 'login.dart';

void main() {
  runApp(const MyApp());

  Magic.instance = Magic("pk_test_A2090B6480EE6E3C");
  // Magic.instance = Magic("pk_live_F6875E92A3144E89");
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Stack(children: [
      MaterialApp(
        title: 'Magic Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: const LoginPage(),
      ),
          Magic.instance.relayer
    ]));
  }
}

