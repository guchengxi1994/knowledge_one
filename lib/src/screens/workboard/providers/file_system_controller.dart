import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:knowledge_one/app_style.dart';

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

    var file = File("${Directory.current.path}/_private/structure.json");
    file.writeAsStringSync(json.encode(folder.toJson()));

    notifyListeners();
  }

  navigateTo(FolderEntity f) {
    widgetStatus.clear();
    for (final i in f.children) {
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
    for (final i in folder.children) {
      widgetStatus.add(WidgetStatus());
    }
    notifyListeners();
  }

  init() async {
    Directory executableDir = File(Platform.resolvedExecutable).parent;
    var file = File("${executableDir.path}/_private/structure.json");
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
  }

  List<BaseFileEntity> get currentFolderElements => folder.children;

  addToCurrentFolder(BaseFileEntity entity) {
    int lengthBefore = folder.children.length;
    folder.append(entity);
    int lengthAfter = folder.children.length;
    if (lengthAfter != lengthBefore) {
      widgetStatus.add(WidgetStatus());
      var file = File("${Directory.current.path}/_private/structure.json");
      file.writeAsStringSync(json.encode(folder.toJson()));
      notifyListeners();
    }
  }
}
