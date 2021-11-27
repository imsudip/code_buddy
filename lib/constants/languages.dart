import 'package:code_editor/constants/code_snippets.dart';
import 'package:code_editor/constants/defaultCode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_devicon/flutter_devicon.dart';
import 'package:highlight/languages/all.dart';

final languagesModes = {
  'C': allLanguages['cpp'],
  'Cpp': allLanguages['cpp'],
  'Cpp14': allLanguages['cpp'],
  'Java': allLanguages['java'],
  'Python': allLanguages['python'],
  'Scala': allLanguages['scala'],
  'Php': allLanguages['php'],
  //'Perl': allLanguages['perl'],
  'Csharp': allLanguages['cs'],
};
// final languagesList = [
//   'C',
//   'C++',
//   'C++ 14',
//   'Java',
//   'Python',
//   'Scala',
//   'Php',
//   //'Perl',
//   'C#',
// ];
// final languagesIcons = {
//   'C': FlutterDEVICON.c_line,
//   'Cpp': FlutterDEVICON.cplusplus_line,
//   'Cpp14': FlutterDEVICON.cplusplus_line,
//   'Java': FlutterDEVICON.java_plain,
//   'Python': FlutterDEVICON.python_plain,
//   'Scala': FlutterDEVICON.scala_plain,
//   'Php': FlutterDEVICON.php_plain,
//   // 'Perl': FlutterDEVICON.postgresql_plain,
//   'Csharp': FlutterDEVICON.csharp_line,
// };

class LanguageModel {
  final String name;
  final IconData icon;
  final dynamic mode;
  final String defaultCode;
  final String apiCode;
  LanguageModel(
      this.name, this.icon, this.mode, this.defaultCode, this.apiCode);
}

List<LanguageModel> languages = [
  new LanguageModel(
    'C',
    FlutterDEVICON.c_plain,
    allLanguages['cpp'],
    DEFAULT_CODE['c'],
    "c",
  ),
  new LanguageModel(
    'C++',
    FlutterDEVICON.cplusplus_plain,
    allLanguages['cpp'],
    DEFAULT_CODE['cpp'],
    "cpp",
  ),
  new LanguageModel(
    'Python',
    FlutterDEVICON.python_plain,
    allLanguages['python'],
    DEFAULT_CODE['python'],
    "python3",
  ),
  new LanguageModel(
    'GO',
    FlutterDEVICON.go_plain,
    allLanguages['go'],
    DEFAULT_CODE['go'],
    "golang",
  ),
  new LanguageModel(
    'Java',
    FlutterDEVICON.java_plain,
    allLanguages['java'],
    DEFAULT_CODE['java'],
    "java",
  ),

  new LanguageModel(
    'Javascript',
    FlutterDEVICON.javascript_plain,
    allLanguages['javascript'],
    DEFAULT_CODE['js'],
    "javascript",
  ),
  new LanguageModel(
    'Typescript',
    FlutterDEVICON.typescript_plain,
    allLanguages['typescript'],
    DEFAULT_CODE['js'],
    "typescript",
  ),
  new LanguageModel(
    'Bash',
    FlutterDEVICON.bash_plain,
    allLanguages['bash'],
    DEFAULT_CODE['bash'],
    "bash",
  ),
  new LanguageModel(
    'Ruby',
    FlutterDEVICON.ruby_plain,
    allLanguages['ruby'],
    DEFAULT_CODE['ruby'],
    "ruby",
  ),
  new LanguageModel(
    'Rust',
    FlutterDEVICON.rust_plain,
    allLanguages['rust'],
    DEFAULT_CODE['rust'],
    "rust",
  ),
  new LanguageModel(
    'Php',
    FlutterDEVICON.php_plain,
    allLanguages['php'],
    DEFAULT_CODE['php'],
    "Php",
  ),
  // new LanguageModel('Perl', FlutterDEVICON.postgresql_plain, allLanguages['perl']),
  new LanguageModel(
    'C#',
    FlutterDEVICON.csharp_plain,
    allLanguages['cs'],
    DEFAULT_CODE['cs'],
    "Csharp",
  ),
];
