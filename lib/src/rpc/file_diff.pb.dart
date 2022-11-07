///
//  Generated code. Do not modify.
//  source: file_diff.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class GenerateDiffRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GenerateDiffRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'file_changelog'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'before')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'after')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'savePath', protoName: 'savePath')
    ..hasRequiredFields = false
  ;

  GenerateDiffRequest._() : super();
  factory GenerateDiffRequest({
    $core.String? before,
    $core.String? after,
    $core.String? savePath,
  }) {
    final _result = create();
    if (before != null) {
      _result.before = before;
    }
    if (after != null) {
      _result.after = after;
    }
    if (savePath != null) {
      _result.savePath = savePath;
    }
    return _result;
  }
  factory GenerateDiffRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GenerateDiffRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GenerateDiffRequest clone() => GenerateDiffRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GenerateDiffRequest copyWith(void Function(GenerateDiffRequest) updates) => super.copyWith((message) => updates(message as GenerateDiffRequest)) as GenerateDiffRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GenerateDiffRequest create() => GenerateDiffRequest._();
  GenerateDiffRequest createEmptyInstance() => create();
  static $pb.PbList<GenerateDiffRequest> createRepeated() => $pb.PbList<GenerateDiffRequest>();
  @$core.pragma('dart2js:noInline')
  static GenerateDiffRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GenerateDiffRequest>(create);
  static GenerateDiffRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get before => $_getSZ(0);
  @$pb.TagNumber(1)
  set before($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBefore() => $_has(0);
  @$pb.TagNumber(1)
  void clearBefore() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get after => $_getSZ(1);
  @$pb.TagNumber(2)
  set after($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAfter() => $_has(1);
  @$pb.TagNumber(2)
  void clearAfter() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get savePath => $_getSZ(2);
  @$pb.TagNumber(3)
  set savePath($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSavePath() => $_has(2);
  @$pb.TagNumber(3)
  void clearSavePath() => clearField(3);
}

class GenerateDiffResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GenerateDiffResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'file_changelog'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GenerateDiffResponse._() : super();
  factory GenerateDiffResponse({
    $core.int? message,
  }) {
    final _result = create();
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory GenerateDiffResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GenerateDiffResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GenerateDiffResponse clone() => GenerateDiffResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GenerateDiffResponse copyWith(void Function(GenerateDiffResponse) updates) => super.copyWith((message) => updates(message as GenerateDiffResponse)) as GenerateDiffResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GenerateDiffResponse create() => GenerateDiffResponse._();
  GenerateDiffResponse createEmptyInstance() => create();
  static $pb.PbList<GenerateDiffResponse> createRepeated() => $pb.PbList<GenerateDiffResponse>();
  @$core.pragma('dart2js:noInline')
  static GenerateDiffResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GenerateDiffResponse>(create);
  static GenerateDiffResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get message => $_getIZ(0);
  @$pb.TagNumber(1)
  set message($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);
}

