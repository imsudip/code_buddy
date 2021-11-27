import 'package:code_editor/constants/utils.dart';
import 'package:code_editor/home.dart';
import 'package:code_editor/themeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  _initialize() async {
    String theme = await Utils.getThemeFromPreferences();
    ThemeController themeController =
        Get.put(ThemeController(theme), permanent: true);
    await Future.delayed(Duration(seconds: 1));
    Get.offAll(() => Homepage());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff222221),
      child: "Code Buddy"
          .text
          .textStyle(GoogleFonts.pacifico())
          .size(50)
          .green400
          .make()
          .centered(),
    ).material();
  }
}
