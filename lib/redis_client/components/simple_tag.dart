import 'package:flutter/material.dart';
import 'package:knowledge_one/common/app_style.dart';

class SimpleTag extends StatelessWidget {
  const SimpleTag({Key? key, required this.value}) : super(key: key);
  final String? value;

  @override
  Widget build(BuildContext context) {
    return value == null
        ? const Text("***")
        : Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: value!.length * 13.5,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppStyle.redisTypeColorMap[value.toString()] ??
                      AppStyle.redisTypeColorMap["default"]),
              padding: const EdgeInsets.all(5),
              child: Center(
                child: Text(
                  value.toString().toUpperCase(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
  }
}
