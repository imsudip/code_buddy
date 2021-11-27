import 'package:code_editor/constants/languages.dart';
import 'package:code_editor/constants/themes.dart';
import 'package:code_editor/constants/utils.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletons/skeletons.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:highlight/languages/python.dart';

import 'package:flutter_highlight/themes/monokai-sublime.dart';
import '../themeController.dart';
import 'compiler.dart';

class ResultsPage extends StatefulWidget {
  final String code;
  final LanguageModel language;
  ResultsPage({Key key, this.code, this.language}) : super(key: key);

  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  bool hasInputKeyword = false;
  CompilerState compilerState = CompilerState.NOT_STARTED;
  String status = "Compiling...";
  String output = "";
  Map<String, dynamic> outputMap = new Map<String, String>();
  CodeController _codeController;
  ThemeController _themeController = Get.find();
  String code;
  int apicallCount = 10;
  @override
  void dispose() {
    _codeController.dispose();
    _themeController.removeListener(_listener);
    super.dispose();
  }

  _listener() {
    code = _themeController.code.value;
    if (_themeController.isrunning.value &&
        CompilerState.COMPILING != compilerState) {
      print("Compiling");
      _runCode();
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.code != null) {
      code = widget.code;
    }
    _themeController.addListener(_listener);
    Compiler.changeLang(widget.language.apiCode);
    hasInputKeyword = true;
    if (hasInputKeyword) {
      status = " ";
    } else {
      _runCode();
    }
    _codeController = CodeController(
        text: "",
        language: widget.language.mode,
        theme: THEMES[_themeController.theme.value],
        params: EditorParams(tabSpaces: 1),
        modifiers: [],
        webSpaceFix: false);
  }

  _runCode() async {
    var input = "";
    if (hasInputKeyword) {
      input = _codeController.rawText;
    }
    setState(() {
      compilerState = CompilerState.COMPILING;
      status = "Compiling...";
    });
    var sid = await Compiler.leetCodeCompile(code, input);
    print("id: " + sid);
    await Future.delayed(Duration(milliseconds: 500), () {});
    Future.doWhile(() async {
      if (apicallCount == 0) return false;
      print("fire");
      var o = await Compiler.leetCodeFetchResults(sid);
      if (o['state'] == "SUCCESS") {
        outputMap = o;
        print(o);
        if (o['run_success'] == false) {
          compilerState = CompilerState.ERROR;
          status = o['status_msg'];
          output = o["full_" + status.toLowerCase().replaceAll(" ", "_")];
        } else {
          compilerState = CompilerState.COMPILED;
          status = o['status_msg'];
          output = (o['code_output'] as List).join("\n");
        }

        _themeController.toggleRunning();
        setState(() {});
        return false;
      } else {
        apicallCount--;
        if (o['status_msg'] == "Internal Error") {
          compilerState = CompilerState.ERROR;
          status = o['status_msg'];
          output = "Some issues with backend ";
          setState(() {});
          return false;
        }
        await Future.delayed(Duration(milliseconds: 1000), () {});
        return true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Utils.getColorFromTheme(
            _themeController.theme.value, "root",
            bg: true),
        appBar: AppBar(
          backgroundColor: Utils.getColorFromTheme(
              _themeController.theme.value, "root",
              bg: true),
          elevation: 0,
          centerTitle: true,
          title: "Output"
              .text
              .textStyle(GoogleFonts.raleway())
              .size(24)
              .color(Utils.getColorFromTheme(
                _themeController.theme.value,
                "root",
              ))
              .make(),
          leading: widget.code != null
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
        body: ListView(
          children: [
            hasInputKeyword
                ? Column(
                    children: [
                      10.heightBox,
                      Text(
                        "Enter your inputs here :",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff75715e),
                            fontFamily: "SourceCode"),
                      ),
                      CodeField(
                        padding: const EdgeInsets.all(0),
                        controller: _codeController,
                        minLines: 2,
                        wrap: true,
                        textStyle: TextStyle(fontFamily: 'SourceCode'),
                        lineNumberBuilder: (index, style) {
                          return TextSpan(text: ">", style: style);
                        },
                      ),
                      10.heightBox,
                    ],
                  )
                    .box
                    .border(
                        color: Utils.getColorFromTheme(
                            _themeController.theme.value, "comment"))
                    .customRounded(BorderRadius.circular(10))
                    .make()
                    .p(16)
                : Container(),
            hasInputKeyword &&
                    compilerState != CompilerState.COMPILING &&
                    widget.code != null
                ? Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                        height: 50,
                        decoration: BoxDecoration(
                          color: Vx.green400,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Run Code",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w400),
                        ).centered())
                    .onTap(() {
                    setState(() {
                      _runCode();
                    });
                  })
                : Container(),
            20.heightBox,
            Center(
              child: compilerState == CompilerState.COMPILING
                  ? Text(status,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'SourceCode',
                        color: Colors.white,
                      ))
                  : compilerState == CompilerState.COMPILED
                      ? Text(status,
                          style: TextStyle(
                              color: Colors.greenAccent[400],
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'SourceCode'))
                      : compilerState == CompilerState.ERROR
                          ? Text(status,
                              style: TextStyle(
                                  color: Colors.redAccent[400],
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'SourceCode'))
                          : Container(),
            ),
            14.heightBox,
            compilerState != CompilerState.COMPILING &&
                    compilerState != CompilerState.NOT_STARTED
                ? Container(
                    margin: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                        color: Utils.getColorFromTheme(
                            _themeController.theme.value, "root", bg: true),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Utils.getColorFromTheme(
                                _themeController.theme.value, "comment"))),
                    child: Text(
                      output ?? "NO OUTPUT",
                      style: TextStyle(
                          fontFamily: 'SourceCode',
                          color: compilerState == CompilerState.COMPILED
                              ? Color(0xfff8f8f2)
                              : Colors.red),
                    ),
                  )
                : compilerState != CompilerState.NOT_STARTED
                    ? CircularProgressIndicator().centered()
                    : Container(),
            compilerState == CompilerState.COMPILED
                ? Text(
                    "Time: ${outputMap['status_runtime']} sec \nMemory used: ${outputMap['status_memory']}",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'SourceCode',
                        color: Colors.white),
                  ).pOnly(left: 25)
                : Container(),
            25.heightBox,
            compilerState != CompilerState.COMPILING &&
                    compilerState != CompilerState.NOT_STARTED &&
                    widget.code != null
                ? Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                        height: 50,
                        decoration: BoxDecoration(
                          color: Vx.green400,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Go Back",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w400),
                        ).centered())
                    .onTap(() {
                    setState(() {
                      context.pop();
                    });
                  })
                : Container()
          ],
        ));
  }

  SkeletonTheme _shimmer() {
    return SkeletonTheme(
      themeMode: ThemeMode.dark,
      darkShimmerGradient: LinearGradient(
        colors: [
          Color(0xFF171813),
          Color(0xFF83847E),
          Color(0xFF23241F),
        ],
        stops: [
          0.0,
          0.5,
          1,
        ],
        begin: Alignment(-2.4, -0.2),
        end: Alignment(2.4, 0.2),
        tileMode: TileMode.clamp,
      ),
      child: SkeletonAvatar(
        style: SkeletonAvatarStyle(
          borderRadius: BorderRadius.circular(10),
          height: 90,
        ),
      ),
    );
  }
}

enum CompilerState {
  NOT_STARTED,
  COMPILING,
  COMPILED,
  ERROR,
}
