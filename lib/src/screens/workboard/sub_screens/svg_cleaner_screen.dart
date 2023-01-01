// ignore_for_file: depend_on_referenced_packages, avoid_init_to_null

import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:knowledge_one/app_style.dart';
import 'package:knowledge_one/native.dart';
import 'package:knowledge_one/utils/smart_dialog_utils.dart';
import 'package:pretty_diff_text/pretty_diff_text.dart';

import 'base_sub_screens.dart';

class SvgCleanerScreen extends BaseSubScreen {
  SvgCleanerScreen({Key? key})
      : super(key: key, title: "Svg cleaner", actions: [
          Builder(builder: (context) {
            final justController = JustTheController();
            return JustTheTooltip(
                controller: justController,
                isModal: true,
                content: const SizedBox(
                  width: 300,
                  height: 300,
                ),
                child: IconButton(
                  tooltip: "What for?",
                  icon: const Icon(
                    Icons.info,
                    color: Colors.blueAccent,
                  ),
                  onPressed: () {
                    justController.showTooltip();
                  },
                ));
          })
        ]);

  @override
  State<BaseSubScreen> createState() => _SvgCleanerScreenState();

  @override
  BaseSubScreenState<BaseSubScreen> getState() {
    return _SvgCleanerScreenState();
  }
}

class _SvgCleanerScreenState<T> extends BaseSubScreenState<SvgCleanerScreen> {
  final List<XFile> _list = [];

  bool _dragging = false;

  Offset? offset;

  late CleanerResult? result = null;

  final TextEditingController controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Column(
              children: [
                DropTarget(
                  onDragDone: (detail) async {
                    setState(() {
                      _list.addAll(detail.files);
                    });

                    debugPrint('onDragDone:');
                    for (final file in detail.files) {
                      debugPrint('  ${file.path} ${file.name}'
                          '  ${await file.lastModified()}'
                          '  ${await file.length()}'
                          '  ${file.mimeType}');
                    }
                  },
                  onDragUpdated: (details) {
                    setState(() {
                      offset = details.localPosition;
                    });
                  },
                  onDragEntered: (detail) {
                    setState(() {
                      _dragging = true;
                      offset = detail.localPosition;
                    });
                  },
                  onDragExited: (detail) {
                    setState(() {
                      _dragging = false;
                      offset = null;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    height: 200,
                    width: 0.4 *
                        (MediaQuery.of(context).size.width -
                            AppStyle.sideMenuWidth),
                    color: _dragging
                        ? Colors.blue.withOpacity(0.4)
                        : Colors.black26,
                    child: Stack(
                      children: [
                        if (_list.isEmpty)
                          const Center(child: Text("Drop here"))
                        else
                          Text(_list.map((e) => e.path).join("\n")),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  thickness: 3,
                ),
                Expanded(
                    child: TextFormField(
                  controller: controller,
                  maxLines: null,
                  maxLength: null,
                  decoration: const InputDecoration(
                      hintText: "在这里粘贴svg样式字符串", border: InputBorder.none),
                ))
              ],
            )),
        const VerticalDivider(
          thickness: 3,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                tooltip: "convert",
                onPressed: () async {
                  if (_list.isEmpty && controller.text == "") {
                    return;
                  }

                  if (_list.isNotEmpty) {
                    result = await api.cleanSvgFile(filePath: _list.first.path);
                    if (result != null) {
                      debugPrint(result!.result);
                    } else {
                      SmartDialogUtils.error("转换失败");
                    }
                    _list.removeAt(0);
                    setState(() {});
                    return;
                  }

                  if (controller.text != "") {
                    result = await api.cleanSvgString(content: controller.text);
                    if (result != null) {
                      debugPrint(result!.result);
                    } else {
                      SmartDialogUtils.error("转换失败");
                    }
                    setState(() {});
                    return;
                  }
                },
                icon: const Icon(
                  Icons.arrow_forward,
                  color: Colors.blueAccent,
                )),
            IconButton(
                tooltip: "refresh",
                onPressed: () async {
                  result = null;
                  controller.text = "";
                  _list.clear();
                  setState(() {});
                },
                icon: const Icon(
                  Icons.refresh,
                  color: Colors.blueAccent,
                )),
            if (result != null)
              IconButton(
                  tooltip: "save",
                  onPressed: () async {},
                  icon: const Icon(
                    Icons.save,
                    color: Colors.blueAccent,
                  )),
          ],
        ),
        const VerticalDivider(
          thickness: 3,
        ),
        Expanded(
            flex: 1,
            child: Column(
              children: [
                Expanded(
                    flex: 1,
                    child: result?.result == null
                        ? const SizedBox()
                        : SvgPicture.string(result!.result)),
                const Divider(
                  thickness: 3,
                ),
                Expanded(
                    flex: 2,
                    child: result == null
                        ? SizedBox()
                        : PrettyDiffText(
                            oldText: result!.origin, newText: result!.result)),
                const Divider(
                  thickness: 1,
                ),
                result == null
                    ? SizedBox()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("运行时间： ${result!.duration}ms"),
                          Text("变化比例： ${result!.radio.roundToDouble()}%")
                        ],
                      )
              ],
            )),
      ],
    );
  }
}
