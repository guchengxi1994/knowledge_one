// ignore_for_file: avoid_print

import 'package:grpc/grpc.dart';
import 'package:knowledge_one/src/rpc/file_restore.pbgrpc.dart';

void main() async {
  const name1 = "C:/Users/xiaoshuyui/Desktop/我的图片 - 副本.png";
  const name2 = "C:/Users/xiaoshuyui/Desktop/我的图片.png";

  final channel = ClientChannel(
    'localhost',
    port: 15556,
    options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
  );

  final stub = FileRestoreClient(channel);
  final t = DateTime.now();

  RestoreRequest request = RestoreRequest(filePath: name1, diffs: [name2]);
  try {
    var response = await stub.restore(request);
    print('服务端返回信息: ${response.message}');
  } catch (e) {
    print('Caught error: $e');
  }
  await channel.shutdown();

  print(DateTime.now().difference(t).inMilliseconds);
}
