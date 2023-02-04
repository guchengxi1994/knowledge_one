// ignore_for_file: avoid_init_to_null, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_useful_widgets/flutter_useful_widgets.dart';
import 'package:knowledge_one/redis_client/redis_controller.dart';
import 'package:knowledge_one/utils/utils.dart';
import 'package:provider/provider.dart';

class CreateRedisKeyValueDialog extends StatefulWidget {
  const CreateRedisKeyValueDialog({Key? key, required this.ctx})
      : super(key: key);
  final BuildContext ctx;

  @override
  State<CreateRedisKeyValueDialog> createState() =>
      _CreateRedisKeyValueDialogState();
}

class _CreateRedisKeyValueDialogState extends State<CreateRedisKeyValueDialog> {
  final TextEditingController keyController = TextEditingController();
  final TextEditingController valController = TextEditingController();
  final TextEditingController multiValController = TextEditingController();
  final TextEditingController ttlController = TextEditingController();
  String? selectedType = "string";
  static const double buttonWidth = 275;
  static const double buttonHeight = 36;

  double height = 330;

  @override
  void initState() {
    super.initState();
    ttlController.text = "-1";
  }

  @override
  void dispose() {
    keyController.dispose();
    valController.dispose();
    multiValController.dispose();
    ttlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      width: 450,
      height: height,
      child: Column(
        children: [
          _buildTitle(),
          _wrapper(_name("key"), _textFieldWrapper("输入key值", keyController),
              alignment: CrossAxisAlignment.center),
          _wrapper(
              _name("选择类型"),
              SimpleDropdownButton(
                buttonPadding: const EdgeInsets.only(left: 15, right: 5),
                buttonWidth: buttonWidth,
                style: const TextStyle(
                    color: Color.fromARGB(255, 159, 159, 159), fontSize: 14),
                hintStyle: const TextStyle(
                    color: Color.fromARGB(255, 159, 159, 159), fontSize: 14),
                icon: const Icon(Icons.arrow_drop_down,
                    color: Color.fromARGB(255, 232, 232, 232)),
                buttonHeight: buttonHeight,
                buttonDecoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(
                        color: const Color.fromARGB(255, 232, 232, 232))),
                dropdownItems: const [
                  "string",
                  "list",
                  "set",
                  "hashes",
                  "sorted_set"
                ],
                hint: '选择数据类型',
                onChanged: (String? value) {
                  setState(() {
                    selectedType = value;
                    if (value == "string") {
                      height = 330;
                    }
                    if (value == "list" ||
                        value == "set" ||
                        value == "hashes" ||
                        value == "sorted_set") {
                      height = 400;
                    }
                  });
                },
                value: selectedType,
              ),
              alignment: CrossAxisAlignment.center),
          _wrapper(_name("value"), _valueRegion(),
              alignment: CrossAxisAlignment.start),
          _wrapper(_name("过期时间设置"), _expireTimeWidget(),
              alignment: CrossAxisAlignment.center),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                  onTap: () async {
                    if (keyController.text != "" &&
                        (valController.text != "" ||
                            multiValController.text != "")) {
                      String val;
                      if (selectedType == 'string') {
                        val = valController.text;
                      } else {
                        val = multiValController.text;
                      }

                      int r = await widget.ctx
                          .read<RedisController>()
                          .setNewKV(keyController.text, val, selectedType!);

                      if (r == 1) {
                        int r2 = await widget.ctx
                            .read<RedisController>()
                            .setExpire(
                                keyController.text,
                                int.tryParse(ttlController.text) ?? -1,
                                selectedExpireType!);
                        if (r == 1 && r2 == 1) {
                          SmartDialogUtils.message("创建成功");
                        }
                      }
                    } else {
                      SmartDialogUtils.warning("需输入key和value");
                      return;
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 1),
                    width: 73,
                    height: 21,
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(7)),
                    child: const Center(
                      child: Text(
                        "确定",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  )),
              const SizedBox(
                width: 14,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  String? selectedExpireType = "seconds";

  Widget _expireTimeWidget() {
    return Row(
      children: [
        SimpleDropdownButton(
          buttonPadding: const EdgeInsets.only(left: 15, right: 5),
          buttonWidth: buttonWidth * 0.4,
          style: const TextStyle(
              color: Color.fromARGB(255, 159, 159, 159), fontSize: 14),
          hintStyle: const TextStyle(
              color: Color.fromARGB(255, 159, 159, 159), fontSize: 14),
          icon: const Icon(Icons.arrow_drop_down,
              color: Color.fromARGB(255, 232, 232, 232)),
          buttonHeight: buttonHeight,
          buttonDecoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              border:
                  Border.all(color: const Color.fromARGB(255, 232, 232, 232))),
          dropdownItems: const [
            "seconds",
            "milliseconds",
            "timestamp",
            "milli-timestamp",
          ],
          hint: '过期时间类型',
          onChanged: (String? value) {
            setState(() {
              selectedExpireType = value;
              if (value == "timestamp") {
                ttlController.text =
                    (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
              }

              if (value == "milli-timestamp") {
                ttlController.text =
                    (DateTime.now().millisecondsSinceEpoch).toString();
              }

              if (value == "seconds" || value == "milliseconds") {
                ttlController.text = "-1";
              }
            });
          },
          value: selectedExpireType,
        ),
        const SizedBox(
          width: buttonWidth * 0.1,
        ),
        _textFieldWrapper("输入过期时间", ttlController, width: 0.5 * buttonWidth)
      ],
    );
  }

  Widget _valueRegion() {
    if (selectedType == null || selectedType == 'string') {
      return _textFieldWrapper("输入value", valController);
    } else if (selectedType == 'list' ||
        selectedType == 'set' ||
        selectedType == 'hashes' ||
        selectedType == "sorted_set") {
      return Container(
          width: buttonWidth,
          height: 100,
          padding: const EdgeInsets.only(left: 5),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 248, 248, 248),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            border: Border.all(
                color: const Color.fromARGB(255, 248, 248, 248), width: 0.5),
          ),
          child: TextField(
            maxLines: null,
            maxLength: null,
            style: const TextStyle(fontSize: 14),
            controller: multiValController,
            decoration: const InputDecoration(
              hintText: "多个数值，用英文“;”隔开",
              counterText: "",
              hintStyle: TextStyle(
                  color: Color.fromARGB(255, 151, 151, 151), fontSize: 14),
              border: InputBorder.none,
            ),
          ));
    }

    return const Text(
      "不支持的类型",
      style: TextStyle(color: Colors.red),
    );
  }

  Widget _buildTitle() {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            '创建新数据',
            style: TextStyle(fontSize: 15),
          ),
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.close,
                color: Colors.black12,
              ))
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
      margin: const EdgeInsets.only(right: buttonHeight, left: 6),
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

  Widget _textFieldWrapper(String hintText, TextEditingController controller,
      {int? maxlength, double width = buttonWidth}) {
    return Container(
        width: width,
        padding: const EdgeInsets.only(left: 15),
        height: buttonHeight,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 248, 248, 248),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: Border.all(
              color: const Color.fromARGB(255, 248, 248, 248), width: 0.5),
        ),
        child: TextField(
          maxLength: maxlength,
          style: const TextStyle(fontSize: 14),
          controller: controller,
          decoration: InputDecoration(
            counterText: "",
            contentPadding: const EdgeInsets.only(bottom: 16.0),
            hintText: hintText,
            hintStyle: const TextStyle(
                color: Color.fromARGB(255, 151, 151, 151), fontSize: 14),
            border: InputBorder.none,
          ),
        ));
  }
}
