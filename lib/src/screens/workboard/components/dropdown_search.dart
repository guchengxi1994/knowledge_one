/// a copy of
///
/// https://github.com/guchengxi1994/taichi/tree/dev/taichi_core/lib/src/UI/dropdown_search

import 'package:flutter/material.dart';

typedef FutureFunc = Future<List<String>> Function();

class DropDownSearch extends StatefulWidget {
  DropDownSearch(
      {Key? key,
      required this.datas,
      this.textFieldHeight = 50,
      this.searchBoxWidth = 300,
      this.searchBoxHeight = 300,
      this.textFieldWidth = 300,
      this.hintText = "do_something",
      this.onBoxItemTap,
      this.onTextChange,
      required this.initialString})
      : assert(datas.contains(initialString)),
        super(key: key);
  final List<String> datas;

  final double textFieldWidth;
  final double textFieldHeight;
  final double searchBoxWidth;
  final double searchBoxHeight;
  final String hintText;
  final StringCallback? onTextChange;
  final StringCallback? onBoxItemTap;
  final String initialString;

  @override
  State<DropDownSearch> createState() => DropDownSearchState();
}

class DropDownSearchState extends State<DropDownSearch> {
  bool show = false;
  late List<String> d = widget.datas;
  final GlobalKey<SearchBoxState> boxkey = GlobalKey();
  final TextEditingController controller = TextEditingController();
  final LayerLink layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  @override
  Widget build(BuildContext context) {
    controller.value = TextEditingValue(
        text: widget.initialString,
        selection: TextSelection.fromPosition(TextPosition(
            affinity: TextAffinity.downstream,
            offset: widget.initialString.length)));

    return CompositedTransformTarget(
        link: layerLink,
        child: DropdownSearchTextField(
          isOverlayShowing: show,
          width: widget.textFieldWidth,
          height: widget.textFieldHeight,
          hintText: widget.hintText,
          controller: controller,
          onTextChange: (s) {
            d = widget.datas
                .where(
                  (element) => element.contains(s),
                )
                .toList();
            if (boxkey.currentState != null) {
              if (s == "") {
                d = widget.datas;
              }
              boxkey.currentState?.changeDatas(d);
            }
            if (widget.onTextChange != null) {
              widget.onTextChange!(s);
            }
          },
          onIconTap: () {
            toggleOverlay(context);
          },
        ));
  }

  void toggleOverlay(BuildContext context) {
    // debugPrint("_toggleOverlay");
    if (!show) {
      // _showOverlay(context);
      _overlayEntry = OverlayEntry(builder: (c) {
        return UnconstrainedBox(
          child: CompositedTransformFollower(
            link: layerLink,

            ///主体的位置
            followerAnchor: Alignment.bottomCenter,

            ///这个是浮窗的位置
            targetAnchor: Alignment.topCenter,
            offset: Offset(0, widget.searchBoxHeight + widget.textFieldHeight),
            child: Material(
              // color: Colors.amber,
              child: SearchBox(
                key: boxkey,
                datas: widget.datas,
                width: widget.searchBoxWidth,
                height: widget.searchBoxHeight,
                onItemTap: (index) {
                  controller.text = d[index];
                  if (widget.onBoxItemTap != null) {
                    widget.onBoxItemTap!(controller.text);
                  }
                  hideOverlay();
                  show = !show;
                  setState(() {});
                },
              ),
            ),
          ),
        );
      });
      OverlayState? overlayState = Navigator.of(context).overlay;
      // debugPrint("overlayState $overlayState");
      overlayState?.insert(_overlayEntry!);
    } else {
      hideOverlay();
    }
    show = !show;
    setState(() {});
  }

  void hideOverlay() {
    try {
      _overlayEntry?.remove();
    } catch (_) {}
  }
}

typedef StringCallback = Function(String s);

class DropdownSearchTextField extends StatelessWidget {
  const DropdownSearchTextField(
      {Key? key,
      required this.controller,
      this.width = 300,
      this.height = 50,
      this.hintText = "",
      required this.onIconTap,
      this.onTextChange,
      required this.isOverlayShowing})
      : super(key: key);
  final TextEditingController controller;
  final double width;
  final double height;
  final String hintText;
  final VoidCallback onIconTap;
  final StringCallback? onTextChange;
  final bool isOverlayShowing;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Colors.white24,
      child: TextField(
        controller: controller,
        onChanged: (s) {
          if (onTextChange != null) {
            onTextChange!(s);
          }
        },
        decoration: InputDecoration(
          // labelText: "用户名",
          hintText: hintText,
          border: const OutlineInputBorder(),
          suffixIcon: InkWell(
            onTap: onIconTap,
            child: isOverlayShowing
                ? Transform.rotate(
                    angle: -3.1415 / 2,
                    child: const Icon(Icons.chevron_right),
                  )
                : Transform.rotate(
                    angle: 3.1415 / 2,
                    child: const Icon(Icons.chevron_right),
                  ),
          ),
        ),
      ),
    );
  }
}

typedef ItemTapCallBack = Function(int index);

class SearchBox extends StatefulWidget {
  const SearchBox(
      {Key? key,
      this.width = 300,
      this.height = 300,
      this.onItemTap,
      required this.datas})
      : super(key: key);
  final double width;
  final double height;

  final ItemTapCallBack? onItemTap;
  final List<String> datas;

  @override
  State<SearchBox> createState() => SearchBoxState();
}

class SearchBoxState extends State<SearchBox> {
  late List<String> _datas = [];

  @override
  void initState() {
    super.initState();
    _datas = widget.datas;
  }

  changeDatas(List<String> l) {
    _datas = l;
    setState(() {});
  }

  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(
              color: const Color.fromARGB(255, 205, 183, 183), width: 0.5),
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(10))),
      height: widget.height,
      width: widget.width,
      child: ListView.builder(
          itemCount: _datas.length,
          controller: scrollController,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                if (widget.onItemTap != null) {
                  widget.onItemTap!(index);
                }
              },
              child: Text(_datas[index]),
            );
          }),
    );
  }
}
