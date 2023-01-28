import 'dart:io';

import 'package:flutter/material.dart';
import 'package:knowledge_one/native.dart';
import 'package:knowledge_one/src/screens/workboard/modules/main/providers/app_controller.dart';
import 'package:knowledge_one/utils/utils.dart';
import 'package:provider/provider.dart';

import '../file_management/providers/file_system_controller.dart';
import 'providers/page_controller.dart';
import '../faker_gui/faker_screen.dart';
import '../file_management/file_management_screen.dart';
import 'components/sidemenu.dart';
import '../svg_cleaner/svg_cleaner_screen.dart';

class WorkboardScreen extends StatefulWidget {
  const WorkboardScreen({Key? key}) : super(key: key);

  @override
  State<WorkboardScreen> createState() => _WorkboardScreenState();
}

class _WorkboardScreenState extends State<WorkboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await initApp();
    });
  }

  Future<void> initApp() async {
    Directory executableDir = DevUtils.executableDir;
    LocalStorage storage = LocalStorage();
    print("${executableDir.path}/db_config.toml");
    await api.initDatabase(
        confPath: "${executableDir.path}/db_config.toml",
        isFirstTime: await storage.getFirst());
    await storage.setFirst();
  }

  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => PageChangeController(controller: pageController)),
        ChangeNotifierProvider(create: (_) => AppConfigController()..init())
      ],
      builder: (context, child) {
        return Container(
          color: Colors.grey[100],
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SideMenu(),
                Expanded(
                  child: PageView(
                    controller: pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      // const FileManagementScreen(),
                      MultiProvider(
                        providers: [
                          ChangeNotifierProvider(
                              create: (_) => FileSystemController()..init()),
                        ],
                        builder: (context, child) {
                          return const FileManagementScreen();
                        },
                      ),
                      // const TodoScreen(),
                      SvgCleanerScreen(),
                      const FakerScreen(),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}