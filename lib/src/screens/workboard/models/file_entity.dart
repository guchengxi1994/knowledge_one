import 'base_file_entity.dart';

class FileEntity extends BaseFileEntity {
  FileEntity(
      {required String fileName,
      this.fileHash,
      this.versionControl,
      String path = "",
      String iconPath = "assets/icons/file.png"})
      : super(name: fileName, path: path, iconPath: iconPath);

  String? fileHash;
  int? versionControl;

  @override
  Map<String, dynamic> toJson() {
    return {
      "fileName": name,
      "path": path,
      "fileHash": fileHash,
      "versionControl": versionControl
    };
  }

  @override
  bool operator ==(Object other) {
    if (other is! FileEntity) {
      return false;
    }
    return other.name == name;
  }

  @override
  int get hashCode => name.hashCode;

  static FileEntity fromJson(Map<String, dynamic> json) {
    return FileEntity(
        versionControl: json['versionControl'],
        fileHash: json['fileHash'],
        fileName: json['fileName'],
        path: json["path"] ?? "",
        iconPath: json["iconPath"] ?? "assets/icons/file.png");
  }
}
