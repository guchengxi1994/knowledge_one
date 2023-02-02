import 'package:flutter/material.dart';

class AppStyle {
  AppStyle._();

  static const double iconSize = 40;
  static const double appbarHeight = 50;

  static Color selectedBackgroundColor = Colors.blueAccent.withOpacity(0.5);
  static Color selectedBackgroundColorWhenGragging =
      Colors.blueAccent.withOpacity(0.7);

  /// 页面最小尺寸
  static const double appMinWidth = 1280;
  static const double appMinHeight = 800;

  // 渐隐时间
  static const int fadeTransitionDuration = 1000;

  // 侧边栏宽度
  static const double sideMenuWidth = 200;
  static const double sideMenuWidthCollapse = 50;

  /// 侧边栏字体
  static TextStyle sidebarSelectedTextStyle =
      const TextStyle(color: Color.fromARGB(255, 40, 40, 255), fontSize: 14);
  static TextStyle sidebarUnSelectedTextStyle =
      const TextStyle(color: Color.fromARGB(255, 88, 88, 88), fontSize: 14);
  static TextStyle sidebarLabelStyle =
      const TextStyle(color: Color.fromARGB(255, 209, 209, 209), fontSize: 14);
  static TextStyle sidebarLabelStyle2 =
      const TextStyle(color: Color.fromARGB(255, 180, 180, 180), fontSize: 14);

  static Color appBlue = const Color.fromARGB(255, 40, 40, 255);
  static Color appGreen = const Color.fromARGB(255, 40, 255, 115);

  static const double fileWidgetSize = 70;
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
