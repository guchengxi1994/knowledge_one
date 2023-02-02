import 'package:flutter/material.dart';

abstract class BaseSubScreen extends StatefulWidget {
  const BaseSubScreen(
      {Key? key, this.actions = const [], required this.title, this.leading})
      : super(key: key);
  final List<Widget> actions;
  final String title;
  final Widget? leading;

  @override
  State<BaseSubScreen> createState() {
    // ignore: no_logic_in_create_state
    return getState();
  }

  BaseSubScreenState getState();
}

class BaseSubScreenState<T extends BaseSubScreen> extends State<T> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border:
                  Border(top: BorderSide(color: Colors.grey[200]!, width: 2))),
          child: baseBuild(context)),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.black),
        ),
        actions: widget.actions,
        leading: widget.leading,
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(T oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void reassemble() {
    super.reassemble();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  void onCreate() {}
  void onDes() {}
  baseBuild(BuildContext context) {}

  @override
  void dispose() {
    super.dispose();
  }
}
