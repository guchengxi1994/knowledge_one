import 'package:flutter/material.dart';

class ScrollableWidget extends StatelessWidget {
  ScrollableWidget(
      {Key? key, required this.child, this.height = 500, required this.width})
      : super(key: key);

  final Widget child;
  final double width;
  final double height;

  final ScrollController controller = ScrollController();
  final ScrollController controller2 = ScrollController();
  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height,
        child: Stack(children: [
          Scrollbar(
            controller: controller2,
            thumbVisibility: true,
            child: SingleChildScrollView(
              controller: controller2,
              scrollDirection: Axis.horizontal,
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: SingleChildScrollView(
                  key: _key,
                  scrollDirection: Axis.vertical,
                  controller: controller,
                  child: child,
                ),
              ),
            ),
          ),
        ]));
  }
}

class MyScrollBar extends StatelessWidget {
  const MyScrollBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 60,
      decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.blue),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Icon(
            Icons.arrow_drop_up,
            size: 18,
          ),
          Icon(
            Icons.arrow_drop_down,
            size: 18,
          ),
        ],
      ),
    );
  }
}
