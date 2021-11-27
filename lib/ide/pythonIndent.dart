import 'dart:math';

import 'package:code_text_field/code_text_field.dart';
import 'package:code_text_field/src/code_modifier.dart';
import 'package:flutter/material.dart';

class PythonIndentEnter extends CodeModifier {
  const PythonIndentEnter() : super('\n');

  @override
  TextEditingValue updateString(
      String text, TextSelection sel, EditorParams params) {
    var spacesCount = 0;
    var braceCount = 0;
    for (var k = min(sel.start, text.length) - 1; k >= 0; k--) {
      if (text[k] == "\n") break;
      if (text[k] == " ")
        spacesCount += 1;
      else
        spacesCount = 0;
      if (text[k] == ":")
        braceCount += 1;
      else if (text[k] == "}") braceCount -= 1;
    }
    if (braceCount > 0) spacesCount += params.tabSpaces;
    final insert = "\n" + " " * spacesCount;
    return replace(text, sel.start, sel.end, insert);
  }
}

//cursor needs to move between the quotations

// class IndentDoubleQuotation extends CodeModifier {
//   const IndentDoubleQuotation() : super('"');

//   @override
//   TextEditingValue updateString(
//       String text, TextSelection sel, EditorParams params) {
//     final insert = '""';
//     return replace(text, sel.start, sel.end, insert);
//   }
// }

// class IndentSingleQuotation extends CodeModifier {
//   const IndentSingleQuotation() : super("'");

//   @override
//   TextEditingValue updateString(
//       String text, TextSelection sel, EditorParams params) {
//     final insert = "''";
//     return replace(text, sel.start, sel.end, insert);
//   }
// }
