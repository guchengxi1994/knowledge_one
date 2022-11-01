import 'package:flutter/material.dart';

enum MdEditingMode { writing, reading }

class MarkdownEditController extends ChangeNotifier {
  MdEditingMode mode = MdEditingMode.reading;
  changeMode() {
    if (mode == MdEditingMode.reading) {
      mode = MdEditingMode.writing;
    } else {
      mode = MdEditingMode.reading;
    }
    notifyListeners();
  }
}
