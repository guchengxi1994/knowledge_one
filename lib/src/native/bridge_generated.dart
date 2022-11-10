// AUTO GENERATED FILE, DO NOT EDIT.
// Generated by `flutter_rust_bridge`@ 1.49.0.
// ignore_for_file: non_constant_identifier_names, unused_element, duplicate_ignore, directives_ordering, curly_braces_in_flow_control_structures, unnecessary_lambdas, slash_for_doc_comments, prefer_const_literals_to_create_immutables, implicit_dynamic_list_literal, duplicate_import, unused_import, prefer_single_quotes, prefer_const_constructors, use_super_parameters, always_use_package_imports, annotate_overrides, invalid_use_of_protected_member, constant_identifier_names

import "bridge_definitions.dart";
import 'dart:convert';
import 'dart:async';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'bridge_generated.io.dart' if (dart.library.html) 'bridge_generated.web.dart';
import 'package:meta/meta.dart';

class NativeImpl implements Native {
  final NativePlatform _platform;
  factory NativeImpl(ExternalLibrary dylib) => NativeImpl.raw(NativePlatform(dylib));

  /// Only valid on web/WASM platforms.
  factory NativeImpl.wasm(FutureOr<WasmModule> module) => NativeImpl(module as ExternalLibrary);
  NativeImpl.raw(this._platform);
  Future<int> createStorageDirectory({required String s, dynamic hint}) => _platform.executeNormal(FlutterRustBridgeTask(
        callFfi: (port_) => _platform.inner.wire_create_storage_directory(port_, _platform.api2wire_String(s)),
        parseSuccessData: _wire2api_i32,
        constMeta: kCreateStorageDirectoryConstMeta,
        argValues: [
          s
        ],
        hint: hint,
      ));

  FlutterRustBridgeTaskConstMeta get kCreateStorageDirectoryConstMeta => const FlutterRustBridgeTaskConstMeta(
        debugName: "create_storage_directory",
        argNames: [
          "s"
        ],
      );

  Future<int> createDiffDirectory({required String s, dynamic hint}) => _platform.executeNormal(FlutterRustBridgeTask(
        callFfi: (port_) => _platform.inner.wire_create_diff_directory(port_, _platform.api2wire_String(s)),
        parseSuccessData: _wire2api_i32,
        constMeta: kCreateDiffDirectoryConstMeta,
        argValues: [
          s
        ],
        hint: hint,
      ));

  FlutterRustBridgeTaskConstMeta get kCreateDiffDirectoryConstMeta => const FlutterRustBridgeTaskConstMeta(
        debugName: "create_diff_directory",
        argNames: [
          "s"
        ],
      );

  Future<String> getFileHash({required String filePath, dynamic hint}) => _platform.executeNormal(FlutterRustBridgeTask(
        callFfi: (port_) => _platform.inner.wire_get_file_hash(port_, _platform.api2wire_String(filePath)),
        parseSuccessData: _wire2api_String,
        constMeta: kGetFileHashConstMeta,
        argValues: [
          filePath
        ],
        hint: hint,
      ));

  FlutterRustBridgeTaskConstMeta get kGetFileHashConstMeta => const FlutterRustBridgeTaskConstMeta(
        debugName: "get_file_hash",
        argNames: [
          "filePath"
        ],
      );

  Future<int> deleteFileByFileHash({required String fileHash, dynamic hint}) => _platform.executeNormal(FlutterRustBridgeTask(
        callFfi: (port_) => _platform.inner.wire_delete_file_by_file_hash(port_, _platform.api2wire_String(fileHash)),
        parseSuccessData: _wire2api_i64,
        constMeta: kDeleteFileByFileHashConstMeta,
        argValues: [
          fileHash
        ],
        hint: hint,
      ));

  FlutterRustBridgeTaskConstMeta get kDeleteFileByFileHashConstMeta => const FlutterRustBridgeTaskConstMeta(
        debugName: "delete_file_by_file_hash",
        argNames: [
          "fileHash"
        ],
      );

  Future<int> changeVersionControl({required String fileHash, dynamic hint}) => _platform.executeNormal(FlutterRustBridgeTask(
        callFfi: (port_) => _platform.inner.wire_change_version_control(port_, _platform.api2wire_String(fileHash)),
        parseSuccessData: _wire2api_i64,
        constMeta: kChangeVersionControlConstMeta,
        argValues: [
          fileHash
        ],
        hint: hint,
      ));

  FlutterRustBridgeTaskConstMeta get kChangeVersionControlConstMeta => const FlutterRustBridgeTaskConstMeta(
        debugName: "change_version_control",
        argNames: [
          "fileHash"
        ],
      );

  Future<int> createNewVersion({required NativeFileNewVersion model, dynamic hint}) => _platform.executeNormal(FlutterRustBridgeTask(
        callFfi: (port_) => _platform.inner.wire_create_new_version(port_, _platform.api2wire_box_autoadd_native_file_new_version(model)),
        parseSuccessData: _wire2api_i64,
        constMeta: kCreateNewVersionConstMeta,
        argValues: [
          model
        ],
        hint: hint,
      ));

  FlutterRustBridgeTaskConstMeta get kCreateNewVersionConstMeta => const FlutterRustBridgeTaskConstMeta(
        debugName: "create_new_version",
        argNames: [
          "model"
        ],
      );

  Future<List<FileChangelog>?> getFileLogs({required String fileHash, dynamic hint}) => _platform.executeNormal(FlutterRustBridgeTask(
        callFfi: (port_) => _platform.inner.wire_get_file_logs(port_, _platform.api2wire_String(fileHash)),
        parseSuccessData: _wire2api_opt_list_file_changelog,
        constMeta: kGetFileLogsConstMeta,
        argValues: [
          fileHash
        ],
        hint: hint,
      ));

  FlutterRustBridgeTaskConstMeta get kGetFileLogsConstMeta => const FlutterRustBridgeTaskConstMeta(
        debugName: "get_file_logs",
        argNames: [
          "fileHash"
        ],
      );

  Future<void> initMysql({required String confPath, dynamic hint}) => _platform.executeNormal(FlutterRustBridgeTask(
        callFfi: (port_) => _platform.inner.wire_init_mysql(port_, _platform.api2wire_String(confPath)),
        parseSuccessData: _wire2api_unit,
        constMeta: kInitMysqlConstMeta,
        argValues: [
          confPath
        ],
        hint: hint,
      ));

  FlutterRustBridgeTaskConstMeta get kInitMysqlConstMeta => const FlutterRustBridgeTaskConstMeta(
        debugName: "init_mysql",
        argNames: [
          "confPath"
        ],
      );

  Future<List<TodoStatus>> getStatusTypes({dynamic hint}) => _platform.executeNormal(FlutterRustBridgeTask(
        callFfi: (port_) => _platform.inner.wire_get_status_types(port_),
        parseSuccessData: _wire2api_list_todo_status,
        constMeta: kGetStatusTypesConstMeta,
        argValues: [],
        hint: hint,
      ));

  FlutterRustBridgeTaskConstMeta get kGetStatusTypesConstMeta => const FlutterRustBridgeTaskConstMeta(
        debugName: "get_status_types",
        argNames: [],
      );

  Future<List<TodoDetails>> getTodos({dynamic hint}) => _platform.executeNormal(FlutterRustBridgeTask(
        callFfi: (port_) => _platform.inner.wire_get_todos(port_),
        parseSuccessData: _wire2api_list_todo_details,
        constMeta: kGetTodosConstMeta,
        argValues: [],
        hint: hint,
      ));

  FlutterRustBridgeTaskConstMeta get kGetTodosConstMeta => const FlutterRustBridgeTaskConstMeta(
        debugName: "get_todos",
        argNames: [],
      );

  Future<List<FileDetails>> getFiles({dynamic hint}) => _platform.executeNormal(FlutterRustBridgeTask(
        callFfi: (port_) => _platform.inner.wire_get_files(port_),
        parseSuccessData: _wire2api_list_file_details,
        constMeta: kGetFilesConstMeta,
        argValues: [],
        hint: hint,
      ));

  FlutterRustBridgeTaskConstMeta get kGetFilesConstMeta => const FlutterRustBridgeTaskConstMeta(
        debugName: "get_files",
        argNames: [],
      );

  Future<int> newFile({required NativeFileSummary f, dynamic hint}) => _platform.executeNormal(FlutterRustBridgeTask(
        callFfi: (port_) => _platform.inner.wire_new_file(port_, _platform.api2wire_box_autoadd_native_file_summary(f)),
        parseSuccessData: _wire2api_i64,
        constMeta: kNewFileConstMeta,
        argValues: [
          f
        ],
        hint: hint,
      ));

  FlutterRustBridgeTaskConstMeta get kNewFileConstMeta => const FlutterRustBridgeTaskConstMeta(
        debugName: "new_file",
        argNames: [
          "f"
        ],
      );

// Section: wire2api

  DateTime _wire2api_Chrono_Utc(dynamic raw) {
    return wire2apiTimestamp(ts: _wire2api_i64(raw), isUtc: true);
  }

  String _wire2api_String(dynamic raw) {
    return raw as String;
  }

  FileChangelog _wire2api_file_changelog(dynamic raw) {
    final arr = raw as List<dynamic>;
    if (arr.length != 10) throw Exception('unexpected arr length: expect 10 but see ${arr.length}');
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
    if (arr.length != 8) throw Exception('unexpected arr length: expect 8 but see ${arr.length}');
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

  int _wire2api_i32(dynamic raw) {
    return raw as int;
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

  List<FileChangelog>? _wire2api_opt_list_file_changelog(dynamic raw) {
    return raw == null ? null : _wire2api_list_file_changelog(raw);
  }

  TodoDetails _wire2api_todo_details(dynamic raw) {
    final arr = raw as List<dynamic>;
    if (arr.length != 9) throw Exception('unexpected arr length: expect 9 but see ${arr.length}');
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
    if (arr.length != 3) throw Exception('unexpected arr length: expect 3 but see ${arr.length}');
    return TodoStatus(
      todoStatusId: _wire2api_i64(arr[0]),
      todoStatusName: _wire2api_opt_String(arr[1]),
      todoStatusColor: _wire2api_opt_String(arr[2]),
    );
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
