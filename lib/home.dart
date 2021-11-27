import 'package:code_editor/constants/languages.dart';
import 'package:code_editor/constants/utils.dart';
import 'package:code_editor/ide/ide_page.dart';
import 'package:code_editor/themeController.dart';
import 'package:code_editor/themePage.dart';
import 'package:code_editor/widgets/button.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class Homepage extends StatefulWidget {
  Homepage({Key key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  ThemeController _themeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            toolbarHeight: 100,
            backgroundColor: Utils.getColorFromTheme(
                _themeController.theme.value, "root",
                bg: true),
            title: "Code Buddy"
                .text
                .textStyle(GoogleFonts.pacifico())
                .maxLines(1)
                .size(42)
                .green400
                .make(),
            actions: [
              CustomButton(
                title: "Change Theme",
                icon: EvaIcons.colorPalette,
                onPress: () {
                  Get.to(() => ThemePage());
                },
                textColor: Utils.getColorFromTheme(
                    _themeController.theme.value, "root"),
                backgroundColor: Utils.getColorFromTheme(
                        _themeController.theme.value, "root")
                    .withOpacity(0.1),
              ).py(22).px16()
            ],
          ),
          backgroundColor: Utils.getColorFromTheme(
              _themeController.theme.value, "root",
              bg: true),
          body: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.7,
                  mainAxisSpacing: 10,
                  crossAxisCount: context.width > 1000
                      ? 6
                      : context.width > 700
                          ? 4
                          : 3,
                  crossAxisSpacing: 10),
              itemCount: languages.length,
              itemBuilder: (context, index) {
                return _tile(languages[index].name, languages[index].icon,
                    _themeController.theme.value, () {
                  Get.to(() => IdeEditorPage(languageModel: languages[index]));
                });
              }).px12().py(20),
        ));
  }

  _tile(String title, IconData icon, String theme, Function ontap) {
    return InkWell(
      hoverColor: Utils.getColorFromTheme(theme, "comment").withOpacity(0.1),
      splashColor: Utils.getColorFromTheme(theme, "comment").withOpacity(0.5),
      splashFactory: InkRipple.splashFactory,
      onTap: () {
        ontap();
      },
      child: Container(
          height: 100,
          decoration: BoxDecoration(
              border:
                  Border.all(color: Utils.getColorFromTheme(theme, "comment")),
              borderRadius: BorderRadius.circular(12)),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Utils.getIconWithTheme(icon, theme, context),
            8.heightBox,
            Text(
              "$title",
              style: GoogleFonts.catamaran(
                  fontSize: context.textScaleFactor * 20,
                  color: Utils.getColorFromTheme(theme, "keyword")),
            )
          ])),
    );
  }
}
