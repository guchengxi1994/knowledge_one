///
//  Generated code. Do not modify.
//  source: quicktype.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'quicktype.pb.dart' as $0;
export 'quicktype.pb.dart';

class GenerateClient extends $grpc.Client {
  static final _$generateCode =
      $grpc.ClientMethod<$0.QuicktypeRequest, $0.QuicktypeResponse>(
          '/quicktype.Generate/GenerateCode',
          ($0.QuicktypeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.QuicktypeResponse.fromBuffer(value));

  GenerateClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.QuicktypeResponse> generateCode(
      $0.QuicktypeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateCode, request, options: options);
  }
}

abstract class GenerateServiceBase extends $grpc.Service {
  $core.String get $name => 'quicktype.Generate';

  GenerateServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.QuicktypeRequest, $0.QuicktypeResponse>(
        'GenerateCode',
        generateCode_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.QuicktypeRequest.fromBuffer(value),
        ($0.QuicktypeResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.QuicktypeResponse> generateCode_Pre($grpc.ServiceCall call,
      $async.Future<$0.QuicktypeRequest> request) async {
    return generateCode(call, await request);
  }

  $async.Future<$0.QuicktypeResponse> generateCode(
      $grpc.ServiceCall call, $0.QuicktypeRequest request);
}
