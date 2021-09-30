import 'package:flutter/material.dart';
import 'package:magic_demo/login.dart';
import 'package:magic_sdk/magic_sdk.dart';

class Web3Page extends StatefulWidget {
  const Web3Page({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<Web3Page> createState() => _Web3PageState();
}

class _Web3PageState extends State<Web3Page> {
  Magic magic = Magic.instance;

  final myController = TextEditingController(text: 'jerry@magic.link');

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
          body: Center(),
        );
  }
}
