import 'package:flutter/material.dart';
import 'package:knowledge_one/rpc_controller.dart';
import 'package:knowledge_one/src/screens/workboard/providers/todo_controller.dart';
import 'package:knowledge_one/src/screens/workboard/sub_screens/todo_screen.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import 'providers/file_system_controller.dart';
import 'providers/page_controller.dart';
import 'sub_screens/file_management_screen.dart';
import 'components/sidemenu.dart';

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

  void _init() async {
    // Add this line to override the default close handler
    await windowManager.setPreventClose(true);
    setState(() {});
  }

  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => PageChangeController(controller: pageController)),
        ChangeNotifierProvider(create: (_) => FileSystemController()..init()),
        ChangeNotifierProvider(create: (_) => TodoController()..init())
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
                    children: const [
                      FileManagementScreen(),
                      TodoScreen(),
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
