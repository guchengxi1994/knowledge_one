import 'package:flutter/material.dart';
import 'package:knowledge_one/src/screens/splash/splash_screen.dart';
import 'package:knowledge_one/src/screens/workboard/workboard_screen.dart';

class Routers {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static String mainScreen = "/mainScreen";
  static String splashScreen = "/splashScreen";

  static Map<String, WidgetBuilder> routers = {
    mainScreen: (context) => const MyHomePage(title: "demo"),
    splashScreen: (context) => const SplashScreen()
  };
}
