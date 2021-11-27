import 'dart:math';

import 'package:code_editor/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

class Utils {
  static double breakpoint = 700;
  static Future<String> getThemeFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("theme"))
      return prefs.getString('theme');
    else
      return "monokai-sublime";
  }

  static Future<void> setThemeToPreferences(String theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('theme', theme);
  }

  static Icon getIconWithTheme(
      IconData iconData, String theme, BuildContext context) {
    return Icon(
      iconData,
      color: THEMES[theme]['number'].color ?? Colors.black,
      size: max(context.percentWidth * 8, 60),
    );
  }

  static Color getColorFromTheme(String theme, String tag, {bool bg = false}) {
    return bg ? THEMES[theme][tag].backgroundColor : THEMES[theme][tag].color;
  }
}
