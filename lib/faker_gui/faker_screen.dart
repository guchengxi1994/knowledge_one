// ignore_for_file: avoid_init_to_null, no_leading_underscores_for_local_identifiers, depend_on_referenced_packages

import 'dart:convert';

import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_useful_widgets/flutter_useful_widgets.dart';
import 'package:knowledge_one/rpc/faker.pbgrpc.dart';
import 'package:knowledge_one/main/providers/app_controller.dart';
import 'package:knowledge_one/utils/utils.dart';
import 'package:provider/provider.dart';

import '../common/base_sub_screens.dart';
import 'data_grid.dart';
import 'faker_tags.dart';

class FakerScreen extends BaseSubScreen {
  const FakerScreen({Key? key}) : super(key: key, title: "Faker Screen");

  @override
  State<FakerScreen> createState() => _FakerScreenState();

  @override
  BaseSubScreenState<BaseSubScreen> getState() {
    return _FakerScreenState();
  }
}

class _FakerScreenState extends BaseSubScreenState<FakerScreen> {
  final GlobalKey<FakerTagsState> tagKey = GlobalKey();
  final channel = ClientChannel(
    'localhost',
    port: 15556,
    options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
  );

  late final stub = FakerClient(channel);

  @override
  Widget baseBuild(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("选择参数"),
            const SizedBox(
              height: 15,
            ),
            _buildConditions(),
            const SizedBox(
              height: 15,
            ),
            const Text("创建Faker条件"),
            const SizedBox(
              height: 15,
            ),
            FakerTags(
              key: tagKey,
              locale: selectedLang,
              supportedLocales:
                  context.select<AppConfigController, List<String>>(
                      (value) => value.config?.fakerSupportedLocales ?? []),
            ),
            const Expanded(child: SizedBox()),
            Row(
              children: [
                const Expanded(child: SizedBox()),
                InkWell(
                    onTap: () async {
                      if (selectedLang == null || selectedTimes == null) {
                        SmartDialogUtils.warning("请选择次数及语言");
                        return;
                      }

                      final tagItems = tagKey.currentState!.tagItems;
                      if (tagItems.length == 1) {
                        SmartDialogUtils.warning("未创建condition");
                        return;
                      }

                      String s = (selectedTimes ?? "").replaceAll("次", "");

                      var count = int.tryParse(s) ?? 1;
                      List<ProviderMap> items = [];
                      for (final i in tagItems) {
                        if (i.customData != null) {
                          items.add(ProviderMap(
                              key: (i.customData as NewFakerItem).key,
                              value: (i.customData as NewFakerItem)
                                  .fakerType!
                                  .toStr()));
                        }
                      }

                      try {
                        var response = await stub
                            .batchFake(BatchFakeRequest(providerMaps: items)
                              ..count = Int64.parseInt(count.toString())
                              ..locale = selectedLang!);
                        // debugPrint(response.result.toString());
                        List<dynamic> d = jsonDecode(response.result)['data'];

                        List<Map<String, dynamic>> _d = d
                            .map(
                              (e) => e as Map<String, dynamic>,
                            )
                            .toList();

                        showGeneralDialog(
                            context: context,
                            pageBuilder:
                                ((context, animation, secondaryAnimation) {
                              return Center(
                                child: DataGrid(data: _d),
                              );
                            }));
                      } catch (e, s) {
                        debugPrint(e.toString());
                        debugPrint(s.toString());
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 1),
                      width: 83,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(7)),
                      child: const Center(
                        child: Text(
                          "生成",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }

  String? selectedTimes = null;
  String? selectedLang = null;

  Widget _buildConditions() {
    return Wrap(
      runSpacing: 15,
      spacing: 15,
      children: [
        SimpleDropdownButton(
          style: const TextStyle(
              color: Color.fromARGB(255, 159, 159, 159), fontSize: 10),
          hintStyle: const TextStyle(
              color: Color.fromARGB(255, 159, 159, 159), fontSize: 12),
          icon: const Icon(Icons.arrow_drop_down,
              color: Color.fromARGB(255, 232, 232, 232)),
          buttonHeight: 30,
          buttonDecoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(19)),
              border:
                  Border.all(color: const Color.fromARGB(255, 232, 232, 232))),
          dropdownItems: const ["1次", "5次", "10次", "20次", "100次"],
          hint: '选择次数',
          onChanged: (String? value) {
            setState(() {
              selectedTimes = value;
            });
          },
          value: selectedTimes,
        ),
        SimpleDropdownButton(
            style: const TextStyle(
                color: Color.fromARGB(255, 159, 159, 159), fontSize: 10),
            hintStyle: const TextStyle(
                color: Color.fromARGB(255, 159, 159, 159), fontSize: 12),
            icon: const Icon(Icons.arrow_drop_down,
                color: Color.fromARGB(255, 232, 232, 232)),
            buttonHeight: 30,
            buttonDecoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(19)),
                border: Border.all(
                    color: const Color.fromARGB(255, 232, 232, 232))),
            hint: "选择语言",
            value: selectedLang,
            dropdownItems: context.select<AppConfigController, List<String>>(
                (value) => value.config?.fakerSupportedLocales ?? []),
            onChanged: (value) {
              setState(() {
                selectedLang = value;
              });
            })
      ],
    );
  }
}
