import 'package:knowledge_one/bridge/native.dart' as native;

class OperationLog {
  String operationName;
  String operationContent;

  OperationLog({this.operationContent = "未知操作", required this.operationName});

  Future insertLog() async {
    await native.api.insertANewLog(
        log: native.OperationLogSummary(
            operationContent: operationContent, operationName: operationName));
  }
}
