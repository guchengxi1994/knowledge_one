// ignore_for_file: depend_on_referenced_packages, avoid_init_to_null

import 'package:flutter/material.dart';
import 'package:knowledge_one/redis_client/redis_controller.dart';
import 'package:knowledge_one/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

import '../common/base_sub_screens.dart';
import 'components/create_k_v_dialog.dart';
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
  final TextEditingController fuzzController = TextEditingController();

  bool enableTls = false;

  String bottomText = "";
  bool hasQueried = false;

  @override
  void dispose() {
    urlController.dispose();
    portController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    fuzzController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    urlController.text = "localhost";
    portController.text = "6379";
  }

  Widget _buildContent() {
    if (!hasQueried) {
      return const SizedBox();
    }

    return RedisDataTable(
      onPageChanged: (index) async {
        fuzzController.text = "";

        if (context.read<RedisController>().couldQuery) {
          final d1 = DateTime.now();

          await context.read<RedisController>().getRangeKeys();
          final d2 = DateTime.now();
          final duration = d2.difference(d1).inSeconds;
          setState(() {
            bottomText =
                "在$duration秒中获取了${context.read<RedisController>().listCount}条记录";
          });
        } else {
          if (index == 1) {
            context.read<RedisController>().refresh();
            await context.read<RedisController>().getRangeKeys();
          } else {
            SmartDialogUtils.warning("已无内容");
          }
        }
      },
      data:
          context.read<RedisController>().currentQueriedKeys.mapIndexed((i, e) {
        return RedisData(
          index: i + 1,
          model: e,
          onValueGet: () async {
            await context.read<RedisController>().changeModel(i, e);
            setState(() {});
          },
        );
      }).toList(),
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
            controller: fuzzController,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 19.0),
              hintText: "模糊查询",
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

              if (fuzzController.text == "") {
                await context.read<RedisController>().getRangeKeys();
              } else {
                await context
                    .read<RedisController>()
                    .getProperKeys(fuzzController.text);
              }

              final d2 = DateTime.now();
              final duration = d2.difference(d1).inSeconds;
              setState(() {
                hasQueried = true;
                bottomText =
                    "在$duration秒中获取了${context.read<RedisController>().listCount}条记录";
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
        InkWell(
            onTap: () async {
              await showGeneralDialog(
                  context: context,
                  pageBuilder: (ctx, animition, builder) {
                    return Center(
                      child: CreateRedisKeyValueDialog(
                        ctx: context,
                      ),
                    );
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
                  "创建新数据",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            )),
      ],
    );
  }
}
