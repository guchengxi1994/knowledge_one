// ignore_for_file: avoid_init_to_null, prefer_typing_uninitialized_variables, depend_on_referenced_packages

import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:knowledge_one/bridge/native.dart';
import 'package:knowledge_one/utils/utils.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:redis/redis.dart';
import 'package:collection/collection.dart';
import 'model.dart';

class RedisConnectionDetails {
  int connectedClients;
  int clientLongestOutputList;
  int clientBiggestInputBuf;
  int blockedClients;

  RedisConnectionDetails(
      {required this.blockedClients,
      required this.clientBiggestInputBuf,
      required this.clientLongestOutputList,
      required this.connectedClients});

  static RedisConnectionDetails fromList(List<String> l) {
    var l0 = l[1];
    var l1 = l[2];
    var l2 = l[3];
    var l3 = l[4];
    return RedisConnectionDetails(
        blockedClients: int.tryParse(l3.split(":").last) ?? 0,
        clientBiggestInputBuf: int.tryParse(l2.split(":").last) ?? 0,
        clientLongestOutputList: int.tryParse(l1.split(":").last) ?? 0,
        connectedClients: int.tryParse(l0.split(":").last) ?? 0);
  }
}

class RedisMemoryDetails {
  String usedMemory;
  String peakUsedMemory;

  RedisMemoryDetails({required this.peakUsedMemory, required this.usedMemory});

  static RedisMemoryDetails fromList(List<String> l) {
    var l0 = l[2];
    var l1 = l[5];

    return RedisMemoryDetails(
        usedMemory: l0.split(":").last, peakUsedMemory: l1.split(":").last);
  }
}

class RedisController extends ChangeNotifier {
  late RedisConnection conn = RedisConnection();
  late Command? command = null;

  /// 悬停的行
  int currentHoveredRowId = -1;
  changeCurrentHoveredRowId(int id) {
    currentHoveredRowId = id;
    notifyListeners();
  }

  /// 选中的行
  int currentSelectedRowId = -1;
  changeCurrentSelectedRowId(int id) {
    currentSelectedRowId = id;
    notifyListeners();
  }

  /// default url and port
  String url = "localhost";
  int port = 6379;

  static const int refreshTime = 5;

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

  dropConnection() {
    conn.close();
  }

  Stream<String> getMemoryUsed() async* {
    while (true) {
      if (url != "localhost" && url != "127.0.0.1") {
        yield "";
      } else {
        var s = await api.getRedisMemory();
        if (s == "") {
          yield "";
        } else {
          yield filesize(s);
        }
      }
      await Future.delayed(const Duration(seconds: refreshTime));
    }
  }

  Stream<String> getCpuUsed() async* {
    while (true) {
      if (url != "localhost" && url != "127.0.0.1") {
        yield "";
      } else {
        var s = await api.getRedisCpu();
        if (s == "") {
          yield "";
        } else {
          yield "$s%";
        }
      }
      await Future.delayed(const Duration(seconds: refreshTime));
    }
  }

  Stream<RedisMemoryDetails> getMemoryDetails() async* {
    while (true) {
      try {
        List<String> res = [];
        command ??= await conn.connect(url, port);
        String r = await command!.send_object(["info", "memory"]);
        // await conn.connect(url, port).then((Command command) async {
        //   String r = await command.send_object(["info", "clients"]);
        if (DevUtils.isWindows) {
          res = r.split("\r\n");
        } else {
          res = r.split("\n");
        }
        // });
        // debugPrint(res.toString());
        if (res.length != 10) {
          debugPrint(res.length.toString());
          throw Exception("[RedisMemoryDetails] wrong list length");
        }
        yield RedisMemoryDetails.fromList(res);
      } catch (e) {
        debugPrint(e.toString());
      } finally {}
      await Future.delayed(const Duration(seconds: refreshTime));
    }
  }

  /// 获取当前client连接数
  Stream<RedisConnectionDetails> getClientCount() async* {
    while (true) {
      try {
        List<String> res = [];
        command ??= await conn.connect(url, port);
        String r = await command!.send_object(["info", "clients"]);
        // await conn.connect(url, port).then((Command command) async {
        //   String r = await command.send_object(["info", "clients"]);
        if (DevUtils.isWindows) {
          res = r.split("\r\n");
        } else {
          res = r.split("\n");
        }
        // });
        // debugPrint(res.toString());
        if (res.length != 6) {
          debugPrint(res.length.toString());
          throw Exception("[RedisConnectionDetails] wrong list length");
        }
        yield RedisConnectionDetails.fromList(res);
      } catch (e) {
        debugPrint(e.toString());
      } finally {}
      await Future.delayed(const Duration(seconds: refreshTime));
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

      for (final i in currentQueriedKeys) {
        final val = await getVal(i.key);
        if (val.isNotEmpty) {
          // i.value = val[1];
          i.valueType = val[0];
          i.ttl = val[1];
        }
      }

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
      // model.value = res[1];
      model.valueType = res[0];
      model.ttl = res[1];
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
      res = [type, ttl];
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

  late dynamic value = null;

  dynamic getValueFromKey(RedisData data) async {
    final s = data.model.key;
    String type = await getValType(s);
    var val;
    switch (type) {
      case "string":
        val = await command!.send_object(["GET", s]);
        // widget = Text(val.toString());
        break;
      case "list":
        var listLength = int.tryParse(
                (await command!.send_object(["LLEN", s])).toString()) ??
            0;
        val = await command!.send_object(["LRANGE", s, 0, listLength]);
        break;
      case "set":
        // var setSize = await command!.send_object(["SCARD", s]);
        val = await command!.send_object(["SMEMBERS", s]);
        break;
      case "hash":
        // var hashLength = await command!.send_object(["HLEN", s]);
        val = [
          await command!.send_object(["HGETALL", s])
        ];
        break;
      case "zset":
        var setSize = await command!.send_object(["ZCARD", s]);
        final doubleList =
            await command!.send_object(["ZRANGE", s, 0, setSize, "WITHSCORES"]);

        val = [];
        for (int i = 0; i < doubleList.length; i = i + 2) {
          val.add([doubleList[i], doubleList[i + 1]]);
        }

        break;
      default:
        val = "";
    }
    value = val;
    return val;
  }

  Widget buildTableFromVal(List<dynamic> vals) {
    List<PlutoColumn> columns = [
      PlutoColumn(
          title: "index",
          field: "number_field",
          type: PlutoColumnType.number()),
      PlutoColumn(
          title: "value", field: "text_field", type: PlutoColumnType.text())
    ];

    List<PlutoRow> rows = vals
        .mapIndexed((index, element) => PlutoRow(cells: {
              'number_field': PlutoCell(value: index),
              'text_field': PlutoCell(value: element.toString())
            }))
        .toList();

    return PlutoGrid(
      columns: columns,
      rows: rows,
      onChanged: (event) {
        /// TODO
        ///
        /// complete event
        print(event);
      },
    );
  }
}
