import 'package:code_editor/constants/languages.dart';
import 'package:code_editor/constants/themes.dart';
import 'package:code_editor/constants/utils.dart';
import 'package:code_editor/ide/results.dart';
import 'package:code_editor/widgets/button.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:code_text_field/src/code_modifier.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highlight/languages/python.dart';

import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:velocity_x/velocity_x.dart';

import '../themeController.dart';
import 'pythonIndent.dart';

class IdeEditorPage extends StatefulWidget {
  final LanguageModel languageModel;

  IdeEditorPage({Key key, @required this.languageModel}) : super(key: key);

  @override
  _IdeEditorPageState createState() => _IdeEditorPageState();
}

class _IdeEditorPageState extends State<IdeEditorPage> {
  CodeController _codeController;
  bool toolbarExpanded = false;
  ThemeController _themeController = Get.find();
  @override
  void initState() {
    super.initState();
    final source = widget.languageModel.defaultCode;

    // Instantiate the CodeController
    _codeController = CodeController(
        text: source,
        language: widget.languageModel.mode,
        theme: THEMES[_themeController.theme.value],
        params: EditorParams(tabSpaces: 2),
        modifiers: [
          widget.languageModel.name == "Python"
              ? PythonIndentEnter()
              : IntendModifier(),
          TabModifier(),
          const CloseBlockModifier()
        ],
        webSpaceFix: false);
  }

  @override
  void dispose() {
    _codeController.dispose();
    //_codeController.rawText;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, box) {
      if (context.width > Utils.breakpoint) {
        return Row(children: [
          Expanded(
            child: _codeview(context),
            flex: 6,
          ),
          Container(
            color: Utils.getColorFromTheme(_themeController.theme.value, "root",
                bg: true),
            width: 16,
          ),
          Expanded(
              flex: 4,
              child: ResultsPage(
                language: widget.languageModel,
              )),
        ]);
      }
      return _codeview(context);
    });
  }

  Scaffold _codeview(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Utils.getColorFromTheme(
            _themeController.theme.value, "root",
            bg: true),
        centerTitle: true,
        elevation: 0,
        title: Row(
          children: [
            Icon(
              widget.languageModel.icon,
              color: Utils.getColorFromTheme(
                _themeController.theme.value,
                "root",
              ),
            ),
            10.widthBox,
            Text(
              '${widget.languageModel.name} Editor',
              style: TextStyle(
                color: Utils.getColorFromTheme(
                  _themeController.theme.value,
                  "root",
                ),
              ),
            ).expand(),
          ],
        ),
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
        actions: [
          Obx(() => Container(
              child: _themeController.isrunning.value == true
                  ? Container()
                  : CustomButton(
                      title: "Run code",
                      icon: EvaIcons.arrowheadRightOutline,
                      onPress: () {
                        if (context.width > Utils.breakpoint) {
                          _themeController.setCode(_codeController.rawText);
                          _themeController.toggleRunning();
                        } else {
                          _themeController.toggleRunning();
                          Get.to(() => ResultsPage(
                                code: _codeController.rawText,
                                language: widget.languageModel,
                              ));
                        }
                      },
                      textColor: Utils.getColorFromTheme(
                          _themeController.theme.value, "root"),
                      backgroundColor: Utils.getColorFromTheme(
                              _themeController.theme.value, "root")
                          .withOpacity(0.1),
                    ).py(6).px16())),
        ],
      ),
      body: Stack(
        children: [
          CodeField(
            controller: _codeController,
            expands: true,
            textStyle: TextStyle(fontFamily: 'SourceCode'),
          ),
          context.width > 700
              ? Container()
              : AnimatedPositioned(
                  left: 0,
                  right: 0,
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      height: toolbarExpanded ? 112 : 54,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Builder(builder: (context) {
                        if (!toolbarExpanded) {
                          return toolBarRow1();
                        } else {
                          return toolBarRow2();
                        }
                      })),
                  duration: Duration(milliseconds: 300))
        ],
      ),
    );
  }

  toolbarExpandButton() {
    return Container(
      color: Vx.green400,
      width: 42,
      height: 42,
      child: Icon(
        toolbarExpanded ? Icons.unfold_less_rounded : Icons.unfold_more_rounded,
        color: Colors.white,
      ),
    ).cornerRadius(10).onTap(() {
      setState(() {
        toolbarExpanded = !toolbarExpanded;
      });
    });
  }

  toolBarRow1() {
    return Row(children: [
      _button("tab", () {
        _codeController.insertStr(" " * _codeController.params.tabSpaces);
      }),
      _button(":", () {
        _codeController.insertStr(":");
      }),
      _button("(", () {
        _codeController.insertStr("(");
      }),
      _button(")", () {
        _codeController.insertStr(")");
      }),
      toolbarExpandButton()
    ]);
  }

  toolBarRow2() {
    return SingleChildScrollView(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        toolBarRow1(),
        Row(children: [
          _button('"', () {
            _codeController.insertStr('"');
          }),
          _button("if", () {
            _codeController.insertStr("if ");
          }),
          _button("else", () {
            _codeController.insertStr("else ");
          }),
          _button("for", () {
            _codeController.insertStr("for ");
          }),
        ]),
      ]),
    );
  }

  _button(String text, Function ontap) {
    return Flexible(
      child: Container(
              margin: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Vx.gray200,
              ),
              height: 42,
              child: text.text.bold
                  .size(18)
                  .black
                  .fontFamily("SourceCode")
                  .make()
                  .centered())
          .onTap(() {
        ontap();
      }),
    );
  }
}
