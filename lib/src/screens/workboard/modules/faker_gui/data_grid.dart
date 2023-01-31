import 'dart:io';

import 'package:csvwriter/csvwriter.dart';
import 'package:flutter/material.dart';
import 'package:knowledge_one/utils/utils.dart';
import 'package:open_file/open_file.dart';
import 'package:pluto_grid/pluto_grid.dart';

class DataGrid extends StatefulWidget {
  const DataGrid({Key? key, required this.data}) : super(key: key);
  final List<Map<String, dynamic>> data;

  @override
  State<DataGrid> createState() => _DataGridState();
}

class _DataGridState extends State<DataGrid> {
  late List<Map<String, dynamic>> data = widget.data;
  List<PlutoColumn> columns = [];
  List<PlutoRow> rows = [];

  @override
  void initState() {
    super.initState();
    columns = data.first.keys
        .map((e) =>
            PlutoColumn(title: e, field: e, type: PlutoColumnType.text()))
        .toList();
    rows = data.map((e) => PlutoRow(cells: _getRow(e))).toList();
  }

  Map<String, PlutoCell> _getRow(Map<String, dynamic> d) {
    Map<String, PlutoCell> result = {};
    for (final i in d.entries) {
      result[i.key] = PlutoCell(value: i.value);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 400,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.blueAccent),
          borderRadius: BorderRadius.circular(7)),
      child: Column(
        children: [
          Expanded(
              child: PlutoGrid(
            columns: columns,
            rows: rows,
          )),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
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
                        "取消",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  )),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                  onTap: () async {
                    final p = DevUtils.executableDir.path;
                    final name = "${DateTime.now().millisecondsSinceEpoch}.csv";
                    File f = File("$p/_private/$name");
                    var csv =
                        CsvWriter.withHeaders(f.openWrite(), data.first.keys);

                    try {
                      for (final i in data) {
                        csv.writeData(data: i);
                      }
                    } catch (e) {
                      debugPrint(e.toString());
                      SmartDialogUtils.error("生成csv失败");
                      return;
                    } finally {
                      await csv.close();
                      OpenFile.open("$p/_private/$name");
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 1),
                    width: 100,
                    height: 21,
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(7)),
                    child: const Center(
                      child: Text(
                        "导出到csv",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  )),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                  onTap: () async {
                    final p = DevUtils.executableDir.path;
                    final name = "${DateTime.now().millisecondsSinceEpoch}.sql";
                    File f = File("$p/_private/$name");
                    String s = toSql(data.first.keys.toList(), data);
                    await f.writeAsString(s);

                    OpenFile.open("$p/_private/$name");
                  },
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 1),
                    width: 100,
                    height: 21,
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(7)),
                    child: const Center(
                      child: Text(
                        "导出到sql",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }
}

String toSql(List<String> titles, List<Map<String, dynamic>> data) {
  final t = "(${titles.map((e) => "'$e'").toList().join(",")})";
  String values = "";
  for (final i in data) {
    values = "$values(${i.values.map((e) => "'$e'").toList().join(',')}),";
  }

  values = values.replaceRange(values.length - 1, null, "");

  String result = "INSERT INTO table $t values $values;";

  return result;
}
