///
//  Generated code. Do not modify.
//  source: file_restore.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use restoreRequestDescriptor instead')
const RestoreRequest$json = const {
  '1': 'RestoreRequest',
  '2': const [
    const {'1': 'filePath', '3': 1, '4': 1, '5': 9, '10': 'filePath'},
    const {'1': 'diffs', '3': 2, '4': 3, '5': 9, '10': 'diffs'},
    const {'1': 'fileSize', '3': 3, '4': 3, '5': 3, '10': 'fileSize'},
    const {'1': 'saveDir', '3': 4, '4': 1, '5': 9, '10': 'saveDir'},
  ],
};

/// Descriptor for `RestoreRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List restoreRequestDescriptor = $convert.base64Decode('Cg5SZXN0b3JlUmVxdWVzdBIaCghmaWxlUGF0aBgBIAEoCVIIZmlsZVBhdGgSFAoFZGlmZnMYAiADKAlSBWRpZmZzEhoKCGZpbGVTaXplGAMgAygDUghmaWxlU2l6ZRIYCgdzYXZlRGlyGAQgASgJUgdzYXZlRGly');
@$core.Deprecated('Use restoreResponseDescriptor instead')
const RestoreResponse$json = const {
  '1': 'RestoreResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `RestoreResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List restoreResponseDescriptor = $convert.base64Decode('Cg9SZXN0b3JlUmVzcG9uc2USGAoHbWVzc2FnZRgBIAEoCVIHbWVzc2FnZQ==');
