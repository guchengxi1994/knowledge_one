///
//  Generated code. Do not modify.
//  source: faker.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use quickFakeRequestDescriptor instead')
const QuickFakeRequest$json = const {
  '1': 'QuickFakeRequest',
  '2': const [
    const {'1': 'locale', '3': 1, '4': 1, '5': 9, '10': 'locale'},
    const {'1': 'provider', '3': 2, '4': 1, '5': 9, '10': 'provider'},
  ],
};

/// Descriptor for `QuickFakeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List quickFakeRequestDescriptor = $convert.base64Decode('ChBRdWlja0Zha2VSZXF1ZXN0EhYKBmxvY2FsZRgBIAEoCVIGbG9jYWxlEhoKCHByb3ZpZGVyGAIgASgJUghwcm92aWRlcg==');
@$core.Deprecated('Use quickFakeResponseDescriptor instead')
const QuickFakeResponse$json = const {
  '1': 'QuickFakeResponse',
  '2': const [
    const {'1': 'result', '3': 1, '4': 1, '5': 9, '10': 'result'},
  ],
};

/// Descriptor for `QuickFakeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List quickFakeResponseDescriptor = $convert.base64Decode('ChFRdWlja0Zha2VSZXNwb25zZRIWCgZyZXN1bHQYASABKAlSBnJlc3VsdA==');
@$core.Deprecated('Use providerMapDescriptor instead')
const ProviderMap$json = const {
  '1': 'ProviderMap',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
};

/// Descriptor for `ProviderMap`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List providerMapDescriptor = $convert.base64Decode('CgtQcm92aWRlck1hcBIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU=');
@$core.Deprecated('Use batchFakeRequestDescriptor instead')
const BatchFakeRequest$json = const {
  '1': 'BatchFakeRequest',
  '2': const [
    const {'1': 'locale', '3': 1, '4': 1, '5': 9, '10': 'locale'},
    const {'1': 'count', '3': 2, '4': 1, '5': 3, '10': 'count'},
    const {'1': 'providerMaps', '3': 3, '4': 3, '5': 11, '6': '.faker.ProviderMap', '10': 'providerMaps'},
  ],
};

/// Descriptor for `BatchFakeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchFakeRequestDescriptor = $convert.base64Decode('ChBCYXRjaEZha2VSZXF1ZXN0EhYKBmxvY2FsZRgBIAEoCVIGbG9jYWxlEhQKBWNvdW50GAIgASgDUgVjb3VudBI2Cgxwcm92aWRlck1hcHMYAyADKAsyEi5mYWtlci5Qcm92aWRlck1hcFIMcHJvdmlkZXJNYXBz');
@$core.Deprecated('Use batchFakeResponseDescriptor instead')
const BatchFakeResponse$json = const {
  '1': 'BatchFakeResponse',
  '2': const [
    const {'1': 'result', '3': 1, '4': 1, '5': 9, '10': 'result'},
  ],
};

/// Descriptor for `BatchFakeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchFakeResponseDescriptor = $convert.base64Decode('ChFCYXRjaEZha2VSZXNwb25zZRIWCgZyZXN1bHQYASABKAlSBnJlc3VsdA==');
