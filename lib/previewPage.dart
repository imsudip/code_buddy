import 'package:code_editor/constants/languages.dart';
import 'package:code_editor/constants/themes.dart';
import 'package:code_editor/themeController.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

import 'constants/code_snippets.dart';
import 'constants/utils.dart';

class PreviewPage extends StatefulWidget {
  final String theme;
  PreviewPage({Key key, this.theme}) : super(key: key);

  @override
  _PreviewPageState createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  ThemeController _themeController = Get.find();
  String theme;
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    if (widget.theme != null) theme = widget.theme;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (widget.theme == null) theme = _themeController.previewTheme.value;
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Utils.getColorFromTheme(
              _themeController.theme.value, "root",
              bg: true),
          elevation: 0,
          title: "Preview Theme"
              .text
              .textStyle(GoogleFonts.raleway())
              .size(24)
              .green400
              .make(),
          leading: widget.theme != null
              ? IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Utils.getColorFromTheme(
                      _themeController.theme.value,
                      "root",
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                  })
              : null,
          automaticallyImplyLeading: false,
        ),
        bottomNavigationBar: Container(
          height: 50,
          color: Vx.green400,
          child: "Save Theme"
              .text
              .textStyle(GoogleFonts.raleway())
              .size(20)
              .bold
              .letterSpacing(1.2)
              .white
              .make()
              .centered(),
        ).onTap(() async {
          await Utils.setThemeToPreferences(theme);
          _themeController.changeTheme(theme);
          Get.back();
        }),
        backgroundColor: Utils.getColorFromTheme(
            _themeController.theme.value, "root",
            bg: true),
        body: Scrollbar(
          controller: _scrollController,
          showTrackOnHover: true,
          child: ListView(
            controller: _scrollController,
            children: [
              10.heightBox,
              SelectableText(
                "This is a preview of the theme you selected.",
                style: GoogleFonts.quicksand(
                    fontSize: 16,
                    color: Utils.getColorFromTheme(
                      _themeController.theme.value,
                      "comment",
                    )),
              ).centered(),
              12.heightBox,
              "Python"
                  .text
                  .textStyle(GoogleFonts.raleway())
                  .semiBold
                  .size(20)
                  .green400
                  .make()
                  .centered(),
              10.heightBox,
              InnerField(
                language: languages[2],
                theme: theme,
                snippet: '''def list_to_dictionary(keys, values):
  return dict(zip(keys, values))

list1 = [1, 2, 3]
list2 = ['one', 'two', 'three']

print (list_to_dictionary(list1, list2))''',
              ),
              20.heightBox,
              "C++"
                  .text
                  .textStyle(GoogleFonts.raleway())
                  .semiBold
                  .size(20)
                  .green400
                  .make()
                  .centered(),
              10.heightBox,
              InnerField(
                language: languages[1],
                theme: theme,
                snippet: '''// Your First C++ Program

#include <iostream>

int main() {
    std::cout << "Hello World!";
    return 0;
}''',
              ),
              20.heightBox,
              "GO"
                  .text
                  .textStyle(GoogleFonts.raleway())
                  .semiBold
                  .size(20)
                  .green400
                  .make()
                  .centered(),
              10.heightBox,
              InnerField(
                language: languages[3],
                theme: theme,
                snippet: '''package main
import "fmt"
func main() {
    fmt.Println("hello world")
}''',
              ),
              10.heightBox,
            ],
          ),
        ),
      );
    });
  }
}

class InnerField extends StatelessWidget {
  final LanguageModel language;
  final String snippet;
  final String theme;
  CodeController _codeController;
  InnerField(
      {Key key, @required this.language, @required this.theme, this.snippet})
      : super(key: key) {
    _codeController = CodeController(
      text: snippet,
      // patternMap: {
      //   r"\B#[a-zA-Z0-9]+\b": TextStyle(color: Colors.red),
      //   r"\B@[a-zA-Z0-9]+\b": TextStyle(
      //     fontWeight: FontWeight.w800,
      //     color: Colors.blue,
      //   ),
      //   r"\B![a-zA-Z0-9]+\b":
      //       TextStyle(color: Colors.yellow, fontStyle: FontStyle.italic),
      // },
      // stringMap: {
      //   "bev": TextStyle(color: Colors.indigo),
      // },
      language: language.mode,
      theme: THEMES[theme],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CodeField(
      controller: _codeController,
      textStyle: TextStyle(fontFamily: 'SourceCode'),
    );
  }
}
