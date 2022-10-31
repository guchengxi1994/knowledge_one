abstract class BaseFileEntity {
  String name;
  String? path;
  String? iconPath;

  BaseFileEntity({required this.name, this.path, this.iconPath});

  Map<String, dynamic> toJson();
}
