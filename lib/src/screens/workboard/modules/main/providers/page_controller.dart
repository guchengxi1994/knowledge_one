import 'package:flutter/material.dart';
import 'package:knowledge_one/src/screens/workboard/modules/file_management/components/dropdown_search.dart';

class PageChangeController extends ChangeNotifier {
  final PageController controller;
  PageChangeController({required this.controller});
  final GlobalKey<DropDownSearchState> dropdownKey = GlobalKey();

  int currentPageIndex = 0;
  changeIndex(int id) {
    try {
      dropdownKey.currentState!.hideOverlay();
    } catch (_) {}

    currentPageIndex = id;
    controller.jumpToPage(id);
    notifyListeners();
  }
}
