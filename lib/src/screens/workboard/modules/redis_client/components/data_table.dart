// ignore_for_file: avoid_init_to_null

import 'package:flutter/material.dart';
import 'package:flutter_useful_widgets/flutter_useful_widgets.dart'
    show BaseData;

const double keyColumnWidth = 100;
const double valueColumnWidth = 300;
const double indexColumnWidth = 50;

class RedisModel {
  final dynamic key;
  dynamic value = null;
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
                onTap: () {
                  onValueGet();
                },
                child: const Text("***"),
              )
            : Text(model.value.toString()),
      )
    ];
  }
}
