// ignore_for_file: avoid_init_to_null

import 'package:flutter/material.dart';
import 'package:flutter_useful_widgets/flutter_useful_widgets.dart';

import '../components/faker_tags.dart';
import 'base_sub_screens.dart';

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

  @override
  Widget baseBuild(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("创建Faker条件"),
            const SizedBox(
              height: 15,
            ),
            FakerTags(
              key: tagKey,
            ),
            const SizedBox(
              height: 15,
            ),
            _buildConditions(),
          ],
        ),
      ),
    );
  }

  String? selectedTimes = null;

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
        )
      ],
    );
  }
}
