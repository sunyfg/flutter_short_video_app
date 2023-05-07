import 'dart:io';

import 'package:flutter/material.dart';

import 'main.dart';

class SecondPage extends StatefulWidget {
  final String params;

  const SecondPage({Key? key,  this.params = ''}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  String version = 'null';

  @override
  Widget build(BuildContext context) {
    String text = '';

    if(Platform.isIOS) {
      text = 'iOS';
    } else if(Platform.isMacOS) {
      text = 'macos';
    } else if(Platform.isAndroid) {
      text = 'Android';
    }

    return GestureDetector(
      child: Text('第二个页面,系统平台是$version: $text'),
      onTap: () {
        var result = 'Ack from secondPage';
        router.popRoute(params: result);
      },
    );
  }
}
