python -m grpc_tools.protoc --proto_path=. --python_out=faker_generator/ --grpc_python_out=faker_generator/ faker.proto

protoc --proto_path=. --dart_out=grpc:../lib/src/rpc -Iprotos faker.proto