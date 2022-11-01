import 'dart:io';

import 'package:flutter/material.dart';
import 'package:knowledge_one/routers.dart';
import 'package:knowledge_one/src/native/native.dart';
import 'package:window_manager/window_manager.dart';
import 'app_style.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory executableDir = File(Platform.resolvedExecutable).parent;
  // var folder = Directory("${executableDir.path}/_private");
  // if (!folder.existsSync()) {
  //   await folder.create();
  // }
  await api.createStorageDirectory(s: executableDir.path);

  await windowManager.ensureInitialized();
  windowManager.setTitle("KnowledgeOne");
  windowManager
      .setSize(const Size(AppStyle.appMinWidth, AppStyle.appMinHeight));
  windowManager
      .setMinimumSize(const Size(AppStyle.appMinWidth, AppStyle.appMinHeight));
  windowManager.setResizable(false);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('zh', 'CH'),
        Locale('en', 'US'),
      ],
      theme: ThemeData(fontFamily: "思源"),
      locale: const Locale('zh'),
      debugShowCheckedModeBanner: false,
      initialRoute: Routers.splashScreen,
      routes: Routers.routers,
      navigatorKey: Routers.navigatorKey,
    );
  }
}
