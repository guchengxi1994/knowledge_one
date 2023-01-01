// AUTO GENERATED FILE, DO NOT EDIT.
// Generated by `flutter_rust_bridge`@ 1.58.2.
// ignore_for_file: non_constant_identifier_names, unused_element, duplicate_ignore, directives_ordering, curly_braces_in_flow_control_structures, unnecessary_lambdas, slash_for_doc_comments, prefer_const_literals_to_create_immutables, implicit_dynamic_list_literal, duplicate_import, unused_import, prefer_single_quotes, prefer_const_constructors, use_super_parameters, always_use_package_imports, annotate_overrides, invalid_use_of_protected_member, constant_identifier_names, invalid_use_of_internal_member

import 'dart:convert';
import 'dart:async';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';

import 'package:meta/meta.dart';
import 'package:meta/meta.dart';
import 'dart:ffi' as ffi;

abstract class Native {
  Future<void> createAllDirectory({required String s, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kCreateAllDirectoryConstMeta;

  /// 根据file_id 和hash值获取修改的changelog
  Future<List<FileChangelog>?> getChangelogFromId(
      {required int id, required String fileHash, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kGetChangelogFromIdConstMeta;

  /// 获取文件hash值
  Future<String> getFileHash({required String filePath, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kGetFileHashConstMeta;

  /// 根据文件hash值软删除文件
  Future<int> deleteFileByFileHash({required String fileHash, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kDeleteFileByFileHashConstMeta;

  /// 改变版本控制
  Future<int> changeVersionControl({required String fileHash, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kChangeVersionControlConstMeta;

  /// 手动更新新版本 （右键绑定新版本）
  Future<int> createNewVersion(
      {required NativeFileNewVersion model, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kCreateNewVersionConstMeta;

  /// 创建一个物理文件
  Future<int> createNewDiskFile({required String filePath, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kCreateNewDiskFileConstMeta;

  /// 根据现在的hash值获取变更记录
  Future<List<FileChangelog>?> getFileLogs(
      {required String fileHash, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kGetFileLogsConstMeta;

  /// 根据文件id修改文件hash
  Future<String> changeFileHashById(
      {required String oriFilePath,
      required String filePath,
      required int fileId,
      String? diffPath,
      dynamic hint});

  FlutterRustBridgeTaskConstMeta get kChangeFileHashByIdConstMeta;

  /// 初始化数据库，创建数据库连接池
  Future<void> initMysql({required String confPath, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kInitMysqlConstMeta;

  /// 获取所有状态
  Future<List<TodoStatus>> getStatusTypes({dynamic hint});

  FlutterRustBridgeTaskConstMeta get kGetStatusTypesConstMeta;

  /// 获取所有todo
  Future<List<TodoDetails>> getTodos({dynamic hint});

  FlutterRustBridgeTaskConstMeta get kGetTodosConstMeta;

  /// 获取所有文件
  Future<List<FileDetails>> getFiles({dynamic hint});

  FlutterRustBridgeTaskConstMeta get kGetFilesConstMeta;

  /// 创建文件
  Future<int> newFile({required NativeFileSummary f, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kNewFileConstMeta;

  /// svg_cleaner for file
  Future<CleanerResult?> cleanSvgFile({required String filePath, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kCleanSvgFileConstMeta;

  /// svg_cleaner for string
  Future<CleanerResult?> cleanSvgString(
      {required String content, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kCleanSvgStringConstMeta;
}

class CleanerResult {
  final int duration;
  final double radio;
  final String result;
  final String origin;

  CleanerResult({
    required this.duration,
    required this.radio,
    required this.result,
    required this.origin,
  });
}

class FileChangelog {
  final int changelogId;
  final int fileId;
  final String? versionId;
  final String? prevVersionId;
  final int isDeleted;
  final DateTime createAt;
  final DateTime updateAt;
  final int fileLength;
  final String? filePath;
  final String? diffPath;

  FileChangelog({
    required this.changelogId,
    required this.fileId,
    this.versionId,
    this.prevVersionId,
    required this.isDeleted,
    required this.createAt,
    required this.updateAt,
    required this.fileLength,
    this.filePath,
    this.diffPath,
  });
}

class FileDetails {
  final int fileId;
  final String? fileName;
  final String? filePath;
  final int isDeleted;
  final DateTime createAt;
  final DateTime updateAt;
  final String? fileHash;
  final int versionControl;

  FileDetails({
    required this.fileId,
    this.fileName,
    this.filePath,
    required this.isDeleted,
    required this.createAt,
    required this.updateAt,
    this.fileHash,
    required this.versionControl,
  });
}

class NativeFileNewVersion {
  final String prevFilePath;
  final String prevFileHash;
  final String prevFileName;
  final String newVersionFilePath;
  final String newVersionFileHash;
  final String newVersionFileName;
  final String? diffPath;

  NativeFileNewVersion({
    required this.prevFilePath,
    required this.prevFileHash,
    required this.prevFileName,
    required this.newVersionFilePath,
    required this.newVersionFileHash,
    required this.newVersionFileName,
    this.diffPath,
  });
}

class NativeFileSummary {
  final String? fileName;
  final String? filePath;
  final String? fileHash;
  final int versionControl;

  NativeFileSummary({
    this.fileName,
    this.filePath,
    this.fileHash,
    required this.versionControl,
  });
}

class TodoDetails {
  final int todoId;
  final String? todoName;
  final String? todoContent;
  final String? todoStatusName;
  final String? todoFrom;
  final String? todoTo;
  final String? taskName;
  final int taskId;
  final String? todoStatusColor;

  TodoDetails({
    required this.todoId,
    this.todoName,
    this.todoContent,
    this.todoStatusName,
    this.todoFrom,
    this.todoTo,
    this.taskName,
    required this.taskId,
    this.todoStatusColor,
  });
}

class TodoStatus {
  final int todoStatusId;
  final String? todoStatusName;
  final String? todoStatusColor;

  TodoStatus({
    required this.todoStatusId,
    this.todoStatusName,
    this.todoStatusColor,
  });
}

class NativeImpl implements Native {
  final NativePlatform _platform;
  factory NativeImpl(ExternalLibrary dylib) =>
      NativeImpl.raw(NativePlatform(dylib));

  /// Only valid on web/WASM platforms.
  factory NativeImpl.wasm(FutureOr<WasmModule> module) =>
      NativeImpl(module as ExternalLibrary);
  NativeImpl.raw(this._platform);
  Future<void> createAllDirectory({required String s, dynamic hint}) {
    var arg0 = _platform.api2wire_String(s);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) =>
          _platform.inner.wire_create_all_directory(port_, arg0),
      parseSuccessData: _wire2api_unit,
      constMeta: kCreateAllDirectoryConstMeta,
      argValues: [s],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kCreateAllDirectoryConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "create_all_directory",
        argNames: ["s"],
      );

  Future<List<FileChangelog>?> getChangelogFromId(
      {required int id, required String fileHash, dynamic hint}) {
    var arg0 = _platform.api2wire_i64(id);
    var arg1 = _platform.api2wire_String(fileHash);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) =>
          _platform.inner.wire_get_changelog_from_id(port_, arg0, arg1),
      parseSuccessData: _wire2api_opt_list_file_changelog,
      constMeta: kGetChangelogFromIdConstMeta,
      argValues: [id, fileHash],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kGetChangelogFromIdConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "get_changelog_from_id",
        argNames: ["id", "fileHash"],
      );

  Future<String> getFileHash({required String filePath, dynamic hint}) {
    var arg0 = _platform.api2wire_String(filePath);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_get_file_hash(port_, arg0),
      parseSuccessData: _wire2api_String,
      constMeta: kGetFileHashConstMeta,
      argValues: [filePath],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kGetFileHashConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "get_file_hash",
        argNames: ["filePath"],
      );

  Future<int> deleteFileByFileHash({required String fileHash, dynamic hint}) {
    var arg0 = _platform.api2wire_String(fileHash);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) =>
          _platform.inner.wire_delete_file_by_file_hash(port_, arg0),
      parseSuccessData: _wire2api_i64,
      constMeta: kDeleteFileByFileHashConstMeta,
      argValues: [fileHash],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kDeleteFileByFileHashConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "delete_file_by_file_hash",
        argNames: ["fileHash"],
      );

  Future<int> changeVersionControl({required String fileHash, dynamic hint}) {
    var arg0 = _platform.api2wire_String(fileHash);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) =>
          _platform.inner.wire_change_version_control(port_, arg0),
      parseSuccessData: _wire2api_i64,
      constMeta: kChangeVersionControlConstMeta,
      argValues: [fileHash],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kChangeVersionControlConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "change_version_control",
        argNames: ["fileHash"],
      );

  Future<int> createNewVersion(
      {required NativeFileNewVersion model, dynamic hint}) {
    var arg0 = _platform.api2wire_box_autoadd_native_file_new_version(model);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_create_new_version(port_, arg0),
      parseSuccessData: _wire2api_i64,
      constMeta: kCreateNewVersionConstMeta,
      argValues: [model],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kCreateNewVersionConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "create_new_version",
        argNames: ["model"],
      );

  Future<int> createNewDiskFile({required String filePath, dynamic hint}) {
    var arg0 = _platform.api2wire_String(filePath);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) =>
          _platform.inner.wire_create_new_disk_file(port_, arg0),
      parseSuccessData: _wire2api_i64,
      constMeta: kCreateNewDiskFileConstMeta,
      argValues: [filePath],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kCreateNewDiskFileConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "create_new_disk_file",
        argNames: ["filePath"],
      );

  Future<List<FileChangelog>?> getFileLogs(
      {required String fileHash, dynamic hint}) {
    var arg0 = _platform.api2wire_String(fileHash);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_get_file_logs(port_, arg0),
      parseSuccessData: _wire2api_opt_list_file_changelog,
      constMeta: kGetFileLogsConstMeta,
      argValues: [fileHash],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kGetFileLogsConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "get_file_logs",
        argNames: ["fileHash"],
      );

  Future<String> changeFileHashById(
      {required String oriFilePath,
      required String filePath,
      required int fileId,
      String? diffPath,
      dynamic hint}) {
    var arg0 = _platform.api2wire_String(oriFilePath);
    var arg1 = _platform.api2wire_String(filePath);
    var arg2 = _platform.api2wire_i64(fileId);
    var arg3 = _platform.api2wire_opt_String(diffPath);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner
          .wire_change_file_hash_by_id(port_, arg0, arg1, arg2, arg3),
      parseSuccessData: _wire2api_String,
      constMeta: kChangeFileHashByIdConstMeta,
      argValues: [oriFilePath, filePath, fileId, diffPath],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kChangeFileHashByIdConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "change_file_hash_by_id",
        argNames: ["oriFilePath", "filePath", "fileId", "diffPath"],
      );

  Future<void> initMysql({required String confPath, dynamic hint}) {
    var arg0 = _platform.api2wire_String(confPath);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_init_mysql(port_, arg0),
      parseSuccessData: _wire2api_unit,
      constMeta: kInitMysqlConstMeta,
      argValues: [confPath],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kInitMysqlConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "init_mysql",
        argNames: ["confPath"],
      );

  Future<List<TodoStatus>> getStatusTypes({dynamic hint}) {
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_get_status_types(port_),
      parseSuccessData: _wire2api_list_todo_status,
      constMeta: kGetStatusTypesConstMeta,
      argValues: [],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kGetStatusTypesConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "get_status_types",
        argNames: [],
      );

  Future<List<TodoDetails>> getTodos({dynamic hint}) {
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_get_todos(port_),
      parseSuccessData: _wire2api_list_todo_details,
      constMeta: kGetTodosConstMeta,
      argValues: [],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kGetTodosConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "get_todos",
        argNames: [],
      );

  Future<List<FileDetails>> getFiles({dynamic hint}) {
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_get_files(port_),
      parseSuccessData: _wire2api_list_file_details,
      constMeta: kGetFilesConstMeta,
      argValues: [],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kGetFilesConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "get_files",
        argNames: [],
      );

  Future<int> newFile({required NativeFileSummary f, dynamic hint}) {
    var arg0 = _platform.api2wire_box_autoadd_native_file_summary(f);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_new_file(port_, arg0),
      parseSuccessData: _wire2api_i64,
      constMeta: kNewFileConstMeta,
      argValues: [f],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kNewFileConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "new_file",
        argNames: ["f"],
      );

  Future<CleanerResult?> cleanSvgFile(
      {required String filePath, dynamic hint}) {
    var arg0 = _platform.api2wire_String(filePath);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_clean_svg_file(port_, arg0),
      parseSuccessData: _wire2api_opt_box_autoadd_cleaner_result,
      constMeta: kCleanSvgFileConstMeta,
      argValues: [filePath],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kCleanSvgFileConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "clean_svg_file",
        argNames: ["filePath"],
      );

  Future<CleanerResult?> cleanSvgString(
      {required String content, dynamic hint}) {
    var arg0 = _platform.api2wire_String(content);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_clean_svg_string(port_, arg0),
      parseSuccessData: _wire2api_opt_box_autoadd_cleaner_result,
      constMeta: kCleanSvgStringConstMeta,
      argValues: [content],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kCleanSvgStringConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "clean_svg_string",
        argNames: ["content"],
      );

  void dispose() {
    _platform.dispose();
  }
// Section: wire2api

  DateTime _wire2api_Chrono_Utc(dynamic raw) {
    return wire2apiTimestamp(ts: _wire2api_i64(raw), isUtc: true);
  }

  String _wire2api_String(dynamic raw) {
    return raw as String;
  }

  CleanerResult _wire2api_box_autoadd_cleaner_result(dynamic raw) {
    return _wire2api_cleaner_result(raw);
  }

  CleanerResult _wire2api_cleaner_result(dynamic raw) {
    final arr = raw as List<dynamic>;
    if (arr.length != 4)
      throw Exception('unexpected arr length: expect 4 but see ${arr.length}');
    return CleanerResult(
      duration: _wire2api_u32(arr[0]),
      radio: _wire2api_f64(arr[1]),
      result: _wire2api_String(arr[2]),
      origin: _wire2api_String(arr[3]),
    );
  }

  double _wire2api_f64(dynamic raw) {
    return raw as double;
  }

  FileChangelog _wire2api_file_changelog(dynamic raw) {
    final arr = raw as List<dynamic>;
    if (arr.length != 10)
      throw Exception('unexpected arr length: expect 10 but see ${arr.length}');
    return FileChangelog(
      changelogId: _wire2api_i64(arr[0]),
      fileId: _wire2api_i64(arr[1]),
      versionId: _wire2api_opt_String(arr[2]),
      prevVersionId: _wire2api_opt_String(arr[3]),
      isDeleted: _wire2api_i64(arr[4]),
      createAt: _wire2api_Chrono_Utc(arr[5]),
      updateAt: _wire2api_Chrono_Utc(arr[6]),
      fileLength: _wire2api_i64(arr[7]),
      filePath: _wire2api_opt_String(arr[8]),
      diffPath: _wire2api_opt_String(arr[9]),
    );
  }

  FileDetails _wire2api_file_details(dynamic raw) {
    final arr = raw as List<dynamic>;
    if (arr.length != 8)
      throw Exception('unexpected arr length: expect 8 but see ${arr.length}');
    return FileDetails(
      fileId: _wire2api_i64(arr[0]),
      fileName: _wire2api_opt_String(arr[1]),
      filePath: _wire2api_opt_String(arr[2]),
      isDeleted: _wire2api_i64(arr[3]),
      createAt: _wire2api_Chrono_Utc(arr[4]),
      updateAt: _wire2api_Chrono_Utc(arr[5]),
      fileHash: _wire2api_opt_String(arr[6]),
      versionControl: _wire2api_i64(arr[7]),
    );
  }

  int _wire2api_i64(dynamic raw) {
    return castInt(raw);
  }

  List<FileChangelog> _wire2api_list_file_changelog(dynamic raw) {
    return (raw as List<dynamic>).map(_wire2api_file_changelog).toList();
  }

  List<FileDetails> _wire2api_list_file_details(dynamic raw) {
    return (raw as List<dynamic>).map(_wire2api_file_details).toList();
  }

  List<TodoDetails> _wire2api_list_todo_details(dynamic raw) {
    return (raw as List<dynamic>).map(_wire2api_todo_details).toList();
  }

  List<TodoStatus> _wire2api_list_todo_status(dynamic raw) {
    return (raw as List<dynamic>).map(_wire2api_todo_status).toList();
  }

  String? _wire2api_opt_String(dynamic raw) {
    return raw == null ? null : _wire2api_String(raw);
  }

  CleanerResult? _wire2api_opt_box_autoadd_cleaner_result(dynamic raw) {
    return raw == null ? null : _wire2api_box_autoadd_cleaner_result(raw);
  }

  List<FileChangelog>? _wire2api_opt_list_file_changelog(dynamic raw) {
    return raw == null ? null : _wire2api_list_file_changelog(raw);
  }

  TodoDetails _wire2api_todo_details(dynamic raw) {
    final arr = raw as List<dynamic>;
    if (arr.length != 9)
      throw Exception('unexpected arr length: expect 9 but see ${arr.length}');
    return TodoDetails(
      todoId: _wire2api_i64(arr[0]),
      todoName: _wire2api_opt_String(arr[1]),
      todoContent: _wire2api_opt_String(arr[2]),
      todoStatusName: _wire2api_opt_String(arr[3]),
      todoFrom: _wire2api_opt_String(arr[4]),
      todoTo: _wire2api_opt_String(arr[5]),
      taskName: _wire2api_opt_String(arr[6]),
      taskId: _wire2api_i64(arr[7]),
      todoStatusColor: _wire2api_opt_String(arr[8]),
    );
  }

  TodoStatus _wire2api_todo_status(dynamic raw) {
    final arr = raw as List<dynamic>;
    if (arr.length != 3)
      throw Exception('unexpected arr length: expect 3 but see ${arr.length}');
    return TodoStatus(
      todoStatusId: _wire2api_i64(arr[0]),
      todoStatusName: _wire2api_opt_String(arr[1]),
      todoStatusColor: _wire2api_opt_String(arr[2]),
    );
  }

  int _wire2api_u32(dynamic raw) {
    return raw as int;
  }

  int _wire2api_u8(dynamic raw) {
    return raw as int;
  }

  Uint8List _wire2api_uint_8_list(dynamic raw) {
    return raw as Uint8List;
  }

  void _wire2api_unit(dynamic raw) {
    return;
  }
}

// Section: api2wire

@protected
int api2wire_u8(int raw) {
  return raw;
}

// Section: finalizer

class NativePlatform extends FlutterRustBridgeBase<NativeWire> {
  NativePlatform(ffi.DynamicLibrary dylib) : super(NativeWire(dylib));

// Section: api2wire

  @protected
  ffi.Pointer<wire_uint_8_list> api2wire_String(String raw) {
    return api2wire_uint_8_list(utf8.encoder.convert(raw));
  }

  @protected
  ffi.Pointer<wire_NativeFileNewVersion>
      api2wire_box_autoadd_native_file_new_version(NativeFileNewVersion raw) {
    final ptr = inner.new_box_autoadd_native_file_new_version_0();
    _api_fill_to_wire_native_file_new_version(raw, ptr.ref);
    return ptr;
  }

  @protected
  ffi.Pointer<wire_NativeFileSummary> api2wire_box_autoadd_native_file_summary(
      NativeFileSummary raw) {
    final ptr = inner.new_box_autoadd_native_file_summary_0();
    _api_fill_to_wire_native_file_summary(raw, ptr.ref);
    return ptr;
  }

  @protected
  int api2wire_i64(int raw) {
    return raw;
  }

  @protected
  ffi.Pointer<wire_uint_8_list> api2wire_opt_String(String? raw) {
    return raw == null ? ffi.nullptr : api2wire_String(raw);
  }

  @protected
  ffi.Pointer<wire_uint_8_list> api2wire_uint_8_list(Uint8List raw) {
    final ans = inner.new_uint_8_list_0(raw.length);
    ans.ref.ptr.asTypedList(raw.length).setAll(0, raw);
    return ans;
  }
// Section: finalizer

// Section: api_fill_to_wire

  void _api_fill_to_wire_box_autoadd_native_file_new_version(
      NativeFileNewVersion apiObj,
      ffi.Pointer<wire_NativeFileNewVersion> wireObj) {
    _api_fill_to_wire_native_file_new_version(apiObj, wireObj.ref);
  }

  void _api_fill_to_wire_box_autoadd_native_file_summary(
      NativeFileSummary apiObj, ffi.Pointer<wire_NativeFileSummary> wireObj) {
    _api_fill_to_wire_native_file_summary(apiObj, wireObj.ref);
  }

  void _api_fill_to_wire_native_file_new_version(
      NativeFileNewVersion apiObj, wire_NativeFileNewVersion wireObj) {
    wireObj.prev_file_path = api2wire_String(apiObj.prevFilePath);
    wireObj.prev_file_hash = api2wire_String(apiObj.prevFileHash);
    wireObj.prev_file_name = api2wire_String(apiObj.prevFileName);
    wireObj.new_version_file_path = api2wire_String(apiObj.newVersionFilePath);
    wireObj.new_version_file_hash = api2wire_String(apiObj.newVersionFileHash);
    wireObj.new_version_file_name = api2wire_String(apiObj.newVersionFileName);
    wireObj.diff_path = api2wire_opt_String(apiObj.diffPath);
  }

  void _api_fill_to_wire_native_file_summary(
      NativeFileSummary apiObj, wire_NativeFileSummary wireObj) {
    wireObj.file_name = api2wire_opt_String(apiObj.fileName);
    wireObj.file_path = api2wire_opt_String(apiObj.filePath);
    wireObj.file_hash = api2wire_opt_String(apiObj.fileHash);
    wireObj.version_control = api2wire_i64(apiObj.versionControl);
  }
}

// ignore_for_file: camel_case_types, non_constant_identifier_names, avoid_positional_boolean_parameters, annotate_overrides, constant_identifier_names

// AUTO GENERATED FILE, DO NOT EDIT.
//
// Generated by `package:ffigen`.

/// generated by flutter_rust_bridge
class NativeWire implements FlutterRustBridgeWireBase {
  @internal
  late final dartApi = DartApiDl(init_frb_dart_api_dl);

  /// Holds the symbol lookup function.
  final ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
      _lookup;

  /// The symbols are looked up in [dynamicLibrary].
  NativeWire(ffi.DynamicLibrary dynamicLibrary)
      : _lookup = dynamicLibrary.lookup;

  /// The symbols are looked up with [lookup].
  NativeWire.fromLookup(
      ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
          lookup)
      : _lookup = lookup;

  void store_dart_post_cobject(
    DartPostCObjectFnType ptr,
  ) {
    return _store_dart_post_cobject(
      ptr,
    );
  }

  late final _store_dart_post_cobjectPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(DartPostCObjectFnType)>>(
          'store_dart_post_cobject');
  late final _store_dart_post_cobject = _store_dart_post_cobjectPtr
      .asFunction<void Function(DartPostCObjectFnType)>();

  Object get_dart_object(
    int ptr,
  ) {
    return _get_dart_object(
      ptr,
    );
  }

  late final _get_dart_objectPtr =
      _lookup<ffi.NativeFunction<ffi.Handle Function(uintptr_t)>>(
          'get_dart_object');
  late final _get_dart_object =
      _get_dart_objectPtr.asFunction<Object Function(int)>();

  void drop_dart_object(
    int ptr,
  ) {
    return _drop_dart_object(
      ptr,
    );
  }

  late final _drop_dart_objectPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(uintptr_t)>>(
          'drop_dart_object');
  late final _drop_dart_object =
      _drop_dart_objectPtr.asFunction<void Function(int)>();

  int new_dart_opaque(
    Object handle,
  ) {
    return _new_dart_opaque(
      handle,
    );
  }

  late final _new_dart_opaquePtr =
      _lookup<ffi.NativeFunction<uintptr_t Function(ffi.Handle)>>(
          'new_dart_opaque');
  late final _new_dart_opaque =
      _new_dart_opaquePtr.asFunction<int Function(Object)>();

  int init_frb_dart_api_dl(
    ffi.Pointer<ffi.Void> obj,
  ) {
    return _init_frb_dart_api_dl(
      obj,
    );
  }

  late final _init_frb_dart_api_dlPtr =
      _lookup<ffi.NativeFunction<ffi.IntPtr Function(ffi.Pointer<ffi.Void>)>>(
          'init_frb_dart_api_dl');
  late final _init_frb_dart_api_dl = _init_frb_dart_api_dlPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  void wire_create_all_directory(
    int port_,
    ffi.Pointer<wire_uint_8_list> s,
  ) {
    return _wire_create_all_directory(
      port_,
      s,
    );
  }

  late final _wire_create_all_directoryPtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(ffi.Int64,
              ffi.Pointer<wire_uint_8_list>)>>('wire_create_all_directory');
  late final _wire_create_all_directory = _wire_create_all_directoryPtr
      .asFunction<void Function(int, ffi.Pointer<wire_uint_8_list>)>();

  void wire_get_changelog_from_id(
    int port_,
    int id,
    ffi.Pointer<wire_uint_8_list> file_hash,
  ) {
    return _wire_get_changelog_from_id(
      port_,
      id,
      file_hash,
    );
  }

  late final _wire_get_changelog_from_idPtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(ffi.Int64, ffi.Int64,
              ffi.Pointer<wire_uint_8_list>)>>('wire_get_changelog_from_id');
  late final _wire_get_changelog_from_id = _wire_get_changelog_from_idPtr
      .asFunction<void Function(int, int, ffi.Pointer<wire_uint_8_list>)>();

  void wire_get_file_hash(
    int port_,
    ffi.Pointer<wire_uint_8_list> file_path,
  ) {
    return _wire_get_file_hash(
      port_,
      file_path,
    );
  }

  late final _wire_get_file_hashPtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(
              ffi.Int64, ffi.Pointer<wire_uint_8_list>)>>('wire_get_file_hash');
  late final _wire_get_file_hash = _wire_get_file_hashPtr
      .asFunction<void Function(int, ffi.Pointer<wire_uint_8_list>)>();

  void wire_delete_file_by_file_hash(
    int port_,
    ffi.Pointer<wire_uint_8_list> file_hash,
  ) {
    return _wire_delete_file_by_file_hash(
      port_,
      file_hash,
    );
  }

  late final _wire_delete_file_by_file_hashPtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(ffi.Int64,
              ffi.Pointer<wire_uint_8_list>)>>('wire_delete_file_by_file_hash');
  late final _wire_delete_file_by_file_hash = _wire_delete_file_by_file_hashPtr
      .asFunction<void Function(int, ffi.Pointer<wire_uint_8_list>)>();

  void wire_change_version_control(
    int port_,
    ffi.Pointer<wire_uint_8_list> file_hash,
  ) {
    return _wire_change_version_control(
      port_,
      file_hash,
    );
  }

  late final _wire_change_version_controlPtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(ffi.Int64,
              ffi.Pointer<wire_uint_8_list>)>>('wire_change_version_control');
  late final _wire_change_version_control = _wire_change_version_controlPtr
      .asFunction<void Function(int, ffi.Pointer<wire_uint_8_list>)>();

  void wire_create_new_version(
    int port_,
    ffi.Pointer<wire_NativeFileNewVersion> model,
  ) {
    return _wire_create_new_version(
      port_,
      model,
    );
  }

  late final _wire_create_new_versionPtr = _lookup<
          ffi.NativeFunction<
              ffi.Void Function(
                  ffi.Int64, ffi.Pointer<wire_NativeFileNewVersion>)>>(
      'wire_create_new_version');
  late final _wire_create_new_version = _wire_create_new_versionPtr
      .asFunction<void Function(int, ffi.Pointer<wire_NativeFileNewVersion>)>();

  void wire_create_new_disk_file(
    int port_,
    ffi.Pointer<wire_uint_8_list> file_path,
  ) {
    return _wire_create_new_disk_file(
      port_,
      file_path,
    );
  }

  late final _wire_create_new_disk_filePtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(ffi.Int64,
              ffi.Pointer<wire_uint_8_list>)>>('wire_create_new_disk_file');
  late final _wire_create_new_disk_file = _wire_create_new_disk_filePtr
      .asFunction<void Function(int, ffi.Pointer<wire_uint_8_list>)>();

  void wire_get_file_logs(
    int port_,
    ffi.Pointer<wire_uint_8_list> file_hash,
  ) {
    return _wire_get_file_logs(
      port_,
      file_hash,
    );
  }

  late final _wire_get_file_logsPtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(
              ffi.Int64, ffi.Pointer<wire_uint_8_list>)>>('wire_get_file_logs');
  late final _wire_get_file_logs = _wire_get_file_logsPtr
      .asFunction<void Function(int, ffi.Pointer<wire_uint_8_list>)>();

  void wire_change_file_hash_by_id(
    int port_,
    ffi.Pointer<wire_uint_8_list> ori_file_path,
    ffi.Pointer<wire_uint_8_list> file_path,
    int file_id,
    ffi.Pointer<wire_uint_8_list> diff_path,
  ) {
    return _wire_change_file_hash_by_id(
      port_,
      ori_file_path,
      file_path,
      file_id,
      diff_path,
    );
  }

  late final _wire_change_file_hash_by_idPtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(
              ffi.Int64,
              ffi.Pointer<wire_uint_8_list>,
              ffi.Pointer<wire_uint_8_list>,
              ffi.Int64,
              ffi.Pointer<wire_uint_8_list>)>>('wire_change_file_hash_by_id');
  late final _wire_change_file_hash_by_id =
      _wire_change_file_hash_by_idPtr.asFunction<
          void Function(
              int,
              ffi.Pointer<wire_uint_8_list>,
              ffi.Pointer<wire_uint_8_list>,
              int,
              ffi.Pointer<wire_uint_8_list>)>();

  void wire_init_mysql(
    int port_,
    ffi.Pointer<wire_uint_8_list> conf_path,
  ) {
    return _wire_init_mysql(
      port_,
      conf_path,
    );
  }

  late final _wire_init_mysqlPtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(
              ffi.Int64, ffi.Pointer<wire_uint_8_list>)>>('wire_init_mysql');
  late final _wire_init_mysql = _wire_init_mysqlPtr
      .asFunction<void Function(int, ffi.Pointer<wire_uint_8_list>)>();

  void wire_get_status_types(
    int port_,
  ) {
    return _wire_get_status_types(
      port_,
    );
  }

  late final _wire_get_status_typesPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Int64)>>(
          'wire_get_status_types');
  late final _wire_get_status_types =
      _wire_get_status_typesPtr.asFunction<void Function(int)>();

  void wire_get_todos(
    int port_,
  ) {
    return _wire_get_todos(
      port_,
    );
  }

  late final _wire_get_todosPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Int64)>>(
          'wire_get_todos');
  late final _wire_get_todos =
      _wire_get_todosPtr.asFunction<void Function(int)>();

  void wire_get_files(
    int port_,
  ) {
    return _wire_get_files(
      port_,
    );
  }

  late final _wire_get_filesPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Int64)>>(
          'wire_get_files');
  late final _wire_get_files =
      _wire_get_filesPtr.asFunction<void Function(int)>();

  void wire_new_file(
    int port_,
    ffi.Pointer<wire_NativeFileSummary> f,
  ) {
    return _wire_new_file(
      port_,
      f,
    );
  }

  late final _wire_new_filePtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(ffi.Int64,
              ffi.Pointer<wire_NativeFileSummary>)>>('wire_new_file');
  late final _wire_new_file = _wire_new_filePtr
      .asFunction<void Function(int, ffi.Pointer<wire_NativeFileSummary>)>();

  void wire_clean_svg_file(
    int port_,
    ffi.Pointer<wire_uint_8_list> file_path,
  ) {
    return _wire_clean_svg_file(
      port_,
      file_path,
    );
  }

  late final _wire_clean_svg_filePtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(ffi.Int64,
              ffi.Pointer<wire_uint_8_list>)>>('wire_clean_svg_file');
  late final _wire_clean_svg_file = _wire_clean_svg_filePtr
      .asFunction<void Function(int, ffi.Pointer<wire_uint_8_list>)>();

  void wire_clean_svg_string(
    int port_,
    ffi.Pointer<wire_uint_8_list> content,
  ) {
    return _wire_clean_svg_string(
      port_,
      content,
    );
  }

  late final _wire_clean_svg_stringPtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(ffi.Int64,
              ffi.Pointer<wire_uint_8_list>)>>('wire_clean_svg_string');
  late final _wire_clean_svg_string = _wire_clean_svg_stringPtr
      .asFunction<void Function(int, ffi.Pointer<wire_uint_8_list>)>();

  ffi.Pointer<wire_NativeFileNewVersion>
      new_box_autoadd_native_file_new_version_0() {
    return _new_box_autoadd_native_file_new_version_0();
  }

  late final _new_box_autoadd_native_file_new_version_0Ptr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<wire_NativeFileNewVersion>
              Function()>>('new_box_autoadd_native_file_new_version_0');
  late final _new_box_autoadd_native_file_new_version_0 =
      _new_box_autoadd_native_file_new_version_0Ptr
          .asFunction<ffi.Pointer<wire_NativeFileNewVersion> Function()>();

  ffi.Pointer<wire_NativeFileSummary> new_box_autoadd_native_file_summary_0() {
    return _new_box_autoadd_native_file_summary_0();
  }

  late final _new_box_autoadd_native_file_summary_0Ptr = _lookup<
          ffi.NativeFunction<ffi.Pointer<wire_NativeFileSummary> Function()>>(
      'new_box_autoadd_native_file_summary_0');
  late final _new_box_autoadd_native_file_summary_0 =
      _new_box_autoadd_native_file_summary_0Ptr
          .asFunction<ffi.Pointer<wire_NativeFileSummary> Function()>();

  ffi.Pointer<wire_uint_8_list> new_uint_8_list_0(
    int len,
  ) {
    return _new_uint_8_list_0(
      len,
    );
  }

  late final _new_uint_8_list_0Ptr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<wire_uint_8_list> Function(
              ffi.Int32)>>('new_uint_8_list_0');
  late final _new_uint_8_list_0 = _new_uint_8_list_0Ptr
      .asFunction<ffi.Pointer<wire_uint_8_list> Function(int)>();

  void free_WireSyncReturn(
    WireSyncReturn ptr,
  ) {
    return _free_WireSyncReturn(
      ptr,
    );
  }

  late final _free_WireSyncReturnPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(WireSyncReturn)>>(
          'free_WireSyncReturn');
  late final _free_WireSyncReturn =
      _free_WireSyncReturnPtr.asFunction<void Function(WireSyncReturn)>();
}

class _Dart_Handle extends ffi.Opaque {}

class wire_uint_8_list extends ffi.Struct {
  external ffi.Pointer<ffi.Uint8> ptr;

  @ffi.Int32()
  external int len;
}

class wire_NativeFileNewVersion extends ffi.Struct {
  external ffi.Pointer<wire_uint_8_list> prev_file_path;

  external ffi.Pointer<wire_uint_8_list> prev_file_hash;

  external ffi.Pointer<wire_uint_8_list> prev_file_name;

  external ffi.Pointer<wire_uint_8_list> new_version_file_path;

  external ffi.Pointer<wire_uint_8_list> new_version_file_hash;

  external ffi.Pointer<wire_uint_8_list> new_version_file_name;

  external ffi.Pointer<wire_uint_8_list> diff_path;
}

class wire_NativeFileSummary extends ffi.Struct {
  external ffi.Pointer<wire_uint_8_list> file_name;

  external ffi.Pointer<wire_uint_8_list> file_path;

  external ffi.Pointer<wire_uint_8_list> file_hash;

  @ffi.Int64()
  external int version_control;
}

typedef DartPostCObjectFnType = ffi.Pointer<
    ffi.NativeFunction<ffi.Bool Function(DartPort, ffi.Pointer<ffi.Void>)>>;
typedef DartPort = ffi.Int64;
typedef uintptr_t = ffi.UnsignedLongLong;
