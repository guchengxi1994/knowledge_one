# Generated by the gRPC Python protocol compiler plugin. DO NOT EDIT!
"""Client and server classes corresponding to protobuf-defined services."""
import grpc

import file_diff.file_diff_pb2 as file__diff__pb2


class FileDiffStub(object):
    """Missing associated documentation comment in .proto file."""

    def __init__(self, channel):
        """Constructor.

        Args:
            channel: A grpc.Channel.
        """
        self.GenerateDiff = channel.unary_unary(
                '/file_changelog.FileDiff/GenerateDiff',
                request_serializer=file__diff__pb2.GenerateDiffRequest.SerializeToString,
                response_deserializer=file__diff__pb2.GenerateDiffResponse.FromString,
                )


class FileDiffServicer(object):
    """Missing associated documentation comment in .proto file."""

    def GenerateDiff(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')


def add_FileDiffServicer_to_server(servicer, server):
    rpc_method_handlers = {
            'GenerateDiff': grpc.unary_unary_rpc_method_handler(
                    servicer.GenerateDiff,
                    request_deserializer=file__diff__pb2.GenerateDiffRequest.FromString,
                    response_serializer=file__diff__pb2.GenerateDiffResponse.SerializeToString,
            ),
    }
    generic_handler = grpc.method_handlers_generic_handler(
            'file_changelog.FileDiff', rpc_method_handlers)
    server.add_generic_rpc_handlers((generic_handler,))


 # This class is part of an EXPERIMENTAL API.
class FileDiff(object):
    """Missing associated documentation comment in .proto file."""

    @staticmethod
    def GenerateDiff(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/file_changelog.FileDiff/GenerateDiff',
            file__diff__pb2.GenerateDiffRequest.SerializeToString,
            file__diff__pb2.GenerateDiffResponse.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)
