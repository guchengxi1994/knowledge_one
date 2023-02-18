// ignore_for_file: avoid_init_to_null, depend_on_referenced_packages, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_useful_widgets/flutter_useful_widgets.dart';
import 'package:knowledge_one/common/app_style.dart';
import 'package:knowledge_one/main/providers/page_controller.dart';
import 'package:knowledge_one/redis_client/redis_controller.dart';
import 'package:collection/collection.dart';
import 'package:provider/provider.dart';

import '../model.dart';
import 'simple_tag.dart';

const double keyColumnWidth = 100;
const double valueColumnWidth = 300;
const double indexColumnWidth = 50;
const double typeColumnWidth = 75;
const double ttlColumnWidth = 50;

typedef OnPageChanged = Future Function(int index);

class RedisDataTable extends StatefulWidget {
  const RedisDataTable(
      {super.key, required this.data, required this.onPageChanged});
  final List<RedisData> data;
  final OnPageChanged onPageChanged;

  @override
  State<RedisDataTable> createState() => _RedisDataTableState();
}

class _RedisDataTableState extends State<RedisDataTable> {
  final ScrollController controller = ScrollController();
  final ScrollController controller2 = ScrollController();

  late List<double> columnWidth = [];

  late List<String> titles = ["编号", "类型", "key", "TTL"];

  static const _width =
      indexColumnWidth + keyColumnWidth + typeColumnWidth + ttlColumnWidth;

  late double total;

  @override
  Widget build(BuildContext context) {
    // debugPrint(notifier.value.length.toString());

    if (context.select<PageChangeController, bool>((v) => v.collapse)) {
      total = (MediaQuery.of(context).size.width -
          50 -
          AppStyle.sideMenuWidthCollapse);
    } else {
      total = MediaQuery.of(context).size.width - 50 - AppStyle.sideMenuWidth;
    }

    double extra = total * 0.5;

    if (extra < _width) {
      extra = _width;
      columnWidth = [
        indexColumnWidth / _width * total,
        typeColumnWidth / _width * total,
        keyColumnWidth / _width * total,
        ttlColumnWidth / _width * total,
      ];
    } else {
      columnWidth = [
        indexColumnWidth / _width * extra,
        typeColumnWidth / _width * extra,
        keyColumnWidth / _width * extra,
        ttlColumnWidth / _width * extra,
      ];
    }

    return Column(
      children: [
        Expanded(
            child: (widget.data.isEmpty)
                ? const Center(
                    child: Text("暂无内容"),
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Scrollbar(
                        controller: controller2,
                        thumbVisibility: true,
                        child: SingleChildScrollView(
                            controller: controller2,
                            scrollDirection: Axis.horizontal,
                            child: SingleChildScrollView(
                              controller: controller,
                              child: _buildTable(context),
                            )),
                      ),
                      Expanded(
                          child: Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[200]!)),
                        child: valueWidget ?? defaultWidget(),
                      ))
                    ],
                  )),
        Center(
          child: UsefulDatatableIndicator2(
            whenIndexChanged: (int index) async {
              await widget.onPageChanged(index);
            },
          ),
        ),
      ],
    );
  }

  Widget defaultWidget() {
    return const Center(
      child: Text("点击key值，展示详细信息"),
    );
  }

  Widget? valueWidget = null;

  Widget _buildTable(BuildContext context) {
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
        ...widget.data
            .map((e) => MouseRegion(
                  onEnter: (event) {
                    context
                        .read<RedisController>()
                        .changeCurrentHoveredRowId(e.index);
                  },
                  onExit: (event) {
                    context
                        .read<RedisController>()
                        .changeCurrentHoveredRowId(-1);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: context.select<RedisController, bool>(
                                (v) => v.currentHoveredRowId == e.index)
                            ? const Color.fromARGB(255, 248, 249, 250)
                            : Colors.white,
                        border: const Border(
                            top: BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 236, 239, 242)))),
                    height: 50,
                    child: Row(
                        children: toWidgetList(e)
                            .mapIndexed((i, e1) => SizedBox(
                                  width: columnWidth[i],
                                  child: e1,
                                ))
                            .toList()),
                  ),
                ))
            .toList(),
      ],

      // Expanded(child: Container())
    );
  }

  List<Widget> toWidgetList(RedisData data) {
    int t;
    if (data.model.ttl == null) {
      t = 0;
    } else {
      t = int.tryParse(data.model.ttl) ?? 0;
    }

    return [
      SizedBox(
        width: indexColumnWidth,
        child: Text(data.index.toString()),
      ),
      SizedBox(
        width: typeColumnWidth,
        child: SimpleTag(
          value: data.model.valueType,
        ),
      ),
      SizedBox(
        width: keyColumnWidth,
        child: InkWell(
            onTap: () async {
              // debugPrint(data.model.key);
              dynamic val =
                  await context.read<RedisController>().getValueFromKey(data);

              setState(() {
                valueWidget = const Center(
                  child: CircularProgressIndicator(),
                );
              });
              await Future.delayed(const Duration(milliseconds: 10))
                  .then((value) => {
                        if (val is String)
                          {
                            valueWidget = Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [Text(val)],
                            )
                          }
                        else
                          {
                            valueWidget = context
                                .read<RedisController>()
                                .buildTableFromVal(val)
                          }
                      });
              setState(() {});
            },
            child: Text(data.model.key.toString())),
      ),
      SizedBox(
          width: ttlColumnWidth,
          child: InkWell(
              onTap: () async {},
              child: data.model.ttl == "-1"
                  ? const Text(
                      "unlimit",
                      style: TextStyle(color: Colors.lightGreen),
                    )
                  : Text(data.model.ttl.toString()))),
    ];
  }
}
