import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:knowledge_one/app_style.dart';
import 'package:knowledge_one/src/native.dart';
import 'package:knowledge_one/src/native/bridge_definitions.dart'
    show NativeFileSummary;
import 'package:knowledge_one/utils/utils.dart';

import '../models/models.dart';

class WidgetStatus {
  double dx;
  double dy;

  WidgetStatus({this.dx = 0, this.dy = 0});
}

class FileSystemController extends ChangeNotifier {
  FolderEntity folder = FolderEntity(folderName: "root", children: []);
  Offset clickPoint = const Offset(0, 0);
  List<WidgetStatus> widgetStatus = [];
  bool isDragging = false;

  List<FolderEntity> folderList = [];

  int currentWidgetId = -1;

  changeCurrentWidgetId(int i) {
    currentWidgetId = i;
    notifyListeners();
  }

  changeClickPoint(Offset o) {
    clickPoint = o;
    notifyListeners();
  }

  changeGragStatus(bool b) {
    isDragging = b;
    notifyListeners();
  }

  BaseFileEntity? findObjectByOffset(Offset off) {
    for (int i = 0; i < currentFolderElements.length; i++) {
      if (widgetStatus[i].dx < off.dx - AppStyle.sideMenuWidth &&
          widgetStatus[i].dy < off.dy &&
          widgetStatus[i].dx + AppStyle.fileWidgetSize >
              off.dx - AppStyle.sideMenuWidth &&
          widgetStatus[i].dy + AppStyle.fileWidgetSize > off.dy) {
        // print(i);
        return currentFolderElements[i];
      }
    }

    return null;
  }

  changeWidgetStatus(int index, WidgetStatus status) {
    widgetStatus[index] = status;
  }

  moveToFolder(int objId, FolderEntity f) {
    final entity = folder.children[objId];
    folder.remove(entity);
    f.append(entity);

    // var file = File("${Directory.current.path}/_private/structure.json");
    file.writeAsStringSync(json.encode(folder.toJson()));

    notifyListeners();
  }

  navigateTo(FolderEntity f) {
    widgetStatus.clear();
    for (final _ in f.children) {
      widgetStatus.add(WidgetStatus());
    }
    folder = f;
    folderList.add(f);
    notifyListeners();
  }

  backToParentFolder() {
    if (folderList.length == 1) {
      return;
    }
    folderList.removeLast();
    folder = folderList.last;
    widgetStatus.clear();
    for (final _ in folder.children) {
      widgetStatus.add(WidgetStatus());
    }
    notifyListeners();
  }

  Directory executableDir = File(Platform.resolvedExecutable).parent;

  late final file = File("${executableDir.path}/_private/structure.json");

  init() async {
    // var file = File("${executableDir.path}/_private/structure.json");
    if (!file.existsSync()) {
      file.writeAsString(
          '{"folderName":"root","path":"","iconPath":"assets/icons/folder.png","children":[]}');
      file.createSync();
    }

    String jsonStr = await file.readAsString();
    final jsonResult = json.decode(jsonStr);
    String folderName = jsonResult['folderName'];
    List<BaseFileEntity> children = [];
    for (final i in jsonResult['children']) {
      // children.add(i.toJson());
      // print(i['children']);
      if (i['children'] == null) {
        children.add(FileEntity.fromJson(i));
      } else {
        children.add(FolderEntity.fromJson(i));
      }

      widgetStatus.add(WidgetStatus());
    }

    folder = FolderEntity(folderName: folderName, children: children);

    folderList.add(folder);
    notifyListeners();
  }

  List<BaseFileEntity> get currentFolderElements => folder.children;

  addToCurrentFolder(BaseFileEntity entity) async {
    int i = await api.newFile(
        f: NativeFileSummary(fileName: entity.name, filePath: entity.path));
    if (i == 1) {
      SmartDialogUtils.error("归档失败");
      return;
    }
    int lengthBefore = folder.children.length;
    folder.append(entity);
    int lengthAfter = folder.children.length;
    if (lengthAfter != lengthBefore) {
      widgetStatus.add(WidgetStatus());
      // var file = File("${Directory.current.path}/_private/structure.json");
      file.writeAsStringSync(json.encode(folder.toJson()));
      notifyListeners();
    }
  }

  String _getCurrentDirPath() {
    String s = "";
    for (final i in folderList) {
      s += "${i.name}/";
    }
    return s;
  }

  String get currentDirPath => _getCurrentDirPath();

  removeFromCurrentFolder(BaseFileEntity entity) {
    folder.children.remove(entity);
    file.writeAsStringSync(json.encode(folderList.first.toJson()));
    notifyListeners();
  }
}
