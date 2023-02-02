// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:code_text_field/code_text_field.dart';

import 'package:highlight/languages/all.dart' as lang;
import 'package:flutter_highlight/themes/vs2015.dart';

class CodePreview extends StatefulWidget {
  const CodePreview({Key? key, required this.codes, required this.langType})
      : super(key: key);
  final String codes;
  final String langType;

  @override
  State<CodePreview> createState() => CodePreviewState();
}

class CodePreviewState extends State<CodePreview> {
  CodeController? _codeController;
  @override
  void initState() {
    super.initState();
    final source = widget.codes;
    // print(getLang(widget.langType));
    _codeController = CodeController(
      language: getLang(widget.langType),
      text: source,
    );
  }

  @override
  void dispose() {
    _codeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: CodeTheme(
      data: const CodeThemeData(styles: vs2015Theme),
      child: CodeField(
          maxLines: null,
          controller: _codeController!,
          textStyle: const TextStyle(fontFamily: 'SourceCode')),
    ));
  }

  dynamic getLang(String s) {
    switch (s) {
      case "Ruby":
        return lang.allLanguages['ruby'];
      case "JavaScript":
        return lang.allLanguages['javascript'];
      case "Rust":
        return lang.allLanguages['rust'];
      case "Kotlin":
        return lang.allLanguages['kotlin'];
      case "Dart":
        return lang.allLanguages['dart'];
      case "Python":
        return lang.allLanguages['python'];
      case "C#":
        return lang.allLanguages['cs'];
      case "Go":
        return lang.allLanguages['go'];
      case "C++":
        return lang.allLanguages['cpp'];
      case "Java":
        return lang.allLanguages['java'];
      case "TypeScript":
        return lang.allLanguages['typescript'];
      case "Swift":
        return lang.allLanguages['swift'];
      case "Objective-C":
        return lang.allLanguages['objectivec'];
      case "Haskell":
        return lang.allLanguages['haskell'];
      default:
        return null;
    }
  }
}
