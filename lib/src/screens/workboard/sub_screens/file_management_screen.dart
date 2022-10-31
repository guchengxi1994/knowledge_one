import 'package:contextmenu/contextmenu.dart';
import 'package:flutter/material.dart';
import 'package:knowledge_one/app_style.dart';

class FileManagementScreen extends StatefulWidget {
  const FileManagementScreen({Key? key}) : super(key: key);

  @override
  State<FileManagementScreen> createState() => _FileManagementScreenState();
}

class _FileManagementScreenState extends State<FileManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width - AppStyle.sideMenuWidth,
      child: GestureDetector(
        onTapDown: (details) {},
        child: ContextMenuArea(
          builder: (context) => [
            ListTile(
              title: Text('Option 1'),
              onTap: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Whatever')));
              },
            )
          ],
          child:
              TextButton(onPressed: () {}, child: Text("http://flutter.dev")),
        ),
      ),
    );
  }
}
