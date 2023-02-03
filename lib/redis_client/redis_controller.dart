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

  Future<List<dynamic>> getRangeKeys(int offset, {String pattern = "*"}) async {
    List<dynamic> results = [];
    await conn.connect(url, port).then((Command command) async {
      results = await command.send_object(["SCAN", offset, "match", pattern]);
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      SmartDialogUtils.error("redis 连接异常");
    });

    return results;
  }

  Future<dynamic> getVal(String s) async {
    // var res = null;
    List res = [];

    await conn.connect(url, port).then((Command command) async {
      String type = await getValType(s);
      String ttl = (await getTTL(s)).toString();
      switch (type) {
        case "string":
          var val = await command.send_object(["GET", s]);
          res = [type, val, ttl];
          break;
        case "list":
          var val = await command.send_object(["LLEN", s]);
          res = [type, "为长度为$val的数组", ttl];
          break;
        default:
          res = [];
      }
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      SmartDialogUtils.error("redis 连接异常");
    });

    return res;
  }

  Future<dynamic> getValType(String s) async {
    var res = null;

    await conn.connect(url, port).then((Command command) async {
      res = await command.send_object(["TYPE", s]);
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      SmartDialogUtils.error("redis 连接异常");
    });

    return res;
  }

  Future<dynamic> getTTL(String s) async {
    var res = null;

    await conn.connect(url, port).then((Command command) async {
      res = await command.send_object(["TTL", s]);
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

  Future expiredInSecond(String key, int time) async {
    await conn.connect(url, port).then((Command command) async {
      await command.send_object(["EXPIRE", key, time]);
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      SmartDialogUtils.error("设置过期时间失败");
    });
  }

  Future expiredInMillisecond(String key, int time) async {
    await conn.connect(url, port).then((Command command) async {
      await command.send_object(["PEXPIRE", key, time]);
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      SmartDialogUtils.error("设置过期时间失败");
    });
  }

  Future expiredInTimestamp(String key, int time) async {
    await conn.connect(url, port).then((Command command) async {
      await command.send_object(["EXPIREAT", key, time]);
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      SmartDialogUtils.error("设置过期时间失败");
    });
  }

  Future expiredInMilliTimestamp(String key, int time) async {
    await conn.connect(url, port).then((Command command) async {
      await command.send_object(["PEXPIREAT", key, time]);
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      SmartDialogUtils.error("设置过期时间失败");
    });
  }

  Future<int> setNewKV(String key, String val, String valType) async {
    int res = 1;
    await conn.connect(url, port).then((Command command) async {
      if (valType == 'string') {
        await command.send_object(["SET", key, val]);
        return;
      }
      if (valType == 'list') {
        List<String> vals = val.split(";");
        for (final i in vals) {
          await command.send_object(["LPUSH", key, i]);
        }
        return;
      }
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      SmartDialogUtils.error("新建失败");
      res = -1;
    });
    return res;
  }

  Future<int> setExpire(String key, int time, String expireType) async {
    if (time == -1) {
      return 1;
    }

    int res = 1;

    await conn.connect(url, port).then((Command command) async {
      if (expireType == 'seconds') {
        await expiredInSecond(key, time);
        return;
      }
      if (expireType == 'milliseconds') {
        await expiredInMillisecond(key, time);
        return;
      }
      if (expireType == 'timestamp') {
        await expiredInTimestamp(key, time);
        return;
      }
      if (expireType == 'milli-timestamp') {
        await expiredInMilliTimestamp(key, time);
        return;
      }
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      SmartDialogUtils.error("设置时间失败");
      res = -1;
    });

    return res;
  }
}
