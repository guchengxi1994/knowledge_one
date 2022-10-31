import 'package:flutter/material.dart';

class PageChangeController extends ChangeNotifier {
  final PageController controller;
  PageChangeController({required this.controller});

  int currentPageIndex = 0;
  changeIndex(int id) {
    currentPageIndex = id;
    controller.jumpToPage(id);
    notifyListeners();
  }
}
