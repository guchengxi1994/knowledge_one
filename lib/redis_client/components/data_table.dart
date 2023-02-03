// ignore_for_file: avoid_init_to_null

import 'package:flutter/material.dart';
import 'package:flutter_useful_widgets/flutter_useful_widgets.dart'
    show BaseData;
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:knowledge_one/utils/extensions/date_time_extension.dart';

const double keyColumnWidth = 100;
const double valueColumnWidth = 300;
const double indexColumnWidth = 50;
const double typeColumnWidth = 75;
const double ttlColumnWidth = 125;

class RedisModel {
  final dynamic key;
  dynamic value = null;
  dynamic valueType = null;
  dynamic ttl = null;
  RedisModel({required this.key});
}

class RedisData extends BaseData {
  final int index;
  RedisModel model;
  RedisData(
      {required this.index,
      required this.model,
      this.onKeyModified,
      required this.onValueGet,
      this.onValueModified});
  final VoidCallback? onKeyModified;
  final VoidCallback? onValueModified;
  final VoidCallback onValueGet;

  @override
  List<Widget> toWidgetList() {
    int t;
    if (model.ttl == null) {
      t = 0;
    } else {
      t = int.tryParse(model.ttl) ?? 0;
    }

    return [
      SizedBox(
        width: indexColumnWidth,
        child: Text(index.toString()),
      ),
      SizedBox(
        width: keyColumnWidth,
        child: Text(model.key.toString()),
      ),
      SizedBox(
        width: valueColumnWidth,
        child: model.value == null
            ? InkWell(
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  onValueGet();
                },
                child: const Text(
                  "***",
                  style: TextStyle(color: Colors.blueAccent),
                ),
              )
            : Text(model.value.toString()),
      ),
      SizedBox(
        width: typeColumnWidth,
        child: model.value == null
            ? const Text("***")
            : Text(model.valueType.toString()),
      ),
      SizedBox(
        width: ttlColumnWidth,
        child: model.ttl == null
            ? const Text("***")
            : Row(
                children: [
                  Text(model.ttl.toString()),
                  const Expanded(child: SizedBox()),
                  JustTheTooltip(
                      content: Padding(
                        padding: const EdgeInsets.all(10),
                        child: model.ttl == 0
                            ? const Text("无效的时间")
                            : t == -1
                                ? const Text("永久有效")
                                : Text(DateTime.fromMillisecondsSinceEpoch(
                                        t * 1000)
                                    .toChinese()),
                      ),
                      child: const Icon(
                        Icons.info,
                        color: Colors.blueAccent,
                      ))
                ],
              ),
      ),
    ];
  }
}
