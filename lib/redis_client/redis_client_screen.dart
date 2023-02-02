// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_useful_widgets/datatable/simple_datatable2.dart';
import 'package:flutter_useful_widgets/flutter_useful_widgets.dart';
import 'package:knowledge_one/redis_client/redis_controller.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

import '../common/base_sub_screens.dart';
import 'components/data_table.dart';
import 'components/tls_switch.dart';

class RedisClientScreen extends BaseSubScreen {
  const RedisClientScreen({Key? key}) : super(key: key, title: "Redis Client");

  @override
  State<RedisClientScreen> createState() => _RedisClientScreenState();

  @override
  BaseSubScreenState<BaseSubScreen> getState() {
    return _RedisClientScreenState();
  }
}

class _RedisClientScreenState extends BaseSubScreenState<RedisClientScreen> {
  @override
  Widget baseBuild(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(),
            Expanded(child: _buildContent()),
            _buildBottom(),
          ],
        ),
      ),
    );
  }

  final TextEditingController urlController = TextEditingController();
  final TextEditingController portController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late SimpleDataProvider dataProvider;

  bool enableTls = false;
  List<dynamic> results = [];

  String bottomText = "";

  int currentOffset = 0;

  @override
  void dispose() {
    urlController.dispose();
    portController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    urlController.text = "localhost";
    portController.text = "6379";
  }

  dynamic _getVal(String s) async {
    return await context.read<RedisController>().getVal(s);
  }

  dynamic _getType(String s) async {
    return await context.read<RedisController>().getValType(s);
  }

  Widget _buildContent() {
    if (results.isEmpty) {
      return const SizedBox();
    }
    dataProvider = SimpleDataProvider(initial: () async {
      return results.mapIndexed((i, e) {
        var key = e.first.toString();
        RedisModel model = RedisModel(key: key);
        return RedisData(
          index: i,
          model: model,
          onValueGet: () async {
            model.value = await _getVal(key);
            model.valueType = await _getType(key);
            setState(() {});
          },
        );
      }).toList();
    }, onLoadMore: () async {
      return [];
    }, onFilter: (conditions) async {
      return [];
    }, onPageChanged: (index) async {
      final d1 = DateTime.now();
      List keys;
      if (index == 1) {
        setState(() {
          currentOffset = 0;
        });
        keys = await context.read<RedisController>().getRangeKeys(0);
        keys.removeAt(0);
      } else if (currentOffset == 0) {
        keys = [];
      } else {
        keys =
            await context.read<RedisController>().getRangeKeys(currentOffset);
        setState(() {
          currentOffset = int.tryParse(keys.removeAt(0)) ?? 0;
        });
      }

      final d2 = DateTime.now();
      final duration = d2.difference(d1).inSeconds;

      setState(() {
        bottomText = "在$duration秒中获取了${keys.length}条记录";
      });

      return keys.mapIndexed((i, e) {
        var key = e.first.toString();
        RedisModel model = RedisModel(key: key);
        return RedisData(
          index: i,
          model: model,
          onValueGet: () async {
            model.value = await _getVal(key);
            model.valueType = await _getType(key);
            setState(() {});
          },
        );
      }).toList();
    }, onReset: () async {
      return [];
    });

    return UsefulSimpleDatatable2(
      columns: const ["编号", "key", "value", "值类型"],
      columnWidth: const [
        indexColumnWidth,
        keyColumnWidth,
        valueColumnWidth,
        typeColumnWidth
      ],
      dataProvider: dataProvider,
    );
  }

  Widget _buildBottom() {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(bottomText),
    );
  }

  Widget _buildTitle() {
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      children: [
        Container(
          width: 200,
          padding: const EdgeInsets.only(left: 5),
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
            controller: urlController,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 19.0),
              hintText: "输入url",
              hintStyle: TextStyle(
                  color: Color.fromARGB(255, 159, 159, 159), fontSize: 12),
              border: InputBorder.none,
            ),
          ),
        ),
        Container(
          width: 80,
          padding: const EdgeInsets.only(left: 5),
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
            controller: portController,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 19.0),
              hintText: "输入端口号",
              hintStyle: TextStyle(
                  color: Color.fromARGB(255, 159, 159, 159), fontSize: 12),
              border: InputBorder.none,
            ),
          ),
        ),
        TlsSwitch(
          onTlsChanged: (v) {
            setState(() {
              enableTls = v;
            });
          },
        ),
        Visibility(
            visible: enableTls,
            child: Container(
              width: 80,
              padding: const EdgeInsets.only(left: 5),
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
                controller: usernameController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 19.0),
                  hintText: "输入用户名",
                  hintStyle: TextStyle(
                      color: Color.fromARGB(255, 159, 159, 159), fontSize: 12),
                  border: InputBorder.none,
                ),
              ),
            )),
        Visibility(
            visible: enableTls,
            child: Container(
              width: 80,
              padding: const EdgeInsets.only(left: 5),
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
                controller: passwordController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 19.0),
                  hintText: "输入密码",
                  hintStyle: TextStyle(
                      color: Color.fromARGB(255, 159, 159, 159), fontSize: 12),
                  border: InputBorder.none,
                ),
              ),
            )),
        InkWell(
            onTap: () async {
              context.read<RedisController>().updateRedisInfo(
                  urlController.text, int.tryParse(portController.text) ?? 0);
              await context.read<RedisController>().testConnection();
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
                  "测试连接",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            )),
        InkWell(
            onTap: () async {
              final d1 = DateTime.now();
              // results = await context.read<RedisController>().getAllKeys();
              results = await context
                  .read<RedisController>()
                  .getRangeKeys(currentOffset);

              int offset = int.tryParse(results.removeAt(0)) ?? 0;
              currentOffset = offset;

              final d2 = DateTime.now();
              final duration = d2.difference(d1).inSeconds;
              setState(() {
                bottomText = "在$duration秒中获取了${results.length}条记录";
              });
            },
            child: Container(
              padding: const EdgeInsets.only(bottom: 1),
              width: 80,
              height: 30,
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(7)),
              child: const Center(
                child: Text(
                  "获取所有key",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            )),
      ],
    );
  }
}
