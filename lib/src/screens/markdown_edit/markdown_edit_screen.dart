// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import 'markdown_edit_controller.dart';

class MarkdownEditScreen extends StatelessWidget {
  const MarkdownEditScreen(
      {Key? key, required this.filePath, required this.fileName})
      : super(key: key);
  final String filePath;
  final String fileName;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MarkdownEditController())
      ],
      builder: (context, child) {
        return MarkdownScreen(filePath: filePath, fileName: fileName);
      },
    );
  }
}

class MarkdownScreen extends StatefulWidget {
  const MarkdownScreen(
      {Key? key, required this.filePath, required this.fileName})
      : super(key: key);
  final String filePath;
  final String fileName;

  @override
  State<MarkdownScreen> createState() => _MarkdownScreenState();
}

class _MarkdownScreenState extends State<MarkdownScreen> {
  late String mdData = "";
  var loadFuture;
  // r"!\[(.*?)\]\((.*?)\)"
  // r"^\!\[.*\][(][a-z]|[A-Z]{1}:.*[)]"
  late final reg = RegExp(r"!\[(.*?)\]\([a-z|A-Z]{1}:(.*?)\)");

  loadData() async {
    try {
      File f = File(widget.filePath);
      String result = await f.readAsString();
      result = result.replaceAll(reg, "***本地资源无法渲染***");
      mdData = result;
    } catch (_) {}
  }

  @override
  void initState() {
    super.initState();
    loadFuture = loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.chevron_left_outlined,
              color: Colors.black,
              size: 30,
            )),
        backgroundColor: Colors.grey[200],
        elevation: 0,
        centerTitle: false,
        title: Text(
          widget.fileName,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  buildBody() {
    return FutureBuilder(
        future: loadFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (context.watch<MarkdownEditController>().mode ==
                MdEditingMode.reading) {
              return Markdown(
                data: mdData,
              );
            }
            return Container();
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
