// ignore_for_file: prefer_typing_uninitialized_variables, depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:knowledge_one/src/screens/workboard/components/tools_overlay.dart';
import 'package:knowledge_one/utils/utils.dart';
import 'package:provider/provider.dart';
import 'markdown_edit_controller.dart';
import 'package:path/path.dart' as path;

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

class _MarkdownScreenState extends State<MarkdownScreen>
    with TickerProviderStateMixin, OverlayStateMixin {
  late String mdData = "";
  var loadFuture;
  late final reg = RegExp(r"!\[(.*?)\]\([a-z|A-Z]{1}:(.*?)\)");
  final TextEditingController textEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final FocusNode focusNode = FocusNode();
  double fontSize = 14;
  bool canRead = true;

  @override
  void dispose() {
    if (canRead) {
      final p = path.basename(widget.filePath);
      final cachePath = "${DevUtils.executableDir.path}/_cache/$p";
      File f = File(cachePath);
      f.writeAsStringSync(textEditingController.text);
    }

    textEditingController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  loadData() async {
    try {
      File f = File(widget.filePath);
      String result = await f.readAsString();
      result = result.replaceAll(reg, "***本地资源无法渲染***");
      mdData = result;
      textEditingController.text = result;
    } catch (_) {
      canRead = false;
    }
  }

  @override
  void initState() {
    super.initState();
    loadFuture = loadData();
  }

  @override
  Widget build(BuildContext context) {
    late String suf = "";
    if (context.watch<MarkdownEditController>().mode == MdEditingMode.writing) {
      suf = "(创作中)";
    } else {
      suf = "(阅读中)";
    }

    return Scaffold(
      body: buildBody(),
      appBar: AppBar(
        actions: _buildAppbarAction(),
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
          "${widget.fileName} $suf",
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  List<Widget> _buildAppbarAction() {
    return [
      IconButton(
        tooltip: "切换模式",
        onPressed: () async {
          context.read<MarkdownEditController>().changeMode();
          setState(() {
            mdData = textEditingController.text;
          });
        },
        icon: Image.asset("assets/icons/switch.png"),
        iconSize: 30,
      ),
      IconButton(
          onPressed: () {
            toggleOverlay(Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: const EdgeInsets.only(top: 80),
                width: 200,
                height: 200,
                color: Colors.red,
              ),
            ));
          },
          icon: const Icon(
            Icons.work,
            color: Colors.black,
          )),
      const SizedBox(
        width: 20,
      )
    ];
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
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(focusNode);
              },
              child: SingleChildScrollView(
                controller: scrollController,
                padding: const EdgeInsets.only(
                    bottom: 100, left: 10, right: 10, top: 20),
                child: TextField(
                    focusNode: focusNode,
                    style: TextStyle(fontSize: fontSize),
                    key: const ValueKey<String>("md_editor"),
                    maxLines: null,
                    controller: textEditingController,
                    toolbarOptions: const ToolbarOptions(
                        copy: true, paste: true, cut: true, selectAll: true),
                    decoration:
                        const InputDecoration.collapsed(hintText: "请输入")),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
