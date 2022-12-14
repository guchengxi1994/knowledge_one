import 'dart:io';
import 'dart:ui';

import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter/material.dart';
import 'package:knowledge_one/routers.dart';
import 'package:knowledge_one/rpc_controller.dart';
import 'package:knowledge_one/utils/utils.dart';
import 'native.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initApp();
  runApp(const MyApp());
}

Future<void> initApp() async {
  Directory executableDir = DevUtils.executableDir;
  print("${executableDir.path}/db_config.toml");
  await api.createAllDirectory(s: executableDir.path);
  await api.initMysql(confPath: "${executableDir.path}/db_config.toml");
}

class CustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => RPCController())],
      builder: (context, child) {
        return MaterialApp(
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('zh', 'CN'),
            Locale('zh', 'HK'),
            Locale('en', 'US'),
          ],
          scrollBehavior: CustomScrollBehavior(),
          theme: ThemeData(fontFamily: "思源"),
          locale: const Locale('zh'),
          debugShowCheckedModeBanner: false,
          initialRoute: Routers.splashScreen,
          routes: Routers.routers,
          navigatorKey: Routers.navigatorKey,
          navigatorObservers: [FlutterSmartDialog.observer],
          builder: FlutterSmartDialog.init(),
        );
      },
    );
  }
}
