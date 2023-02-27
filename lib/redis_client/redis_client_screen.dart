// ignore_for_file: depend_on_referenced_packages, avoid_init_to_null

import 'package:debug_repl/components/repl_window.dart';
import 'package:flutter/material.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:knowledge_one/redis_client/redis_controller.dart';
import 'package:knowledge_one/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

import '../common/base_sub_screens.dart';
import 'components/create_k_v_dialog.dart';
import 'components/data_table.dart';
import 'components/tls_switch.dart';
import 'model.dart';

class RedisClientScreen extends BaseSubScreen {
  RedisClientScreen({Key? key})
      : super(
            key: key,
            title: "Redis Client",
            endDrawer: Builder(
                builder: (context) => Container(
                      width: 200,
                      height: 1000,
                      color: Colors.blue,
                      child: Text(
                          context.watch<RedisController>().value.toString()),
                    )));

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
            if (hasQueried)
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: Wrap(
                  children: [
                    StreamBuilder(
                        stream: connectionDetails,
                        builder: (c, s) {
                          // return Text((s.data?.connectedClients ?? "").toString());
                          // return Text.rich(TextSpan(children: [
                          //   const TextSpan(text: "当前客户端连接数量"),
                          //   TextSpan(
                          //       text:
                          //           (s.data?.connectedClients ?? "").toString(),
                          //       style:
                          //           const TextStyle(color: Colors.blueAccent)),
                          // ]));
                          return SizedBox(
                            width: 50,
                            child: Row(
                              children: [
                                Tooltip(
                                  message: "当前连接数量",
                                  child: Image.asset(
                                    "assets/icons/client.png",
                                    width: 25,
                                    height: 25,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                    (s.data?.connectedClients ?? "").toString(),
                                    style: const TextStyle(
                                        color: Colors.blueAccent)),
                              ],
                            ),
                          );
                        }),
                    const SizedBox(
                      width: 20,
                    ),
                    StreamBuilder(
                        stream: memoryDetails,
                        builder: (c, s) {
                          return SizedBox(
                            width: 200,
                            child: Row(
                              children: [
                                Tooltip(
                                  message: "当前存储",
                                  child: Image.asset(
                                    "assets/icons/s1.png",
                                    width: 25,
                                    height: 25,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text((s.data?.usedMemory ?? "").toString(),
                                    style: const TextStyle(
                                        color: Colors.blueAccent)),
                                const SizedBox(
                                  width: 20,
                                ),
                                Tooltip(
                                  message: "最高占用存储",
                                  child: Image.asset(
                                    "assets/icons/s2.png",
                                    width: 25,
                                    height: 25,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text((s.data?.peakUsedMemory ?? "").toString(),
                                    style: const TextStyle(
                                        color: Colors.blueAccent)),
                              ],
                            ),
                          );
                        }),
                    const SizedBox(
                      width: 20,
                    ),
                    StreamBuilder(
                        stream: memoryUsed,
                        builder: (c, s) {
                          if (s.data == "") {
                            return const Text("");
                          }
                          // return Text("当前redis内存占用：${s.data}");
                          return SizedBox(
                            width: 75,
                            child: Row(
                              children: [
                                Tooltip(
                                  message: "内存占用",
                                  child: Image.asset(
                                    "assets/icons/ram.png",
                                    width: 25,
                                    height: 25,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text((s.data).toString(),
                                    style: const TextStyle(
                                        color: Colors.blueAccent)),
                              ],
                            ),
                          );
                        }),
                    const SizedBox(
                      width: 20,
                    ),
                    StreamBuilder(
                        stream: cpuUsed,
                        builder: (c, s) {
                          if (s.data == "") {
                            return const Text("");
                          }
                          // return Text("当前redis CPU使用率：${s.data}");
                          return SizedBox(
                            width: 75,
                            child: Row(
                              children: [
                                Tooltip(
                                  message: "CPU占用",
                                  child: Image.asset(
                                    "assets/icons/cpu.png",
                                    width: 25,
                                    height: 25,
                                  ),
                                ),
                                Text((s.data).toString(),
                                    style: const TextStyle(
                                        color: Colors.blueAccent)),
                              ],
                            ),
                          );
                        }),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text("刷新间隔5秒", style: TextStyle(color: Colors.green)),
                  ],
                ),
              ),
            Expanded(child: _buildContent()),
            _buildBottom(),
            if (bottomText != "") _buildClent()
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

  late final Stream<RedisConnectionDetails> connectionDetails =
      context.read<RedisController>().getClientCount();

  late final Stream<RedisMemoryDetails> memoryDetails =
      context.read<RedisController>().getMemoryDetails();

  late final Stream<String> memoryUsed =
      context.read<RedisController>().getMemoryUsed();

  late final Stream<String> cpuUsed =
      context.read<RedisController>().getCpuUsed();

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

  Widget _buildClent() {
    return JustTheTooltip(
        tailBuilder: (point1, point2, point3) {
          return Path()
            ..moveTo(point1.dx, point1.dy)
            ..lineTo(point3.dx, point3.dy)
            ..close();
        },
        isModal: true,
        content: const ReplWindow(
          prevCommands: ["redis-cli"],
        ),
        child: const Align(
          alignment: Alignment.centerRight,
          child: Text("cli"),
        ));
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
