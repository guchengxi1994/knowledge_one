// ignore_for_file: avoid_init_to_null

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:knowledge_one/bridge/native.dart' as n;
import 'package:knowledge_one/utils/utils.dart';

class AppConfigController extends ChangeNotifier {
  n.AppConfig? config = null;

  Future init() async {
    Directory executableDir = DevUtils.executableDir;
    config = await n.api
        .getAppConfig(configPath: "${executableDir.path}/app_config.yaml");

    notifyListeners();
  }
}
