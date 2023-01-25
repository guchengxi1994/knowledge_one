import 'package:flutter/material.dart';
import 'package:knowledge_one/src/common/future_builder.dart';
import 'package:knowledge_one/src/screens/initial/initial_screen.dart'
    deferred as initial;
import 'package:knowledge_one/src/screens/splash/splash_screen.dart';
import 'package:knowledge_one/src/screens/workboard/modules/main/workboard_screen.dart'
    deferred as workboard;

class Routers {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static String mainScreen = "/mainScreen";
  static String splashScreen = "/splashScreen";
  static String initialScreen = "/initialScreen";

  static Map<String, WidgetBuilder> routers = {
    mainScreen: (context) => FutureLoaderWidget(
        builder: (context) => workboard.WorkboardScreen(),
        loadWidgetFuture: workboard.loadLibrary()),
    splashScreen: (context) => SplashPage(),
    initialScreen: (context) => FutureLoaderWidget(
        builder: (context) => initial.InitialScreen(),
        loadWidgetFuture: initial.loadLibrary())
  };
}
