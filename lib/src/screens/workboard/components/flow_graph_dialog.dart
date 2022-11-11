import 'package:flutter/material.dart';
import 'package:flutter_graph/flutter_graph.dart';
import 'package:knowledge_one/native.dart';

class FileChangelogGraph extends StatefulWidget {
  const FileChangelogGraph({Key? key, required this.changelogs})
      : super(key: key);
  final List<FileChangelog> changelogs;

  @override
  State<FileChangelogGraph> createState() => _FileChangelogGraphState();
}

class _FileChangelogGraphState extends State<FileChangelogGraph> {
  NodeData data = NodeData();

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: Stack(
        children: [
          FlowGraph(
            data: data,
            nodes: [],
          )
        ],
      ),
    );
  }
}
