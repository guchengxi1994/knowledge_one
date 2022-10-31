import 'package:flutter/material.dart';

import '../models/file_entity.dart';

// ignore: must_be_immutable
class FileWidget extends StatefulWidget {
  FileWidget(
      {Key? key,
      required this.index,
      this.onDoubleClick,
      this.tooltip,
      required this.entity})
      : super(key: key);
  VoidCallback? onDoubleClick;
  String? tooltip;
  int index;
  FileEntity entity;

  @override
  State<FileWidget> createState() => _FileWidgetState();
}

class _FileWidgetState extends State<FileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
