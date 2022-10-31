import 'package:flutter/material.dart';
import 'package:knowledge_one/routers.dart';
import 'package:knowledge_one/src/providers/counter_provider.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'app_style.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CounterProvider()..init())
      ],
      builder: (context, child) {
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
      },
    );
  }
}
