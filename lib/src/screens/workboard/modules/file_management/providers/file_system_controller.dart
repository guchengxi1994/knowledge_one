// ignore_for_file: avoid_init_to_null, prefer_iterable_wheretype

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:knowledge_one/app_style.dart';
import 'package:knowledge_one/native.dart';
import 'package:knowledge_one/utils/utils.dart';

import '../models/model.dart';

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
  double scrolledHeight = 0;

  changeScrolledHeight(double d) {
    scrolledHeight = d;
  }

  List<FolderEntity> folderList = [];

  int currentWidgetId = -1;

  List<String> getCurrentFileNames() {
    return folder.children
        .where((element) => (element is FileEntity))
        .map((e) => e.name)
        .toList();
  }

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
        // print(widgetStatus[i].dx);
        // print(widgetStatus[i].dx + 71);
        // print(widgetStatus[i].dy);
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
    file.writeAsStringSync(json.encode(folderList.first.toJson()));

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

  late final file =
      File("${DevUtils.executableDir.path}/_private/structure.json");

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

    /// TODO 连接数据库进行优化
    for (final i in jsonResult['children']) {
      // children.add(i.toJson());
      // print(i['children']);
      if (i['children'] == null) {
        if (i["versionControl"] == 1) {
          i['iconPath'] = "assets/icons/vc_file.png";
        }

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

  Future changeFileHash2(String cacheFilePath, FileEntity entity,
      {String? diffPath}) async {
    final r =
        await _changeFileHashImpl(cacheFilePath, entity, diffPath: diffPath);
    if (r == "") {
      SmartDialogUtils.error("失败");
    } else {
      entity.fileHash = r;
      final id = folder.children.indexOf(entity);
      folder.children.removeAt(id);
      folder.children.insert(id, entity);
      file.writeAsStringSync(json.encode(folderList.first.toJson()));
      notifyListeners();
    }
  }

  Future<String> _changeFileHashImpl(String cacheFilePath, FileEntity entity,
      {String? diffPath}) async {
    final r = await api.changeFileHashById(
        oriFilePath: entity.path!,
        filePath: cacheFilePath,
        fileId: entity.fileId!,
        diffPath: diffPath);
    return r;
  }

  List<BaseFileEntity> get currentFolderElements => folder.children;

  addToCurrentFolder(BaseFileEntity entity) async {
    if (entity is FileEntity) {
      final String fileHash;
      if (entity.path == "" || entity.path == null) {
        final filePath =
            "${DevUtils.executableDir.path}/_private/${entity.name}";
        debugPrint(filePath);
        final r = await api.createNewDiskFile(filePath: filePath);
        if (r == 500) {
          SmartDialogUtils.warning("文件已存在");
          return;
        } else if (r == -1) {
          SmartDialogUtils.error("归档失败");
          return;
        }
        fileHash = await api.getFileHash(filePath: filePath);
        entity.path = filePath;
        entity.fileId = r;
      } else {
        fileHash = await api.getFileHash(filePath: entity.path!);
      }

      int i = await api.newFile(
          f: NativeFileSummary(
              fileName: entity.name,
              filePath: entity.path,
              fileHash: fileHash,
              versionControl: 0));
      if (i == 0) {
        SmartDialogUtils.error("归档失败");
        return;
      } else if (i == -1) {
        SmartDialogUtils.warning("文件已存在");
        return;
      } else if (i == -500) {
        SmartDialogUtils.warning("已存在不同版本文件");
        return;
      }

      entity.fileHash = fileHash;
      entity.fileId = i;
    }

    int lengthBefore = folder.children.length;
    folder.append(entity);
    int lengthAfter = folder.children.length;
    if (lengthAfter != lengthBefore) {
      widgetStatus.add(WidgetStatus());

      file.writeAsStringSync(json.encode(folderList.first.toJson()));
      notifyListeners();
    }
  }

  changeVersionControlStatus(FileEntity entity) {
    // folder.children.remove(entity);
    final id = folder.children.indexOf(entity);
    folder.children.removeAt(id);
    entity.versionControl = 1;
    folder.children.insert(id, entity);
    file.writeAsStringSync(json.encode(folderList.first.toJson()));
    notifyListeners();
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

  /// 排序
  FileSortStrategy sortStrategy = FileSortStrategy.none;
  FileSortByTimeStrategy sortByTimeStrategy = FileSortByTimeStrategy.asc;

  sortByType() {
    if (folder.children.isEmpty) {
      return;
    }

    if (sortStrategy == FileSortStrategy.none ||
        sortStrategy == FileSortStrategy.fileFirst) {
      sortStrategy = FileSortStrategy.folderFirst;
    } else {
      sortStrategy = FileSortStrategy.fileFirst;
    }

    List<FileEntity> entityFile = [];
    List<FolderEntity> entityFolder = [];

    for (final i in folder.children) {
      if (i is FileEntity) {
        entityFile.add(i);
      } else {
        entityFolder.add(i as FolderEntity);
      }
    }

    folder.children.clear();

    if (sortStrategy == FileSortStrategy.fileFirst) {
      folder.children.addAll(entityFile);
      folder.children.addAll(entityFolder);
    } else {
      folder.children.addAll(entityFolder);
      folder.children.addAll(entityFile);
    }

    notifyListeners();
  }

  sortByTime() {
    if (folder.children.isEmpty) {
      return;
    }

    final children = folder.children.reversed.toList();
    folder.children.clear();
    folder.children.addAll(children);
    if (sortByTimeStrategy == FileSortByTimeStrategy.asc) {
      sortByTimeStrategy = FileSortByTimeStrategy.desc;
    } else {
      sortByTimeStrategy = FileSortByTimeStrategy.asc;
    }
    notifyListeners();
  }
}
