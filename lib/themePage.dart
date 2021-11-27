import 'package:code_editor/constants/themes.dart';
import 'package:code_editor/constants/utils.dart';
import 'package:code_editor/previewPage.dart';
import 'package:code_editor/themeController.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class ThemePage extends StatefulWidget {
  ThemePage({Key key}) : super(key: key);

  @override
  _ThemePageState createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  ThemeController _themeController = Get.find();
  String selectedTheme;
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState

    selectedTheme = _themeController.previewTheme.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, box) {
      if (context.width > Utils.breakpoint) {
        return Row(children: [
          Expanded(child: _listView()),
          Container(
            color: Utils.getColorFromTheme(_themeController.theme.value, "root",
                bg: true),
            width: 16,
          ),
          Expanded(child: PreviewPage()),
        ]);
      }
      return _listView();
    });
  }

  _listView() {
    return Obx(() => Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Utils.getColorFromTheme(
                _themeController.theme.value, "root",
                bg: true),
            elevation: 0,
            title: "Select Theme"
                .text
                .textStyle(GoogleFonts.raleway())
                .size(24)
                .green400
                .make(),
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Utils.getColorFromTheme(
                    _themeController.theme.value,
                    "root",
                  ),
                ),
                onPressed: () {
                  Get.back();
                }),
          ),
          backgroundColor: Utils.getColorFromTheme(
              _themeController.theme.value, "root",
              bg: true),
          body: Scrollbar(
            controller: _scrollController,
            showTrackOnHover: true,
            isAlwaysShown: true,
            child: GridView(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: context.width > 1000
                      ? (context.width / 4) / 75
                      : context.width > Utils.breakpoint
                          ? (context.width / 2) / 75
                          : (context.width) / 75,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 12,
                  crossAxisCount: context.width > 1000 ? 2 : 1),
              children: THEMES.keys
                  .map((theme) => InkWell(
                        borderRadius: BorderRadius.circular(12),
                        hoverColor: Utils.getColorFromTheme(
                          _themeController.theme.value,
                          "symbol",
                        ).withOpacity(0.06),
                        onTap: () {
                          if (context.width > Utils.breakpoint) {
                            _themeController.previewTheme.value = theme;
                            setState(() {
                              selectedTheme = theme;
                            });
                          } else {
                            Get.to(() => PreviewPage(
                                  theme: theme,
                                ));
                          }
                        },
                        child: Row(children: [
                          Icon(
                            EvaIcons.colorPaletteOutline,
                            color: Utils.getColorFromTheme(
                              _themeController.theme.value,
                              "symbol",
                            ),
                          ),
                          12.widthBox,
                          Text(
                            theme,
                            style: GoogleFonts.sourceCodePro(
                                color: Utils.getColorFromTheme(
                              _themeController.theme.value,
                              "symbol",
                            )),
                          ).expand(),
                          Icon(
                            Icons.chevron_right_rounded,
                            size: 35,
                            color: Utils.getColorFromTheme(
                              _themeController.theme.value,
                              "symbol",
                            ),
                          ),
                        ])
                            .box
                            .px16
                            .color(theme == selectedTheme
                                ? Utils.getColorFromTheme(
                                    _themeController.theme.value,
                                    "symbol",
                                  ).withOpacity(0.08)
                                : null)
                            .border(
                                color: Utils.getColorFromTheme(
                                    _themeController.theme.value, "comment"))
                            .customRounded(BorderRadius.circular(12))
                            .make(),
                      ))
                  .toList(),
            ),
          ),
        ));
  }
}
