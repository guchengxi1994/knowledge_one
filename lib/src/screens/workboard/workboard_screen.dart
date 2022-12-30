import 'package:flutter/material.dart';
import 'package:knowledge_one/src/screens/workboard/providers/todo_controller.dart';
import 'package:knowledge_one/src/screens/workboard/sub_screens/todo_screen.dart';
import 'package:provider/provider.dart';

import 'providers/file_system_controller.dart';
import 'providers/page_controller.dart';
import 'sub_screens/file_management_screen.dart';
import 'components/sidemenu.dart';
import 'sub_screens/svg_cleaner_screen.dart';

class WorkboardScreen extends StatefulWidget {
  const WorkboardScreen({Key? key}) : super(key: key);

  @override
  State<WorkboardScreen> createState() => _WorkboardScreenState();
}

class _WorkboardScreenState extends State<WorkboardScreen> {
  @override
  void initState() {
    super.initState();
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
                    children: [
                      const FileManagementScreen(),
                      const TodoScreen(),
                      SvgCleanerScreen()
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
