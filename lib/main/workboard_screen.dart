import 'dart:io';

import 'package:flutter/material.dart';
import 'package:knowledge_one/bridge/native.dart';

import 'package:knowledge_one/code_generator/code_generate_screen.dart';
import 'package:knowledge_one/common/rpc_controller.dart';
import 'package:knowledge_one/main/providers/app_controller.dart';
import 'package:knowledge_one/redis_client/redis_client_screen.dart';
import 'package:knowledge_one/utils/utils.dart';
import 'package:provider/provider.dart';

import '../file_management/providers/file_system_controller.dart';
import '../redis_client/redis_controller.dart';
import 'providers/page_controller.dart';
import '../faker_gui/faker_screen.dart';
import '../file_management/file_management_screen.dart';
import 'components/sidemenu.dart';

import 'package:window_manager/window_manager.dart';
import 'package:knowledge_one/svg_cleaner/svg_cleaner_screen.dart';

class WorkboardScreen extends StatefulWidget {
  const WorkboardScreen({Key? key}) : super(key: key);

  @override
  State<WorkboardScreen> createState() => _WorkboardScreenState();
}

class _WorkboardScreenState extends State<WorkboardScreen> with WindowListener {
  @override
  void initState() {
    windowManager.addListener(this);
    _init();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await initApp();
    });
  }

  void _init() async {
    // Add this line to override the default close handler
    await windowManager.setPreventClose(true);
    setState(() {});
  }

  @override
  void onWindowClose() async {
    bool isPreventClose = await windowManager.isPreventClose();
    if (isPreventClose && mounted) {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text('Are you sure you want to close this window?'),
            actions: [
              TextButton(
                child: const Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Yes'),
                onPressed: () async {
                  context.read<RPCController>().endAll();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                  await windowManager.destroy();
                },
              ),
            ],
          );
        },
      );
    } else {
      await windowManager.destroy();
    }
  }

  Future<void> initApp() async {
    Directory executableDir = DevUtils.executableDir;
    LocalStorage storage = LocalStorage();
    debugPrint("${executableDir.path}/db_config.toml");
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
        ChangeNotifierProvider(create: (_) => AppConfigController()..init()),
        ChangeNotifierProvider(create: (_) => RedisController())
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
                      const CodeGenerateScreen(),
                      const RedisClientScreen()
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
