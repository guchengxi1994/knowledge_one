import 'file_entity.dart';
import 'base_file_entity.dart';

class FolderEntity<T extends BaseFileEntity> extends BaseFileEntity {
  FolderEntity(
      {required String folderName,
      String path = "",
      String iconPath = "assets/images/folder.png",
      required this.children})
      : super(name: folderName, path: path, iconPath: iconPath);

  final List<T> children;

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> result = {};
    result["folderName"] = name;
    result['path'] = path;
    result['children'] = [];
    for (final i in children) {
      result['children'].add(i.toJson());
    }
    return result;
  }

  @override
  bool operator ==(Object other) {
    if (other is! FolderEntity) {
      return false;
    }
    return other.name == name;
  }

  void append(Object f) {
    if (f is T) {
      if (!children.contains(f)) {
        children.add(f);
      }
    }
  }

  void remove(Object f) {
    if (f is T) {
      if (children.contains(f)) {
        children.remove(f);
      }
    }
  }

  @override
  int get hashCode => name.hashCode;

  static FolderEntity fromJson(Map<String, dynamic> json) {
    FolderEntity result = FolderEntity(
        children: [],
        folderName: json['folderName'],
        path: json["path"] ?? "",
        iconPath: json["iconPath"] ?? "assets/images/folder.png");

    for (Map<String, dynamic> i in json['children']) {
      if (i['children'] != null) {
        result.append(FolderEntity.fromJson(i));
      } else {
        result.append(FileEntity.fromJson(i));
      }
    }

    return result;
  }
}
