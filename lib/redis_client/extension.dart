const List<String> reservedCommonds = [
  "SELECT",
  "KEYS",
  "FLUSHALL", // flushall 清空所有数据（16个库全部清空）
  "FLUSHDB", // flushdb 清空当前数据库
  "EXISTS",
  "MOVE", // move移除，就是删除
  "EXPIRE",
  "TTL",
  "TYPE",
  "GETRANGE", // getrange截取value字符串(getrange key start end)
  "SETRANGE",
  "SETEX", // setex(set with expire) 设置过期时间
  "GET",
  "SET",
  "LPUSH",
  "LRANGE",
  "RPUSH",
  "LPOP",
  "RPOP",
  "LINDEX",
  "LLEN",
  "LREM",
  "LTRIM",
  "RPOPLPUSH", // 移除前一个列表的最后一个值，并将改值添加到另一个列表中列表中
  "LSET",
  "LINSET",
  "SADD",
  "SMEMBERS",
  "SISMEMBER", // sismember检查set中是否存在某个值
  "SCARD", // scard 获取set长度
  "SREM", // srem 移除指定元素(一次可移除多个)
  "SRANDMEMBER", // srandmember取指定个数，set中的随机值（大于size返回全部）
  "SPOP", // spop随机弹出元素（随机删除）（可以是多个）
  "SDIFF", // sdiff 返回两个set的差集
  "SINTER", // sinter返回两个set的交集
  "SUNION", // sunion 返回连个set的并集
  "HGET",
  "HSET",
  "HMSET", // hmset同时设置多个值
  "HMGET",
  "HGETALL", // hgetall获取哈希中的所有结果 （分别显示一对一对的键和值）
  "HDEL",
  "HLEN",
  "HEXISTS",
  "HKEYS",
  "HVALS",
  "HINCRBY", // hincrby （值自加）（值自增一个负数，表示自减）
  "HSETNX", // hsetnx检查是否存在，存在返回失败，不存在返回成功
  "ZADD",
  "ZRANGE",
  "ZREVRANGE",
  "ZRANGEBYSCORE",
  "WITHSCORES",
  "ZREM",
  "ZCARD",
  "ZCOUNT",
  "GROADD",
  "GEODIST", // geodist查询两个地理位置之间的距离
  "GEOHASH",
  "GEOPOS",
  "GEORADIUS",
  "GEORADIUSBYMEMBER",
  "PFADD",
  "PFCOUNT",
  "PFMERGE",
  "SETBIT",
  "GETBIT",
  "BITCOUNT"
];

extension RedisCliExtension on String {
  String format() {
    final l = split(" ");
    l[0] = l[0].toUpperCase();
    if (l.last == "WITHSCORES" &&
        ["ZRANGE", "ZREVRANGE", "ZRANGEBYSCORE"].contains(l[0])) {
      l.last = l.last.toUpperCase();
    }

    return l.join(" ");
  }
}
