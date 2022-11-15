// ignore_for_file: use_build_context_synchronously

import 'package:contextmenu/contextmenu.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:knowledge_one/app_style.dart';
import 'package:knowledge_one/src/screens/workboard/providers/file_system_controller.dart';
import 'package:provider/provider.dart';

import '../components/components.dart';
import '../components/dropdown_search.dart';
import '../models/models.dart';
import '../providers/page_controller.dart';

class FileManagementScreen extends StatefulWidget {
  const FileManagementScreen({Key? key}) : super(key: key);

  @override
  State<FileManagementScreen> createState() => _FileManagementScreenState();
}

class _FileManagementScreenState extends State<FileManagementScreen> {
  final ScrollController controller = ScrollController();
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  _buildSearchBar() {
    final names = context.read<FileSystemController>().getCurrentFileNames();
    if (names.isEmpty) {
      return Container();
    }
    return DropDownSearch(
      hintText: "Search",
      key: context.watch<PageChangeController>().dropdownKey,
      datas: names,
      initialString: names.first,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          actions: [
            _buildSearchBar(),
          ],
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                context.read<FileSystemController>().backToParentFolder();
              },
              icon: const Icon(
                Icons.chevron_left_outlined,
                color: Colors.black,
                size: 30,
              )),
          centerTitle: true,
          title: SizedBox(
            width: 0.5 * AppStyle.appMinWidth,
            child: Center(
              child: Text(
                context.watch<FileSystemController>().currentDirPath,
                style: const TextStyle(color: Colors.black),
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ),
      body: DropTarget(
        onDragDone: (details) {
          final filePath = details.files.first.path;
          final fileName = details.files.first.name;
          context.read<FileSystemController>().addToCurrentFolder(
              FileEntity(fileName: fileName, path: filePath, fileId: -1));
        },
        child: GestureDetector(
          onTapUp: (details) {
            context
                .read<PageChangeController>()
                .dropdownKey
                .currentState!
                .hideOverlay();
          },
          behavior: HitTestBehavior.opaque,
          onSecondaryTapDown: (details) {
            if (context.read<FileSystemController>().currentWidgetId == -1) {
              showContextMenu(details.globalPosition, context,
                  (ctx) => _actions(ctx), 8.0, 320.0);
            }
          },
          child: SingleChildScrollView(
            controller: controller,
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: Colors.grey[200]!, width: 2))),
              width: MediaQuery.of(context).size.width - AppStyle.sideMenuWidth,
              padding: const EdgeInsets.only(
                  bottom: 10, top: 10, left: 10, right: 10),
              height: MediaQuery.of(context).size.height - 50,
              child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: buildFiles(context
                      .watch<FileSystemController>()
                      .currentFolderElements)),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _actions(BuildContext ctx) {
    return [
      ListTile(
          title: const Text("创建新文件"),
          onTap: () async {
            Navigator.of(ctx).pop();
            final result = await showCupertinoDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: const Text("创建新文件"),
                    content: Material(
                      child: Container(
                          padding: const EdgeInsets.only(left: 5, bottom: 5),
                          width: 200,
                          height: 30,
                          color: Colors.transparent,
                          child: TextField(
                            style: const TextStyle(fontSize: 14),
                            controller: textEditingController,
                            decoration: const InputDecoration(
                              hintText: "请输入文件名",
                              border: InputBorder.none,
                            ),
                          )),
                    ),
                    actions: [
                      CupertinoButton(
                          child: const Text("确定"),
                          onPressed: () {
                            Navigator.of(context)
                                .pop(textEditingController.text);
                          }),
                      CupertinoButton(
                          child: const Text("取消"),
                          onPressed: () {
                            Navigator.of(context).pop('');
                          })
                    ],
                  );
                });

            if (result != "") {
              context
                  .read<FileSystemController>()
                  .addToCurrentFolder(FileEntity(fileName: result, fileId: -1));
            }
          },
          leading: const Icon(
            Icons.add,
            color: Colors.blue,
            size: 30,
          )),
      ListTile(
          title: const Text("创建新文件夹"),
          onTap: () async {
            Navigator.of(ctx).pop();
            final result = await showCupertinoDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: const Text("创建新文件夹"),
                    content: Material(
                      child: Container(
                          padding: const EdgeInsets.only(left: 5, bottom: 5),
                          width: 200,
                          height: 30,
                          color: Colors.transparent,
                          child: TextField(
                            style: const TextStyle(fontSize: 14),
                            controller: textEditingController,
                            decoration: const InputDecoration(
                              hintText: "请输入文件夹名",
                              border: InputBorder.none,
                            ),
                          )),
                    ),
                    actions: [
                      CupertinoButton(
                          child: const Text("确定"),
                          onPressed: () {
                            Navigator.of(context)
                                .pop(textEditingController.text);
                          }),
                      CupertinoButton(
                          child: const Text("取消"),
                          onPressed: () {
                            Navigator.of(context).pop('');
                          })
                    ],
                  );
                });

            if (result != "") {
              context.read<FileSystemController>().addToCurrentFolder(
                  FolderEntity<BaseFileEntity>(
                      folderName: result, children: []));
            }
          },
          leading: const Icon(
            Icons.folder_open,
            color: Colors.blue,
            size: 30,
          )),
      ListTile(
        leading: const Icon(
          Icons.sort,
          color: Colors.green,
        ),
        title: const Text('以类型排序'),
        onTap: () {
          Navigator.of(ctx).pop();
          context.read<FileSystemController>().sortByType();
        },
      ),
      ListTile(
        leading: const Icon(
          Icons.sort,
          color: Colors.green,
        ),
        title: const Text('以时间排序'),
        onTap: () {
          Navigator.of(ctx).pop();
          context.read<FileSystemController>().sortByTime();
        },
      )
    ];
  }

  List<Widget> buildFiles(List<BaseFileEntity> data) {
    List<Widget> results = [];
    int index = 0;
    for (final i in data) {
      // print(i.runtimeType);
      if (i is FileEntity) {
        results.add(FileWidget(index: index, entity: i));
      } else {
        results.add(FolderWidget(index: index, entity: i as FolderEntity));
      }

      index++;
    }

    return results;
  }
}
