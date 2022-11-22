// ignore_for_file: use_build_context_synchronously, unused_import

import 'dart:io';

import 'package:contextmenu/contextmenu.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:knowledge_one/app_style.dart';
import 'package:knowledge_one/native.dart';
import 'package:knowledge_one/rpc_controller.dart';

import 'package:knowledge_one/src/rpc/file_diff.pbgrpc.dart';
import 'package:knowledge_one/src/screens/markdown_edit/markdown_edit_screen.dart';
import 'package:knowledge_one/src/screens/pdf_viewer/pdf_viewer_screen.dart';
import 'package:knowledge_one/src/screens/quill_eidt/quill_edit_screen.dart';
import 'package:knowledge_one/src/screens/workboard/providers/file_system_controller.dart';
import 'package:knowledge_one/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/models.dart';
import 'base_file_widget.dart';
import 'flow_graph_dialog.dart';
import 'preview_dialog.dart';
import 'package:path/path.dart' as P;

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
  late FileEntity currentEntity;

  @override
  void initState() {
    super.initState();
    currentEntity = widget.entity;
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
        debugPrint(currentEntity.path);
        await showGeneralDialog(
            context: context,
            pageBuilder: (context, animation, secondaryAnimation) {
              return Center(
                child: PreviewDialog(
                  width: 800,
                  height: 600,
                  filePath: currentEntity.path!,
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
                          '是不是要把"${currentEntity.name}"移入"${entity.name}"中?'),
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
            builder: (ctx) => _actions(ctx),
            child: MouseRegion(
              onEnter: (event) {
                context
                    .read<FileSystemController>()
                    .changeCurrentWidgetId(widget.index);
              },
              onExit: (event) {
                context.read<FileSystemController>().changeCurrentWidgetId(-1);
              },
              child: Container(
                // color: context.select<FileSystemController, int>(
                //             (value) => value.currentWidgetId) ==
                //         widget.index
                //     ? AppStyle.selectedBackgroundColor
                //     : Colors.transparent,
                decoration: BoxDecoration(
                  // color: AppStyle.selectedBackgroundColor, // 背景色
                  color: context.select<FileSystemController, int>(
                              (value) => value.currentWidgetId) ==
                          widget.index
                      ? AppStyle.selectedBackgroundColor
                      : Colors.transparent,
                  border: Border.all(
                      color: context.select<FileSystemController, int>(
                                  (value) => value.currentWidgetId) ==
                              widget.index
                          ? Colors.blue
                          : Colors.transparent,
                      width: 0.5), // border
                  borderRadius: BorderRadius.circular((1)), // 圆角
                ),
                child: BaseFileWidget(
                  data: currentEntity,
                ),
              ),
            ),
          )),
    );
  }

  List<Widget> _actions(BuildContext ctx) {
    return [
      ListTile(
        leading: Icon(
          Icons.file_open,
          color: AppStyle.appGreen,
        ),
        title: const Text('以系统默认程序打开'),
        onTap: () async {
          final Uri uri = Uri.file(currentEntity.path!);
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
          Navigator.of(ctx).pop();
          await Navigator.of(context).push(MaterialPageRoute(builder: (c) {
            return MarkdownEditScreen(
              filePath: currentEntity.path!,
              fileName: currentEntity.name,
            );
          }));
          final p = P.basename(currentEntity.path!);
          final cachePath = "${DevUtils.executableDir.path}/_cache/$p";
          await context.read<RPCController>().startFileChangelogTracingRPC();
          final channel = ClientChannel(
            'localhost',
            port: 15556,
            options: const ChannelOptions(
                credentials: ChannelCredentials.insecure()),
          );
          final stub = FileDiffClient(channel);
          try {
            final currentTime = DateTime.now().millisecondsSinceEpoch;
            await stub.generateDiff(GenerateDiffRequest()
              ..after = cachePath
              ..before = currentEntity.path!
              ..savePath =
                  "${DevUtils.executableDir.path}/_diff/$currentTime.mtx");

            await context.read<FileSystemController>().changeFileHash2(
                cachePath, currentEntity,
                diffPath:
                    "${DevUtils.executableDir.path}/_diff/$currentTime.mtx");
          } catch (e) {
            debugPrint(e.toString());
          }
          await channel.shutdown();
        },
      ),
      ListTile(
        leading: Icon(
          Icons.file_open,
          color: AppStyle.appGreen,
        ),
        title: const Text('以内置富文本打开'),
        onTap: () async {
          Navigator.of(ctx).pop();
          await Navigator.of(context).push(MaterialPageRoute(builder: (c) {
            return QuillEditScreen(
              filePath: currentEntity.path!,
              fileName: currentEntity.name,
              fileId: currentEntity.fileId ?? -1,
            );
          }));
          final p = P.basename(currentEntity.path!);
          final cachePath = "${DevUtils.executableDir.path}/_cache/$p";
          await context.read<RPCController>().startFileChangelogTracingRPC();
          final channel = ClientChannel(
            'localhost',
            port: 15556,
            options: const ChannelOptions(
                credentials: ChannelCredentials.insecure()),
          );
          final stub = FileDiffClient(channel);
          try {
            final currentTime = DateTime.now().millisecondsSinceEpoch;
            await stub.generateDiff(GenerateDiffRequest()
              ..after = cachePath
              ..before = currentEntity.path!
              ..savePath =
                  "${DevUtils.executableDir.path}/_diff/$currentTime.mtx");

            await context.read<FileSystemController>().changeFileHash2(
                cachePath, currentEntity,
                diffPath:
                    "${DevUtils.executableDir.path}/_diff/$currentTime.mtx");
          } catch (e) {
            debugPrint(e.toString());
          }
          await channel.shutdown();
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
            await Navigator.of(context).push(MaterialPageRoute(builder: (c) {
              return PdfViewerScreen(
                filePath: currentEntity.path!,
                fileName: currentEntity.name,
              );
            }));
            Navigator.of(ctx).pop();
          },
        ),
      if (currentEntity.versionControl != 1)
        ListTile(
          leading: Icon(
            Icons.verified,
            color: AppStyle.appBlue,
          ),
          title: const Text('启用版本追踪'),
          onTap: () async {
            if (currentEntity.fileHash == null) {
              SmartDialogUtils.error("文件Hash值为空");
            }

            if (currentEntity.versionControl != 1) {
              final r = await api.changeVersionControl(
                  fileHash: currentEntity.fileHash!);
              if (r == 1) {
                SmartDialogUtils.error("失败");
              } else {
                setState(() {
                  currentEntity.versionControl = 1;
                  currentEntity.iconPath = "assets/icons/vc_file.png";
                });
                context
                    .read<FileSystemController>()
                    .changeVersionControlStatus(currentEntity);
              }
            } else {
              SmartDialogUtils.message("已开启版本控制");
            }
            Navigator.of(ctx).pop();
          },
        ),
      if (currentEntity.versionControl == 1)
        ListTile(
          leading: Icon(
            Icons.search,
            color: AppStyle.appBlue,
          ),
          title: const Text('查看修改链路'),
          onTap: () async {
            Navigator.of(ctx).pop();
            final result =
                await api.getFileLogs(fileHash: currentEntity.fileHash!);
            if (result != null) {
              debugPrint("length:${result.length}");
              await showGeneralDialog(
                  context: context,
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return Center(
                      child: FileChangelogGraph(
                        changelogs: result,
                      ),
                    );
                  });
            }
          },
        ),
      if (currentEntity.versionControl == 1)
        ListTile(
          leading: Icon(
            Icons.verified_user,
            color: AppStyle.appBlue,
          ),
          title: const Text('上传新版本文件'),
          onTap: () async {
            Navigator.of(ctx).pop();
            FilePickerResult? result = await FilePicker.platform.pickFiles();

            if (result != null) {
              // File file = File(result.files.single.path);
              String filePath = result.files.single.path!;
              String fileName = result.files.single.name;
              debugPrint(filePath);

              /// 这里启动 rpc
              await context
                  .read<RPCController>()
                  .startFileChangelogTracingRPC();
              final channel = ClientChannel(
                'localhost',
                port: 15556,
                options: const ChannelOptions(
                    credentials: ChannelCredentials.insecure()),
              );
              final stub = FileDiffClient(channel);
              try {
                final currentTime = DateTime.now().millisecondsSinceEpoch;
                await stub.generateDiff(GenerateDiffRequest()
                  ..after = filePath
                  ..before = currentEntity.path!
                  ..savePath =
                      "${DevUtils.executableDir.path}/_diff/$currentTime.mtx");

                final newFileHash = await api.getFileHash(filePath: filePath);

                NativeFileNewVersion nativeFileNewVersion = NativeFileNewVersion(
                    prevFilePath: currentEntity.path!,
                    prevFileHash: currentEntity.fileHash!,
                    prevFileName: currentEntity.name,
                    newVersionFilePath: filePath,
                    newVersionFileHash: newFileHash,
                    newVersionFileName: fileName,
                    diffPath:
                        "${DevUtils.executableDir.path}/_diff/$currentTime.mtx");
                final r =
                    await api.createNewVersion(model: nativeFileNewVersion);
                debugPrint(r.toString());
                if (r != 0) {
                  SmartDialogUtils.error("失败");
                } else {
                  SmartDialogUtils.ok("成功");
                  setState(() {
                    currentEntity.fileHash = newFileHash;
                    currentEntity.name = fileName;
                    currentEntity.path = filePath;
                  });
                  context
                      .read<FileSystemController>()
                      .changeVersionControlStatus(currentEntity);
                }
              } catch (e) {
                debugPrint('Caught error: $e');
                SmartDialogUtils.message("失败");
              }
              await channel.shutdown();
            }
          },
        ),
      ListTile(
        leading: const Icon(
          Icons.delete,
          color: Colors.red,
        ),
        title: const Text('删除'),
        onTap: () async {
          // debugPrint(currentEntity.fileHash);
          if (currentEntity.fileHash == null) {
            SmartDialogUtils.error("文件Hash不存在");
            Navigator.of(ctx).pop();
            return;
          }
          final r =
              await api.deleteFileByFileHash(fileHash: currentEntity.fileHash!);
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
  }
}
