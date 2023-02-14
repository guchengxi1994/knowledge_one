// ignore_for_file: avoid_init_to_null, depend_on_referenced_packages, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_useful_widgets/flutter_useful_widgets.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:knowledge_one/common/app_style.dart';
import 'package:knowledge_one/main/providers/page_controller.dart';
import 'package:knowledge_one/utils/extensions/date_time_extension.dart';
import 'package:collection/collection.dart';
import 'package:provider/provider.dart';

import 'simple_tag.dart';

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

  @override
  String toString() {
    return "key: $key type:$valueType val:$value";
  }
}

class RedisData {
  final int index;
  RedisModel model;
  RedisData({
    required this.index,
    required this.model,
    this.onKeyModified,
    required this.onValueGet,
    this.onValueModified,
  });
  final VoidCallback? onKeyModified;
  final VoidCallback? onValueModified;
  final VoidCallback onValueGet;

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
        child: SimpleTag(
          value: model.valueType,
        ),
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

typedef OnPageChanged = Future Function(int index);

class RedisDataTable extends StatelessWidget {
  RedisDataTable({Key? key, required this.data, required this.onPageChanged})
      : super(key: key);
  final List<RedisData> data;

  final ScrollController controller = ScrollController();
  final ScrollController controller2 = ScrollController();
  final OnPageChanged onPageChanged;

  late List<double> columnWidth = [];

  late List<String> titles = ["编号", "key", "value", "值类型", "TTL"];

  static const _width = indexColumnWidth +
      keyColumnWidth +
      valueColumnWidth +
      typeColumnWidth +
      ttlColumnWidth;

  @override
  Widget build(BuildContext context) {
    // debugPrint(notifier.value.length.toString());
    double extra;
    if (context.select<PageChangeController, bool>((v) => v.collapse)) {
      extra = MediaQuery.of(context).size.width -
          50 -
          AppStyle.sideMenuWidthCollapse;
    } else {
      extra = MediaQuery.of(context).size.width - 50 - AppStyle.sideMenuWidth;
    }

    if (extra < _width) {
      extra = _width;
    }

    columnWidth = [
      indexColumnWidth / _width * extra,
      keyColumnWidth / _width * extra,
      valueColumnWidth / _width * extra,
      typeColumnWidth / _width * extra,
      ttlColumnWidth / _width * extra,
    ];

    return Column(
      children: [
        Expanded(
            child: (data.isEmpty)
                ? const Center(
                    child: Text("暂无内容"),
                  )
                : Scrollbar(
                    controller: controller2,
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                        controller: controller2,
                        scrollDirection: Axis.horizontal,
                        child: SingleChildScrollView(
                          controller: controller,
                          // child: DataTable(
                          //   horizontalMargin: 0,
                          //   dividerThickness: 1,
                          //   columnSpacing: 0,
                          //   rows: data
                          //       .map((e) => DataRow(
                          //           cells: e
                          //               .toWidgetList()
                          //               .mapIndexed(
                          //                   (i, e1) => DataCell(SizedBox(
                          //                         width: columnWidth[i],
                          //                         child: e1,
                          //                       )))
                          //               .toList()))
                          //       .toList(),
                          //   columns: titles
                          //       .mapIndexed((i, e) => DataColumn(
                          //               label: SizedBox(
                          //             width: columnWidth[i],
                          //             child: Text(e),
                          //           )))
                          //       .toList(),
                          // ),
                          child: _buildTable(),
                        )),
                  )),
        Center(
          child: UsefulDatatableIndicator2(
            whenIndexChanged: (int index) async {
              await onPageChanged(index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTable() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: titles
                .mapIndexed((i, e) => SizedBox(
                      width: columnWidth[i],
                      child: Text(e),
                    ))
                .toList(),
          ),
        ),
        ...data
            .map((e) => Row(
                children: e
                    .toWidgetList()
                    .mapIndexed((i, e1) => SizedBox(
                          width: columnWidth[i],
                          child: e1,
                        ))
                    .toList()))
            .toList(),
      ],
    );
  }
}
