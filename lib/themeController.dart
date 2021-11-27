import 'package:code_editor/constants/themes.dart';
import 'package:code_editor/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';

class ThemeController extends GetxController {
  ThemeController(String th) {
    this.theme.value = th;
  }
  var theme = 'monokai-sublime'.obs;
  var previewTheme = THEMES.keys.first.obs;
  var code = "".obs;
  var isrunning = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void toggleRunning() {
    this.isrunning.value = !this.isrunning.value;
    update();
  }

  void setCode(String c) {
    this.code.value = c;
    update();
  }

  changeTheme(String newTheme) {
    this.theme.value = newTheme;
    // var color = Utils.getColorFromTheme(newTheme, "root", bg: true);
    // var lum = color.computeLuminance();
    // print(lum);
    // Get.changeTheme(lum > 0.5 ? ThemeData.dark() : ThemeData.light());
    update();
  }
}
