import 'base_file_entity.dart';

class FileEntity extends BaseFileEntity {
  FileEntity(
      {required String fileName,
      required this.fileId,
      this.fileHash,
      this.versionControl,
      String path = "",
      String iconPath = "assets/icons/file.png"})
      : super(name: fileName, path: path, iconPath: iconPath);

  String? fileHash;
  int? versionControl;
  int? fileId;

  @override
  Map<String, dynamic> toJson() {
    return {
      "fileName": name,
      "path": path,
      "fileHash": fileHash,
      "versionControl": versionControl,
      "fileId": fileId
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
        fileId: json['fileId'],
        versionControl: json['versionControl'],
        fileHash: json['fileHash'],
        fileName: json['fileName'],
        path: json["path"] ?? "",
        iconPath: json["iconPath"] ?? "assets/icons/file.png");
  }
}
