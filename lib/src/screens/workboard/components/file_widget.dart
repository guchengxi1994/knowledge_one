// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:contextmenu/contextmenu.dart';
import 'package:flutter/material.dart';
import 'package:knowledge_one/app_style.dart';
import 'package:knowledge_one/src/native.dart';
import 'package:knowledge_one/src/screens/markdown_edit/markdown_edit_screen.dart';
import 'package:knowledge_one/src/screens/pdf_viewer/pdf_viewer_screen.dart';
import 'package:knowledge_one/src/screens/quill_eidt/quill_edit_screen.dart';
import 'package:knowledge_one/src/screens/workboard/providers/file_system_controller.dart';
import 'package:knowledge_one/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/models.dart';
import 'base_file_widget.dart';
import 'preview_dialog.dart';

// ignore: must_be_immutable
class FileWidget extends StatefulWidget {
  FileWidget(
      {Key? key, required this.index, this.onDoubleClick, required this.entity})
      : super(key: key);
  VoidCallback? onDoubleClick;
  int index;
  FileEntity entity;

  @override
  State<FileWidget> createState() => _FileWidgetState();
}

class _FileWidgetState extends State<FileWidget> {
  late double dx = 0;
  late double dy = 0;
  final iconSize = AppStyle.fileWidgetSize;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dx = (widget.index %
            ((MediaQuery.of(context).size.width - AppStyle.sideMenuWidth) ~/
                (iconSize + 10))) *
        (iconSize + 10);
    dy = (widget.index ~/
            ((MediaQuery.of(context).size.width - AppStyle.sideMenuWidth) ~/
                (iconSize + 10))) *
        (iconSize);

    context
        .read<FileSystemController>()
        .changeWidgetStatus(widget.index, WidgetStatus(dx: dx, dy: dy));

    return GestureDetector(
      onDoubleTap: () async {
        debugPrint(widget.entity.path);
        await showGeneralDialog(
            context: context,
            pageBuilder: (context, animation, secondaryAnimation) {
              return Center(
                child: PreviewDialog(
                  width: 800,
                  height: 600,
                  filePath: widget.entity.path!,
                ),
              );
            });
      },
      onPanDown: (details) {
        context
            .read<FileSystemController>()
            .changeClickPoint(details.localPosition);
      },
      child: Draggable(
          onDragStarted: () {
            context.read<FileSystemController>().changeGragStatus(true);
          },
          onDragEnd: (details) async {
            context.read<FileSystemController>().changeGragStatus(false);
            // print(details.offset);
            BaseFileEntity? entity = context
                .read<FileSystemController>()
                .findObjectByOffset(details.offset);
            // print(entity);
            if (entity != null && entity is FolderEntity) {
              int result = await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                          '是不是要把"${widget.entity.name}"移入"${entity.name}"中?'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(1);
                            },
                            child: const Text("确定")),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(0);
                            },
                            child: const Text("取消")),
                      ],
                    );
                  });
              if (result == 1) {
                context
                    .read<FileSystemController>()
                    .moveToFolder(widget.index, entity);
              }
            }
          },
          feedback: Container(
            margin: EdgeInsets.only(
                left: context.watch<FileSystemController>().clickPoint.dx,
                top: context.watch<FileSystemController>().clickPoint.dy),
            width: 20,
            height: 20,
            color: AppStyle.appBlue,
          ),
          child: ContextMenuArea(
            width: 300,
            builder: (ctx) {
              return [
                ListTile(
                  leading: Icon(
                    Icons.file_open,
                    color: AppStyle.appGreen,
                  ),
                  title: const Text('以系统默认程序打开'),
                  onTap: () async {
                    final Uri uri = Uri.file(widget.entity.path!);
                    try {
                      if (!File(uri.toFilePath()).existsSync()) {
                        // throw '$uri does not exist!';
                        SmartDialogUtils.error("文件已不存在,请删除");
                        return;
                      }
                      if (!await launchUrl(uri)) {
                        // throw 'Could not launch $uri';
                        SmartDialogUtils.error("无法打开文件");
                        return;
                      }
                    } catch (_) {
                      SmartDialogUtils.error("仅支持英文路径😅");
                    }

                    Navigator.of(ctx).pop();
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.file_open,
                    color: AppStyle.appGreen,
                  ),
                  title: const Text('以内置Markdown打开'),
                  onTap: () async {
                    await Navigator.of(context)
                        .push(MaterialPageRoute(builder: (c) {
                      return MarkdownEditScreen(
                        filePath: widget.entity.path!,
                        fileName: widget.entity.name,
                      );
                    }));
                    Navigator.of(ctx).pop();
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.file_open,
                    color: AppStyle.appGreen,
                  ),
                  title: const Text('以内置富文本打开'),
                  onTap: () async {
                    await Navigator.of(context)
                        .push(MaterialPageRoute(builder: (c) {
                      return QuillEditScreen(
                        filePath: widget.entity.path!,
                        fileName: widget.entity.name,
                      );
                    }));
                    Navigator.of(ctx).pop();
                  },
                ),
                if (!DevUtils.isLinux)
                  ListTile(
                    leading: Icon(
                      Icons.file_open,
                      color: AppStyle.appGreen,
                    ),
                    title: const Text('以内置PDF Previewer打开'),
                    onTap: () async {
                      await Navigator.of(context)
                          .push(MaterialPageRoute(builder: (c) {
                        return PdfViewerScreen(
                          filePath: widget.entity.path!,
                          fileName: widget.entity.name,
                        );
                      }));
                      Navigator.of(ctx).pop();
                    },
                  ),
                ListTile(
                  leading: Icon(
                    Icons.verified,
                    color: AppStyle.appBlue,
                  ),
                  title: const Text('启用版本追踪'),
                  onTap: () {
                    Navigator.of(ctx).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  title: const Text('删除'),
                  onTap: () async {
                    // debugPrint(widget.entity.fileHash);
                    if (widget.entity.fileHash == null) {
                      SmartDialogUtils.error("文件Hash不存在");
                      Navigator.of(ctx).pop();
                      return;
                    }
                    final r = await api.deleteFileByFileHash(
                        fileHash: widget.entity.fileHash!);
                    if (r == 1) {
                      SmartDialogUtils.error("删除失败");
                      Navigator.of(ctx).pop();
                      return;
                    }
                    context
                        .read<FileSystemController>()
                        .removeFromCurrentFolder(widget.entity);
                    Navigator.of(ctx).pop();
                  },
                ),
              ];
            },
            child: MouseRegion(
              onHover: (event) {},
              onEnter: (event) {
                if (event.localPosition.dx > AppStyle.fileWidgetSize - 5 &&
                    event.localPosition.dy > AppStyle.fileWidgetSize - 5 &&
                    event.localPosition.dx < 5 &&
                    event.localPosition.dy < 5) {
                  return;
                }
                context
                    .read<FileSystemController>()
                    .changeCurrentWidgetId(widget.index);
              },
              onExit: (event) {
                if (event.localPosition.dx > AppStyle.fileWidgetSize - 5 &&
                    event.localPosition.dy > AppStyle.fileWidgetSize - 5 &&
                    event.localPosition.dx < 5 &&
                    event.localPosition.dy < 5) {
                  return;
                }
                context.read<FileSystemController>().changeCurrentWidgetId(-1);
              },
              child: Container(
                decoration: context.select<FileSystemController, int>(
                            (value) => value.currentWidgetId) ==
                        widget.index
                    ? BoxDecoration(
                        color: AppStyle.selectedBackgroundColor, // 背景色
                        border: Border.all(
                            color: Colors.blue, width: 0.5), // border
                        borderRadius: BorderRadius.circular((1)), // 圆角
                      )
                    : null,
                // child: Tooltip(
                //   margin: const EdgeInsets.only(top: 20),
                //   message: widget.tooltip ?? widget.entity.name,
                //   child: BaseFileWidget(
                //     data: widget.entity,
                //   ),
                // ),
                child: BaseFileWidget(
                  data: widget.entity,
                ),
              ),
            ),
          )),
    );
  }
}
