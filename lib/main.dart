import 'package:code_editor/home.dart';
import 'package:code_editor/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Code Buddy',
      // builder: BotToastInit(),
      // navigatorObservers: [BotToastNavigatorObserver()],
      // theme: ThemeData(
      //     primarySwatch: Colors.blue,
      //     brightness: Brightness.dark,
      //     splashColor: Colors.transparent),
      home: SplashScreen(),
    );
  }
}
