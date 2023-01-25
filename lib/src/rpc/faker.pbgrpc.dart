///
//  Generated code. Do not modify.
//  source: faker.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'faker.pb.dart' as $0;
export 'faker.pb.dart';

class FakerClient extends $grpc.Client {
  static final _$quickFake =
      $grpc.ClientMethod<$0.QuickFakeRequest, $0.QuickFakeResponse>(
          '/faker.Faker/QuickFake',
          ($0.QuickFakeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.QuickFakeResponse.fromBuffer(value));
  static final _$batchFake =
      $grpc.ClientMethod<$0.BatchFakeRequest, $0.BatchFakeResponse>(
          '/faker.Faker/BatchFake',
          ($0.BatchFakeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.BatchFakeResponse.fromBuffer(value));

  FakerClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.QuickFakeResponse> quickFake(
      $0.QuickFakeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$quickFake, request, options: options);
  }

  $grpc.ResponseFuture<$0.BatchFakeResponse> batchFake(
      $0.BatchFakeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$batchFake, request, options: options);
  }
}

abstract class FakerServiceBase extends $grpc.Service {
  $core.String get $name => 'faker.Faker';

  FakerServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.QuickFakeRequest, $0.QuickFakeResponse>(
        'QuickFake',
        quickFake_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.QuickFakeRequest.fromBuffer(value),
        ($0.QuickFakeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.BatchFakeRequest, $0.BatchFakeResponse>(
        'BatchFake',
        batchFake_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.BatchFakeRequest.fromBuffer(value),
        ($0.BatchFakeResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.QuickFakeResponse> quickFake_Pre($grpc.ServiceCall call,
      $async.Future<$0.QuickFakeRequest> request) async {
    return quickFake(call, await request);
  }

  $async.Future<$0.BatchFakeResponse> batchFake_Pre($grpc.ServiceCall call,
      $async.Future<$0.BatchFakeRequest> request) async {
    return batchFake(call, await request);
  }

  $async.Future<$0.QuickFakeResponse> quickFake(
      $grpc.ServiceCall call, $0.QuickFakeRequest request);
  $async.Future<$0.BatchFakeResponse> batchFake(
      $grpc.ServiceCall call, $0.BatchFakeRequest request);
}
