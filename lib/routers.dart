import 'package:flutter/material.dart';
import 'package:knowledge_one/src/screens.dart';

class Routers {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static String mainScreen = "/mainScreen";
  static String splashScreen = "/splashScreen";

  static Map<String, WidgetBuilder> routers = {
    mainScreen: (context) => const WorkboardScreen(),
    splashScreen: (context) => const SplashPage(),
  };
}
