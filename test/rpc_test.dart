// ignore_for_file: avoid_print

import 'package:grpc/grpc.dart';
import 'package:knowledge_one/rpc/file_diff.pbgrpc.dart';

void main() async {
  const name1 = "C:/Users/xiaoshuyui/Desktop/我的图片 - 副本.png";
  const name2 = "C:/Users/xiaoshuyui/Desktop/我的图片.png";

  final channel = ClientChannel(
    'localhost',
    port: 15556,
    options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
  );

  final stub = FileDiffClient(channel);
  try {
    var response = await stub.generateDiff(GenerateDiffRequest()
      ..after = name1
      ..before = name2
      ..savePath = "test.mtx");
    print('服务端返回信息: ${response.message}');
  } catch (e) {
    print('Caught error: $e');
  }
  await channel.shutdown();
}
