import 'dart:io';

import 'package:flutter/material.dart';

enum RPCTypes { fileChangeLog }

/// 本地RPC管理
class RPCController extends ChangeNotifier {
  Map<RPCTypes, int?> validRPCs = {};
  bool isRPCValid(RPCTypes t) {
    return validRPCs[t] != null;
  }

  startFileChangelogTracingRPC() async {
    if (validRPCs[RPCTypes.fileChangeLog] == null) {
      final path = File(Platform.resolvedExecutable).parent;
      late String tracingExe = "${path.path}/file_changelog/file_changelog.exe";
      final process = await Process.start(tracingExe, []);
      addRPC(RPCTypes.fileChangeLog, process.pid);
      debugPrint("pid:${process.pid}");
    }
  }

  addRPC(RPCTypes t, int rpcProcessId) {
    validRPCs[t] = rpcProcessId;
    notifyListeners();
  }

  removeRPC(RPCTypes t) {
    validRPCs[t] = null;
    notifyListeners();
  }

  removeAndTerminateRPC(RPCTypes t) {
    int? id = validRPCs[t];
    if (id != null) {
      try {
        final r = Process.killPid(id);
        if (r) {
          removeRPC(t);
        }
      } catch (_) {}
    }
  }

  endAll() {
    try {
      for (final i in validRPCs.entries) {
        if (i.value != null) {
          final r = Process.killPid(i.value!);
          if (r) {
            removeRPC(i.key);
          }
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
