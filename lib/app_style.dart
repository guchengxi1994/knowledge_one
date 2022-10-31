import 'package:flutter/material.dart';

class AppStyle {
  AppStyle._();

  /// 页面最小尺寸
  static const double appMinWidth = 1280;
  static const double appMinHeight = 800;

  static Color appBlue = const Color.fromARGB(255, 40, 40, 255);
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }
}
