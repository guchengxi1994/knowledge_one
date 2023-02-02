///
//  Generated code. Do not modify.
//  source: file_diff.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'file_diff.pb.dart' as $0;
export 'file_diff.pb.dart';

class FileDiffClient extends $grpc.Client {
  static final _$generateDiff =
      $grpc.ClientMethod<$0.GenerateDiffRequest, $0.GenerateDiffResponse>(
          '/file_changelog.FileDiff/GenerateDiff',
          ($0.GenerateDiffRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GenerateDiffResponse.fromBuffer(value));

  FileDiffClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.GenerateDiffResponse> generateDiff(
      $0.GenerateDiffRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateDiff, request, options: options);
  }
}

abstract class FileDiffServiceBase extends $grpc.Service {
  $core.String get $name => 'file_changelog.FileDiff';

  FileDiffServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$0.GenerateDiffRequest, $0.GenerateDiffResponse>(
            'GenerateDiff',
            generateDiff_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GenerateDiffRequest.fromBuffer(value),
            ($0.GenerateDiffResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GenerateDiffResponse> generateDiff_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GenerateDiffRequest> request) async {
    return generateDiff(call, await request);
  }

  $async.Future<$0.GenerateDiffResponse> generateDiff(
      $grpc.ServiceCall call, $0.GenerateDiffRequest request);
}
