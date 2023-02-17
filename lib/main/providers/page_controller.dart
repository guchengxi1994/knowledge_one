import 'package:flutter/material.dart';

class PageChangeController extends ChangeNotifier {
  final PageController controller;
  PageChangeController({required this.controller});
  static GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  bool collapse = false;

  int currentPageIndex = 0;
  changeIndex(int id) {
    currentPageIndex = id;
    controller.jumpToPage(id);
    notifyListeners();
  }

  changeCollapse() {
    collapse = !collapse;
    notifyListeners();
  }
}
