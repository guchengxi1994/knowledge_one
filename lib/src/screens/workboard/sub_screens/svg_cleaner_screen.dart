// ignore_for_file: depend_on_referenced_packages

import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:cross_file/cross_file.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

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
                    height: 200,
                    width: 200,
                    color: _dragging
                        ? Colors.blue.withOpacity(0.4)
                        : Colors.black26,
                    child: Stack(
                      children: [
                        if (_list.isEmpty)
                          const Center(child: Text("Drop here"))
                        else
                          Text(_list.map((e) => e.path).join("\n")),
                        if (offset != null)
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              '$offset',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          )
                      ],
                    ),
                  ),
                ),
                const Divider(
                  thickness: 3,
                ),
                Expanded(child: TextFormField())
              ],
            )),
        const VerticalDivider(
          thickness: 3,
        ),
        const Expanded(flex: 1, child: SizedBox()),
      ],
    );
  }
}
