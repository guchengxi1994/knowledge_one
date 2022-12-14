import 'package:contextmenu/contextmenu.dart';
import 'package:flutter/material.dart';
import 'package:knowledge_one/app_style.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../providers/file_system_controller.dart';
import 'base_file_widget.dart';

// ignore: must_be_immutable
class FolderWidget extends StatefulWidget {
  FolderWidget(
      {Key? key, required this.index, this.onDoubleClick, required this.entity})
      : super(key: key);
  VoidCallback? onDoubleClick;
  int index;
  FolderEntity entity;

  @override
  State<FolderWidget> createState() => _FolderWidgetState();
}

class _FolderWidgetState extends State<FolderWidget> {
  late double dx = 0;
  late double dy = 0;
  final iconSize = AppStyle.fileWidgetSize;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDragging = context.watch<FileSystemController>().isDragging;

    late Decoration? decoration;

    if (context.select<FileSystemController, int>(
            (value) => value.currentWidgetId) ==
        widget.index) {
      if (isDragging) {
        decoration = BoxDecoration(
          color: AppStyle.selectedBackgroundColorWhenGragging, // 背景色
          border: Border.all(color: Colors.blue, width: 0.5), // border
          borderRadius: BorderRadius.circular((1)), // 圆角
        );
      } else {
        decoration = BoxDecoration(
          color: AppStyle.selectedBackgroundColor, // 背景色
          border: Border.all(color: Colors.blue, width: 0.5), // border
          borderRadius: BorderRadius.circular((1)), // 圆角
        );
      }
    } else {
      decoration = BoxDecoration(
        color: Colors.transparent, // 背景色
        // border: Border.all(color: Colors.blue, width: 0.5), // border
        borderRadius: BorderRadius.circular((1)), // 圆角
        border: Border.all(color: Colors.transparent, width: 0.5),
      );
    }

    dx = (widget.index %
            ((MediaQuery.of(context).size.width - AppStyle.sideMenuWidth) ~/
                (iconSize + /*spacing+border*/ 12))) *
        (iconSize + /*spacing+border*/ 12);
    dy = (widget.index ~/
            ((MediaQuery.of(context).size.width - AppStyle.sideMenuWidth) ~/
                (iconSize + /*spacing+border*/ 12))) *
        (iconSize + /*spacing+border*/ 12) + /*padding*/ 10 - /*scroll offset*/ context.select<FileSystemController, double>((value) => value.scrolledHeight);

    context
        .read<FileSystemController>()
        .changeWidgetStatus(widget.index, WidgetStatus(dx: dx, dy: dy));

    return GestureDetector(
        onDoubleTap: () {
          context.read<FileSystemController>().navigateTo(widget.entity);
        },
        onPanDown: (details) {
          // setState(() {});
          context
              .read<FileSystemController>()
              .changeClickPoint(details.localPosition);
        },
        child: Draggable(
            onDragEnd: (details) async {
              // print(MediaQuery.of(context).size.width);
              BaseFileEntity? entity =
                  context.read<FileSystemController>().findObjectByOffset(
                        details.offset,
                      );
              // print(entity);
              if (entity != null &&
                  entity != widget.entity &&
                  entity is FolderEntity) {
                await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                            '是不是要把"${widget.entity.name}"移入"${entity.name}"中?'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("确定")),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("取消")),
                        ],
                      );
                    });
              }
            },
            feedback: Container(
              margin: EdgeInsets.only(
                  left: context.watch<FileSystemController>().clickPoint.dx,
                  top: context.watch<FileSystemController>().clickPoint.dy),
              width: 20,
              height: 20,
              color: Colors.orange[100],
            ),
            child: ContextMenuArea(
                width: 150,
                builder: (ctx) {
                  return [
                    ListTile(
                      leading: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      title: const Text('删除'),
                      onTap: () {
                        context
                            .read<FileSystemController>()
                            .removeFromCurrentFolder(widget.entity);
                        Navigator.of(ctx).pop();
                      },
                    )
                  ];
                },
                child: MouseRegion(
                  onEnter: (event) {
                    context
                        .read<FileSystemController>()
                        .changeCurrentWidgetId(widget.index);
                  },
                  onExit: (event) {
                    context
                        .read<FileSystemController>()
                        .changeCurrentWidgetId(-1);
                  },
                  child: Container(
                    decoration: decoration,
                    child: BaseFileWidget(
                      message:
                          "${widget.entity.name}, 包含${widget.entity.children.length}个文件",
                      data: widget.entity,
                    ),
                  ),
                ))));
  }
}
