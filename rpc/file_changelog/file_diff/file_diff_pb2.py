# -*- coding: utf-8 -*-
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: file_diff.proto
"""Generated protocol buffer code."""
from google.protobuf.internal import builder as _builder
from google.protobuf import descriptor as _descriptor
from google.protobuf import descriptor_pool as _descriptor_pool
from google.protobuf import symbol_database as _symbol_database
# @@protoc_insertion_point(imports)

_sym_db = _symbol_database.Default()




DESCRIPTOR = _descriptor_pool.Default().AddSerializedFile(b'\n\x0f\x66ile_diff.proto\x12\x0e\x66ile_changelog\"F\n\x13GenerateDiffRequest\x12\x0e\n\x06\x62\x65\x66ore\x18\x01 \x01(\t\x12\r\n\x05\x61\x66ter\x18\x02 \x01(\t\x12\x10\n\x08savePath\x18\x03 \x01(\t\"\'\n\x14GenerateDiffResponse\x12\x0f\n\x07message\x18\x01 \x01(\x05\x32g\n\x08\x46ileDiff\x12[\n\x0cGenerateDiff\x12#.file_changelog.GenerateDiffRequest\x1a$.file_changelog.GenerateDiffResponse\"\x00\x62\x06proto3')

_builder.BuildMessageAndEnumDescriptors(DESCRIPTOR, globals())
_builder.BuildTopDescriptorsAndMessages(DESCRIPTOR, 'file_diff_pb2', globals())
if _descriptor._USE_C_DESCRIPTORS == False:

  DESCRIPTOR._options = None
  _GENERATEDIFFREQUEST._serialized_start=35
  _GENERATEDIFFREQUEST._serialized_end=105
  _GENERATEDIFFRESPONSE._serialized_start=107
  _GENERATEDIFFRESPONSE._serialized_end=146
  _FILEDIFF._serialized_start=148
  _FILEDIFF._serialized_end=251
# @@protoc_insertion_point(module_scope)
