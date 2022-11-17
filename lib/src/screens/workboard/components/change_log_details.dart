// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'dart:io';

import 'package:grpc/grpc.dart';
import 'package:knowledge_one/rpc_controller.dart';
import 'package:knowledge_one/src/extensions/date_time_extension.dart';
import 'package:knowledge_one/src/rpc/file_restore.pbgrpc.dart';
import 'package:knowledge_one/utils/utils.dart';
import 'package:path/path.dart' as p;

import 'package:flutter/material.dart';
import 'package:knowledge_one/native.dart';
import 'package:filesize/filesize.dart';
import 'package:provider/provider.dart';

class ChangelogDetails extends StatelessWidget {
  const ChangelogDetails(
      {Key? key,
      required this.model,
      required this.diffSize,
      required this.isLast})
      : super(key: key);
  final FileChangelog model;
  final int diffSize;
  final bool isLast;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(children: [
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
          width: 500,
          height: 500,
          color: Colors.white,
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "文件详细信息",
                style: TextStyle(fontSize: 20),
              ),
              _wrapper(
                  _name("名称"),
                  Text(
                    p.basename(model.filePath!),
                    maxLines: null,
                  )),
              _wrapper(
                  _name("文件路径"),
                  Text(
                    model.filePath ?? "",
                    maxLines: null,
                  )),
              _wrapper(
                  _name("文件大小"),
                  Text(
                    filesize(model.fileLength),
                    maxLines: null,
                  )),
              _wrapper(
                  _name("diff文件大小"),
                  Text(
                    filesize(diffSize),
                    maxLines: null,
                  )),
              _wrapper(
                  _name("文件哈希"),
                  Text(
                    model.versionId ?? "",
                    maxLines: null,
                  )),
              _wrapper(
                  _name("上传时间"),
                  Text(
                    model.createAt.toLocal().toChinese(),
                    maxLines: null,
                  )),
              const SizedBox(
                height: 20,
              ),
              if (!isLast)
                ElevatedButton(
                    onPressed: () async {
                      debugPrint(model.fileId.toString());
                      final result = await api.getChangelogFromId(
                        id: model.fileId,
                        fileHash: model.versionId!,
                      );
                      if (result != null) {
                        debugPrint("logs:${result.length}");
                        final currentFilePath = result.last.filePath!;
                        final diffs =
                            result.map((e) => e.diffPath ?? "").toList();
                        final fileSize =
                            result.map((e) => e.fileLength).toList();
                        final saveDir =
                            "${DevUtils.executableDir.path}/_restore";

                        final channel = ClientChannel(
                          'localhost',
                          port: 15556,
                          options: const ChannelOptions(
                              credentials: ChannelCredentials.insecure()),
                        );

                        final stub = FileRestoreClient(channel);
                        RestoreRequest request = RestoreRequest(
                            filePath: currentFilePath,
                            diffs: diffs,
                            fileSize: fileSize,
                            saveDir: saveDir);

                        await context
                            .read<RPCController>()
                            .startFileChangelogTracingRPC();

                        try {
                          var response = await stub.restore(request);
                          debugPrint('服务端返回信息: ${response.message}');
                        } catch (e) {
                          debugPrint('Caught error: $e');
                        }
                        await channel.shutdown();
                      }
                    },
                    child: const Text("回退到这个版本"))
            ],
          )),
        ),
        Positioned(
          right: 20,
          top: 20,
          child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.close,
                color: Colors.red,
              )),
        )
      ]),
    );
  }

  Widget _name(String s) {
    return Container(
      margin: const EdgeInsets.only(right: 30, left: 6),
      width: 150,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          s,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _wrapper(Widget child1, Widget child2) {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          child1,
          Expanded(child: child2),
        ],
      ),
    );
  }
}
