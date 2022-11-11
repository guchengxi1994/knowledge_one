import 'package:flutter/material.dart';
import 'package:flutter_graph/flutter_graph.dart';
import 'package:knowledge_one/native.dart';

import 'change_log_details.dart';

class FileChangelogGraph extends StatefulWidget {
  const FileChangelogGraph(
      {Key? key, required this.changelogs, this.width = 800, this.height = 600})
      : super(key: key);
  final List<FileChangelog> changelogs;
  final double width;
  final double height;

  @override
  State<FileChangelogGraph> createState() => _FileChangelogGraphState();
}

class _FileChangelogGraphState extends State<FileChangelogGraph> {
  NodeData data = NodeData();
  List<NodeData> ref = [];
  @override
  void initState() {
    super.initState();
    data.index = 0;
    data.isRoot = true;
    data.children = [];
    ref.add(data);

    for (int i = 1; i < widget.changelogs.length; i++) {
      NodeData node = NodeData();
      node.isRoot = false;
      node.children = [];
      node.index = i;
      ref.last.children!.add(node);
      ref.add(node);
    }
  }

  List<NodeWidget> buildChildren() {
    List<NodeWidget> widgets = [];
    for (int i = 0; i < widget.changelogs.length; i++) {
      int diffSize;
      if (i == 0) {
        diffSize = 0;
      } else {
        diffSize = widget.changelogs[i].fileLength -
            widget.changelogs[i - 1].fileLength;
      }
      widgets.add(
        NodeWidget(
          backgroundColor: Colors.transparent,
          onTap: () async {
            await showGeneralDialog(
                context: context,
                pageBuilder: (context, animation, secondaryAnimation) {
                  return Center(
                    child: ChangelogDetails(
                      model: widget.changelogs[i],
                      diffSize: diffSize,
                      isLast: i == widget.changelogs.length - 1,
                    ),
                  );
                });
          },
          index: ref[i].index!,
          child: Container(
            padding: const EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: Image.asset("assets/icons/version.png"),
                ),
                Text(
                  widget.changelogs[i].versionId ?? "",
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
        ),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: Stack(
          children: [
            FlowGraph(
              data: data,
              nodes: buildChildren(),
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
          ],
        ),
      ),
    );
  }
}
