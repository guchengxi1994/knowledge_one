// ignore_for_file: avoid_init_to_null

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_useful_widgets/flutter_useful_widgets.dart';
import 'package:grpc/grpc.dart';
import 'package:knowledge_one/src/rpc/quicktype.pbgrpc.dart';
import 'package:knowledge_one/src/screens/workboard/base_sub_screens.dart';
import 'package:knowledge_one/src/screens/workboard/modules/code_generator/code_preview.dart';
import 'package:knowledge_one/src/screens/workboard/modules/main/providers/app_controller.dart';
import 'package:knowledge_one/utils/utils.dart';
import 'package:provider/provider.dart';

import 'json_preview_screen.dart';

/// THIS PART IS JUST A TEST JSON
/// WILL BE REMOVED
/*
{
    "tag": {
        "file": {
            "name": "test_video",
            "type": "mp3",
            "size": 240,
            "created_time": 1662466801,
            "optional": "test_tree_v2"
        },
        "slice": [
            {
                "hash": "iuwefkakouqwfugsefuhgkgskg",
                "size": 140
            },
            {
                "hash": "oiuyerfhbkwgbfgkjkbfsekjuhsef",
                "size": 100
            }
        ]
    }
}
*/

class CodeGenerateScreen extends BaseSubScreen {
  const CodeGenerateScreen({Key? key})
      : super(key: key, title: "Class/Struct Generator Screen");

  @override
  State<CodeGenerateScreen> createState() => _CodeGenerateScreenState();

  @override
  BaseSubScreenState<BaseSubScreen> getState() {
    return _CodeGenerateScreenState();
  }
}

class _CodeGenerateScreenState extends BaseSubScreenState<CodeGenerateScreen> {
  final TextEditingController controller = TextEditingController();
  final TextEditingController controller2 = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return Row(
      children: [
        _wrapper(_left()),
        const VerticalDivider(),
        _wrapper(_right())
      ],
    );
  }

  Widget _wrapper(Widget child) {
    return Expanded(
        flex: 1,
        child: Container(
          padding: const EdgeInsets.all(15),
          child: child,
        ));
  }

  Widget _left() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text("请在此处填入json"),
            const Expanded(child: SizedBox()),
            IconButton(
                tooltip: "预览json结构",
                onPressed: () async {
                  try {
                    final data = jsonDecode(controller.text);
                    await showGeneralDialog(
                        context: context,
                        pageBuilder: ((context, animation, secondaryAnimation) {
                          return Center(
                            child: JsonPreviewScreen(
                              data: data,
                            ),
                          );
                        }));
                  } catch (_) {
                    SmartDialogUtils.error("Json异常");
                  }
                },
                icon: const Icon(Icons.remove_red_eye))
          ],
        ),
        Expanded(
            child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(5)),
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: TextFormField(
            controller: controller,
            maxLines: null,
            maxLength: null,
            decoration: const InputDecoration(border: InputBorder.none),
          ),
        ))
      ],
    );
  }

  String? selectedLang = null;

  String codes = "";

  final channel = ClientChannel(
    'localhost',
    port: 50051,
    options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
  );

  late final stub = GenerateClient(channel);

  Widget _right() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SimpleDropdownButton(
                buttonWidth: 140,
                style: const TextStyle(
                    color: Color.fromARGB(255, 159, 159, 159), fontSize: 10),
                hintStyle: const TextStyle(
                    color: Color.fromARGB(255, 159, 159, 159), fontSize: 12),
                icon: const Icon(Icons.arrow_drop_down,
                    color: Color.fromARGB(255, 232, 232, 232)),
                buttonHeight: 30,
                buttonDecoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(9)),
                    border: Border.all(
                        color: const Color.fromARGB(255, 232, 232, 232))),
                hint: "选择语言",
                value: selectedLang,
                dropdownItems: (context
                        .watch<AppConfigController>()
                        .config
                        ?.codeGeneratorSupportedLangs ??
                    [])
                  ..sort(),
                onChanged: (value) {
                  setState(() {
                    selectedLang = value;
                  });
                }),
            const SizedBox(
              width: 10,
            ),
            Container(
              width: 140,
              padding: const EdgeInsets.only(left: 19),
              height: 30,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(9)),
                border: Border.all(
                    color: const Color.fromARGB(255, 232, 232, 232), width: 1),
              ),
              child: TextField(
                style: const TextStyle(
                    fontSize: 12, color: Color.fromARGB(255, 159, 159, 159)),
                controller: controller2,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 19.0),
                  hintText: "输入类名",
                  hintStyle: TextStyle(
                      color: Color.fromARGB(255, 159, 159, 159), fontSize: 12),
                  border: InputBorder.none,
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
            InkWell(
                onTap: () async {
                  setState(() {
                    codes = "";
                  });
                  if (selectedLang == null) {
                    SmartDialogUtils.warning("未选择对应语言");
                    return;
                  }

                  if (controller2.text == "") {
                    SmartDialogUtils.warning("未输入类名");
                    return;
                  }

                  try {
                    final _ = jsonDecode(controller.text);
                    QuicktypeRequest request = QuicktypeRequest()
                      ..content = controller.text
                      ..langType = selectedLang!
                      ..structName = controller2.text;
                    var response = await stub.generateCode(request);
                    // debugPrint(response.result);
                    setState(() {
                      codes = response.result;
                    });
                  } catch (_) {
                    SmartDialogUtils.error("解析异常");
                  }
                },
                child: Container(
                  padding: const EdgeInsets.only(bottom: 1),
                  width: 73,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(7)),
                  child: const Center(
                    child: Text(
                      "生成",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                )),
            Visibility(
              visible: codes != "",
              child: const SizedBox(
                width: 10,
              ),
            ),
            Visibility(
                visible: codes != "",
                child: InkWell(
                    onTap: () async {
                      await Clipboard.setData(ClipboardData(text: codes));
                      SmartDialogUtils.message("已复制到剪切板");
                    },
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 1),
                      width: 73,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(7)),
                      child: const Center(
                        child: Text(
                          "复制代码",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ))),
            // const SizedBox(
            //   width: 10,
            // ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        codes == ""
            ? const SizedBox()
            : Expanded(
                child: CodePreview(codes: codes, langType: selectedLang!))
      ],
    );
  }
}
