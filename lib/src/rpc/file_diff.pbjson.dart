///
//  Generated code. Do not modify.
//  source: file_diff.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use generateDiffRequestDescriptor instead')
const GenerateDiffRequest$json = const {
  '1': 'GenerateDiffRequest',
  '2': const [
    const {'1': 'before', '3': 1, '4': 1, '5': 9, '10': 'before'},
    const {'1': 'after', '3': 2, '4': 1, '5': 9, '10': 'after'},
    const {'1': 'savePath', '3': 3, '4': 1, '5': 9, '10': 'savePath'},
  ],
};

/// Descriptor for `GenerateDiffRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateDiffRequestDescriptor = $convert.base64Decode('ChNHZW5lcmF0ZURpZmZSZXF1ZXN0EhYKBmJlZm9yZRgBIAEoCVIGYmVmb3JlEhQKBWFmdGVyGAIgASgJUgVhZnRlchIaCghzYXZlUGF0aBgDIAEoCVIIc2F2ZVBhdGg=');
@$core.Deprecated('Use generateDiffResponseDescriptor instead')
const GenerateDiffResponse$json = const {
  '1': 'GenerateDiffResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 5, '10': 'message'},
  ],
};

/// Descriptor for `GenerateDiffResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateDiffResponseDescriptor = $convert.base64Decode('ChRHZW5lcmF0ZURpZmZSZXNwb25zZRIYCgdtZXNzYWdlGAEgASgFUgdtZXNzYWdl');
