///
//  Generated code. Do not modify.
//  source: quicktype.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class QuicktypeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'QuicktypeRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'quicktype'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'langType', protoName: 'langType')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'structName', protoName: 'structName')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'content')
    ..hasRequiredFields = false
  ;

  QuicktypeRequest._() : super();
  factory QuicktypeRequest({
    $core.String? langType,
    $core.String? structName,
    $core.String? content,
  }) {
    final _result = create();
    if (langType != null) {
      _result.langType = langType;
    }
    if (structName != null) {
      _result.structName = structName;
    }
    if (content != null) {
      _result.content = content;
    }
    return _result;
  }
  factory QuicktypeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory QuicktypeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  QuicktypeRequest clone() => QuicktypeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  QuicktypeRequest copyWith(void Function(QuicktypeRequest) updates) => super.copyWith((message) => updates(message as QuicktypeRequest)) as QuicktypeRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static QuicktypeRequest create() => QuicktypeRequest._();
  QuicktypeRequest createEmptyInstance() => create();
  static $pb.PbList<QuicktypeRequest> createRepeated() => $pb.PbList<QuicktypeRequest>();
  @$core.pragma('dart2js:noInline')
  static QuicktypeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<QuicktypeRequest>(create);
  static QuicktypeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get langType => $_getSZ(0);
  @$pb.TagNumber(1)
  set langType($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLangType() => $_has(0);
  @$pb.TagNumber(1)
  void clearLangType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get structName => $_getSZ(1);
  @$pb.TagNumber(2)
  set structName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStructName() => $_has(1);
  @$pb.TagNumber(2)
  void clearStructName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get content => $_getSZ(2);
  @$pb.TagNumber(3)
  set content($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasContent() => $_has(2);
  @$pb.TagNumber(3)
  void clearContent() => clearField(3);
}

class QuicktypeResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'QuicktypeResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'quicktype'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'result')
    ..hasRequiredFields = false
  ;

  QuicktypeResponse._() : super();
  factory QuicktypeResponse({
    $core.String? result,
  }) {
    final _result = create();
    if (result != null) {
      _result.result = result;
    }
    return _result;
  }
  factory QuicktypeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory QuicktypeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  QuicktypeResponse clone() => QuicktypeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  QuicktypeResponse copyWith(void Function(QuicktypeResponse) updates) => super.copyWith((message) => updates(message as QuicktypeResponse)) as QuicktypeResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static QuicktypeResponse create() => QuicktypeResponse._();
  QuicktypeResponse createEmptyInstance() => create();
  static $pb.PbList<QuicktypeResponse> createRepeated() => $pb.PbList<QuicktypeResponse>();
  @$core.pragma('dart2js:noInline')
  static QuicktypeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<QuicktypeResponse>(create);
  static QuicktypeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get result => $_getSZ(0);
  @$pb.TagNumber(1)
  set result($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);
}

