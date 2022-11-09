///
//  Generated code. Do not modify.
//  source: file_restore.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'file_restore.pb.dart' as $0;
export 'file_restore.pb.dart';

class FileRestoreClient extends $grpc.Client {
  static final _$restore =
      $grpc.ClientMethod<$0.RestoreRequest, $0.RestoreResponse>(
          '/file_changelog.FileRestore/Restore',
          ($0.RestoreRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.RestoreResponse.fromBuffer(value));

  FileRestoreClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.RestoreResponse> restore($0.RestoreRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$restore, request, options: options);
  }
}

abstract class FileRestoreServiceBase extends $grpc.Service {
  $core.String get $name => 'file_changelog.FileRestore';

  FileRestoreServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.RestoreRequest, $0.RestoreResponse>(
        'Restore',
        restore_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RestoreRequest.fromBuffer(value),
        ($0.RestoreResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.RestoreResponse> restore_Pre(
      $grpc.ServiceCall call, $async.Future<$0.RestoreRequest> request) async {
    return restore(call, await request);
  }

  $async.Future<$0.RestoreResponse> restore(
      $grpc.ServiceCall call, $0.RestoreRequest request);
}
