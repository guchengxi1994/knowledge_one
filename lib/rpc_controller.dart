import 'dart:io';

import 'package:flutter/material.dart';

enum RPCTypes { fileChangeLog }

/// 本地RPC管理
class RPCController extends ChangeNotifier {
  Map<RPCTypes, int?> validRPCs = {};
  bool isRPCValid(RPCTypes t) {
    return validRPCs[t] != null;
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
}
