// ignore_for_file: avoid_init_to_null

import 'package:flutter/material.dart';
import 'package:knowledge_one/utils/utils.dart';
import 'package:redis/redis.dart';

import 'components/data_table.dart';

class RedisController extends ChangeNotifier {
  late RedisConnection conn = RedisConnection();
  late Command? command = null;

  /// default url and port
  String url = "localhost";
  int port = 6379;

  /// Tls
  String username = "";
  String password = "";

  final List<String> allKeysCommand = const ['KEYS', '*'];

  void updateRedisInfo(String u, int p) {
    url = u;
    port = p;
    if (command != null) {
      command = null;
    }
  }

  List<RedisModel> currentQueriedKeys = [];
  int _currentOffset = 0;

  @Deprecated("获取所有keys，性能会有问题")
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

  Future<void> getProperKeys(String condition) async {
    command ??= await conn.connect(url, port);

    List<dynamic> results = [];
    couldQuery = true;
    _currentOffset = 0;
    try {
      results = await command!.send_object(["KEYS", "$condition*"]);
    } catch (error) {
      debugPrint(error.toString());
      SmartDialogUtils.error("redis 连接异常");
    }
    // return results;
    currentQueriedKeys =
        results.map((e) => RedisModel(key: e.toString())).toList();
    notifyListeners();
  }

  void refresh() {
    couldQuery = true;
    _currentOffset = 0;
    notifyListeners();
  }

  bool couldQuery = true;

  Future getRangeKeys({String pattern = "*"}) async {
    command ??= await conn.connect(url, port);

    try {
      final results = await command!
          .send_object(["SCAN", _currentOffset, "match", pattern]);
      _currentOffset = int.tryParse(results.removeAt(0)) ?? 0;
      if (_currentOffset == 0) {
        couldQuery = false;
      }
      currentQueriedKeys = (results[0] as List).map((e) {
        return RedisModel(key: e.toString());
      }).toList();

      notifyListeners();
    } catch (error) {
      debugPrint(error.toString());
      SmartDialogUtils.error("redis 连接异常");
      return;
    }
  }

  int get listCount => currentQueriedKeys.length;

  Future changeModel(int index, RedisModel model) async {
    var res = await getVal(model.key);
    if (res.isNotEmpty) {
      model.value = res[1];
      model.valueType = res[0];
      model.ttl = res[2];
      // debugPrint(model.toString());
      currentQueriedKeys[index] = model;
      notifyListeners();
    }
  }

  Future<dynamic> getVal(String s) async {
    command ??= await conn.connect(url, port);
    List res = [];

    try {
      String type = await getValType(s);
      String ttl = (await getTTL(s)).toString();
      switch (type) {
        case "string":
          var val = await command!.send_object(["GET", s]);
          res = [type, val, ttl];
          break;
        case "list":
          var val = await command!.send_object(["LLEN", s]);
          res = [type, "长度为$val的数组", ttl];
          break;
        case "set":
          var val = await command!.send_object(["SCARD", s]);
          res = [type, "长度为$val的集合", ttl];
          break;
        case "hash":
          var val = await command!.send_object(["HLEN", s]);
          res = [type, "长度为$val的hash集合", ttl];
          break;
        case "sorted_set":
          var val = await command!.send_object(["ZCARD", s]);
          res = [type, "长度为$val的sorted set", ttl];
          break;
        default:
          res = [];
      }
    } catch (error) {
      debugPrint(error.toString());
      SmartDialogUtils.error("redis 连接异常");
    }

    return res;
  }

  Future<dynamic> getValType(String s) async {
    command ??= await conn.connect(url, port);
    var res = null;

    try {
      res = await command!.send_object(["TYPE", s]);
    } catch (error) {
      debugPrint(error.toString());
      SmartDialogUtils.error("redis 连接异常");
    }

    return res;
  }

  Future<dynamic> getTTL(String s) async {
    command ??= await conn.connect(url, port);
    var res = null;

    try {
      res = await command!.send_object(["TTL", s]);
    } catch (error) {
      debugPrint(error.toString());
      SmartDialogUtils.error("redis 连接异常");
    }

    return res;
  }

  Future testConnection() async {
    debugPrint("[redis]: url=> $url, port=> $port");
    if (command != null) {
      print("aaa");
      SmartDialogUtils.message("连接成功");
    } else {
      try {
        command = await conn.connect(url, port);
        SmartDialogUtils.message("连接成功");
      } catch (e) {
        SmartDialogUtils.error("redis 连接异常");
      }
    }
  }

  Future expiredInSecond(String key, int time) async {
    command ??= await conn.connect(url, port);
    try {
      await command!.send_object(["EXPIRE", key, time]);
    } catch (error) {
      debugPrint(error.toString());
      SmartDialogUtils.error("设置过期时间失败");
    }
  }

  Future expiredInMillisecond(String key, int time) async {
    command ??= await conn.connect(url, port);
    try {
      await command!.send_object(["PEXPIRE", key, time]);
    } catch (error) {
      debugPrint(error.toString());
      SmartDialogUtils.error("设置过期时间失败");
    }
  }

  Future expiredInTimestamp(String key, int time) async {
    command ??= await conn.connect(url, port);
    try {
      await command!.send_object(["EXPIREAT", key, time]);
    } catch (error) {
      debugPrint(error.toString());
      SmartDialogUtils.error("设置过期时间失败");
    }
  }

  Future expiredInMilliTimestamp(String key, int time) async {
    command ??= await conn.connect(url, port);
    try {
      await command!.send_object(["PEXPIREAT", key, time]);
    } catch (error) {
      debugPrint(error.toString());
      SmartDialogUtils.error("设置过期时间失败");
    }
  }

  Future<int> setNewKV(String key, String val, String valType) async {
    command ??= await conn.connect(url, port);
    int res = 1;
    try {
      if (valType == 'string') {
        await command!.send_object(["SET", key, val]);
      }
      if (valType == 'list') {
        List<String> vals = val.split(";");
        for (final i in vals) {
          await command!.send_object(["LPUSH", key, i]);
        }
      }
      if (valType == 'set') {
        List<String> vals = val.split(";");
        for (final i in vals) {
          await command!.send_object(["SADD", key, i]);
        }
      }
      if (valType == 'hashes') {
        List<String> vals = val.split(";");
        for (final i in vals) {
          await command!.send_object(["HSET", key, i.toString()]);
        }
      }
      if (valType == 'sorted_set') {
        List<String> vals = val.split(";");
        for (final i in vals) {
          await command!.send_object(["ZSET", key, i]);
        }
      }
    } catch (error) {
      debugPrint(error.toString());
      SmartDialogUtils.error("新建失败");
      res = -1;
    }
    return res;
  }

  Future<int> setExpire(String key, int time, String expireType) async {
    if (time == -1) {
      return 1;
    }

    command ??= await conn.connect(url, port);

    int res = 1;

    try {
      if (expireType == 'seconds') {
        await expiredInSecond(key, time);
      }
      if (expireType == 'milliseconds') {
        await expiredInMillisecond(key, time);
      }
      if (expireType == 'timestamp') {
        await expiredInTimestamp(key, time);
      }
      if (expireType == 'milli-timestamp') {
        await expiredInMilliTimestamp(key, time);
      }
    } catch (error) {
      debugPrint(error.toString());
      SmartDialogUtils.error("设置时间失败");
      res = -1;
    }

    return res;
  }

  Future delete(RedisModel model) async {
    command ??= await conn.connect(url, port);
    try {
      await command!.send_object(["DEL", model.key.toString()]);
      currentQueriedKeys.remove(model);
      notifyListeners();
    } catch (error) {
      debugPrint(error.toString());
      SmartDialogUtils.error("删除失败");
    }
  }
}
