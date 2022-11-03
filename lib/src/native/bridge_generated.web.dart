// AUTO GENERATED FILE, DO NOT EDIT.
// Generated by `flutter_rust_bridge`@ 1.49.0.
// ignore_for_file: non_constant_identifier_names, unused_element, duplicate_ignore, directives_ordering, curly_braces_in_flow_control_structures, unnecessary_lambdas, slash_for_doc_comments, prefer_const_literals_to_create_immutables, implicit_dynamic_list_literal, duplicate_import, unused_import, prefer_single_quotes, prefer_const_constructors, use_super_parameters, always_use_package_imports, annotate_overrides, invalid_use_of_protected_member, constant_identifier_names

import "bridge_definitions.dart";
import 'dart:convert';
import 'dart:async';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'bridge_generated.dart';
export 'bridge_generated.dart';
import 'package:meta/meta.dart';

class NativePlatform extends FlutterRustBridgeBase<NativeWire> with FlutterRustBridgeSetupMixin {
  NativePlatform(FutureOr<WasmModule> dylib) : super(NativeWire(dylib)) {
    setupMixinConstructor();
  }
  Future<void> setup() => inner.init;
// Section: api2wire

  @protected
  String api2wire_String(String raw) {
    return raw;
  }

  @protected
  Uint8List api2wire_uint_8_list(Uint8List raw) {
    return raw;
  }
}

// Section: WASM wire module

@JS('wasm_bindgen')
external NativeWasmModule get wasmModule;

@JS()
@anonymous
class NativeWasmModule implements WasmModule {
  external Object /* Promise */ call([String? moduleName]);
  external NativeWasmModule bind(dynamic thisArg, String moduleName);
  external void wire_main(NativePortType port_);

  external void wire_get_counter(NativePortType port_);

  external void wire_increment(NativePortType port_);

  external void wire_decrement(NativePortType port_);

  external void wire_create_storage_directory(NativePortType port_, String s);

  external void wire_init_mysql(NativePortType port_, String conf_path);

  external void wire_get_status_types(NativePortType port_);

  external void wire_get_todos(NativePortType port_);
}

// Section: WASM wire connector

class NativeWire extends FlutterRustBridgeWasmWireBase<NativeWasmModule> {
  NativeWire(FutureOr<WasmModule> module) : super(WasmModule.cast<NativeWasmModule>(module));

  void wire_main(NativePortType port_) => wasmModule.wire_main(port_);

  void wire_get_counter(NativePortType port_) => wasmModule.wire_get_counter(port_);

  void wire_increment(NativePortType port_) => wasmModule.wire_increment(port_);

  void wire_decrement(NativePortType port_) => wasmModule.wire_decrement(port_);

  void wire_create_storage_directory(NativePortType port_, String s) => wasmModule.wire_create_storage_directory(port_, s);

  void wire_init_mysql(NativePortType port_, String conf_path) => wasmModule.wire_init_mysql(port_, conf_path);

  void wire_get_status_types(NativePortType port_) => wasmModule.wire_get_status_types(port_);

  void wire_get_todos(NativePortType port_) => wasmModule.wire_get_todos(port_);
}
