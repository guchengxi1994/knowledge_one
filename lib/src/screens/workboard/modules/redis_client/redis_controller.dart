// ignore_for_file: avoid_init_to_null

import 'package:flutter/material.dart';
import 'package:knowledge_one/utils/utils.dart';
import 'package:redis/redis.dart';

class RedisController extends ChangeNotifier {
  late RedisConnection conn = RedisConnection();

  /// default url and port
  String url = "localhost";
  int port = 6379;

  /// Tls
  String username = "";
  String password = "";

  final List<String> getTest = const ['GET', 'test'];
  final List<String> allKeysCommand = const ['KEYS', '*'];

  void updateRedisInfo(String u, int p) {
    url = u;
    port = p;
  }

  Future<List<dynamic>> getAllKeys() async {
    List<dynamic> results = [];
    await conn.connect(url, port).then((Command command) async {
      results = await command.send_object(allKeysCommand);
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      SmartDialogUtils.error("redis 连接异常");
    });
    return results;
  }

  Future<dynamic> getVal(String s) async {
    var res = null;

    await conn.connect(url, port).then((Command command) async {
      res = await command.send_object(["GET", s]);
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      SmartDialogUtils.error("redis 连接异常");
    });

    return res;
  }

  Future testConnection() async {
    debugPrint("[redis]: url=> $url, port=> $port");
    await conn.connect(url, port).then((Command command) async {
      await command.send_object(getTest);
      SmartDialogUtils.message("连接成功");
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      SmartDialogUtils.error("redis 连接异常");
    });
  }
}
