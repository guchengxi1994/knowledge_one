// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_useful_widgets/flutter_useful_widgets.dart';
import 'package:knowledge_one/src/screens/initial/initial_controller.dart';
import 'package:provider/provider.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<InitialController>();
    return Container(
      child: Column(
        children: [
          _wrapper(
              _name("选择数据库"),
              SimpleDropdownButton(
                  hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 159, 159, 159), fontSize: 11),
                  icon: const Icon(Icons.arrow_drop_down,
                      color: Color.fromARGB(255, 232, 232, 232)),
                  buttonHeight: 30,
                  buttonDecoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(19)),
                      border: Border.all(
                          color: const Color.fromARGB(255, 232, 232, 232))),
                  hint: "选择状态",
                  value: context.watch<InitialController>().selectedDbType,
                  dropdownItems: ["mysql"],
                  onChanged: (v) {
                    context.read<InitialController>().changeSelectedDbType(v);
                  }),
              alignment: CrossAxisAlignment.center),
          _wrapper(_name("连接名"),
              _textFieldWrapper("", controller.linkNameController),
              alignment: CrossAxisAlignment.center),
          _wrapper(
              _name("主机"), _textFieldWrapper("", controller.hostNameController),
              alignment: CrossAxisAlignment.center),
          _wrapper(
              _name("端口"), _textFieldWrapper("", controller.portController),
              alignment: CrossAxisAlignment.center),
          _wrapper(_name("用户名"),
              _textFieldWrapper("", controller.usernameController),
              alignment: CrossAxisAlignment.center),
          _wrapper(
              _name("密码"), _textFieldWrapper("", controller.passwordController),
              alignment: CrossAxisAlignment.center),
          _wrapper(
              _name("数据库名"), _textFieldWrapper("", controller.dbNameController),
              alignment: CrossAxisAlignment.center),
        ],
      ),
    );
  }

  Widget _wrapper(Widget child1, Widget child2,
      {CrossAxisAlignment alignment = CrossAxisAlignment.start}) {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 20),
      child: Row(
        crossAxisAlignment: alignment,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          child1,
          child2,
        ],
      ),
    );
  }

  Widget _name(String s) {
    return Container(
      margin: const EdgeInsets.only(right: 30, left: 6),
      width: 100,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          s,
          style: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }

  Widget _textFieldWrapper(String hintText, TextEditingController controller) {
    return Container(
        width: 284,
        padding: const EdgeInsets.only(left: 19),
        height: 36,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 248, 248, 248),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: Border.all(
              color: const Color.fromARGB(255, 248, 248, 248), width: 0.5),
        ),
        child: TextField(
          style: const TextStyle(fontSize: 14),
          controller: controller,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(bottom: 16.0),
            hintText: hintText,
            hintStyle: const TextStyle(
                color: Color.fromARGB(255, 151, 151, 151), fontSize: 14),
            border: InputBorder.none,
          ),
        ));
  }
}
