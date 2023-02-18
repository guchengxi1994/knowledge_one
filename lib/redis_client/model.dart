// ignore_for_file: avoid_init_to_null

class RedisModel {
  final dynamic key;
  // dynamic value = null;
  dynamic valueType = null;
  dynamic ttl = null;
  RedisModel({required this.key});

  @override
  String toString() {
    return "key: $key type:$valueType";
  }
}

class RedisData {
  final int index;
  RedisModel model;
  RedisData({
    required this.index,
    required this.model,
  });
}
