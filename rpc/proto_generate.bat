protoc --proto_path=. --dart_out=grpc:../lib/src/rpc -Iprotos file_diff.proto

python -m grpc_tools.protoc --proto_path=. --python_out=file_changelog/file_diff --grpc_python_out=file_changelog/file_diff file_diff.proto