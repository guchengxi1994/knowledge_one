// ignore_for_file: avoid_print

import 'package:redis/redis.dart';

void main() async {
  late RedisConnection conn = RedisConnection();
  try {
    await conn.connect("localhost", 6379).then((Command command) async {
      print("start get client count");
      String r = await command.send_object(["info", "clients"]);
      print(r);
      print(r.split("\r\n"));
    });
  } catch (e) {
    print(e);
  }
  conn.close();
}
