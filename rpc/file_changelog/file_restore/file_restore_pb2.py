# -*- coding: utf-8 -*-
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: file_restore.proto
"""Generated protocol buffer code."""
from google.protobuf.internal import builder as _builder
from google.protobuf import descriptor as _descriptor
from google.protobuf import descriptor_pool as _descriptor_pool
from google.protobuf import symbol_database as _symbol_database
# @@protoc_insertion_point(imports)

_sym_db = _symbol_database.Default()




DESCRIPTOR = _descriptor_pool.Default().AddSerializedFile(b'\n\x12\x66ile_restore.proto\x12\x0e\x66ile_changelog\"T\n\x0eRestoreRequest\x12\x10\n\x08\x66ilePath\x18\x01 \x01(\t\x12\r\n\x05\x64iffs\x18\x02 \x03(\t\x12\x10\n\x08\x66ileSize\x18\x03 \x03(\x03\x12\x0f\n\x07saveDir\x18\x04 \x01(\t\"\"\n\x0fRestoreResponse\x12\x0f\n\x07message\x18\x01 \x01(\t2[\n\x0b\x46ileRestore\x12L\n\x07Restore\x12\x1e.file_changelog.RestoreRequest\x1a\x1f.file_changelog.RestoreResponse\"\x00\x62\x06proto3')

_builder.BuildMessageAndEnumDescriptors(DESCRIPTOR, globals())
_builder.BuildTopDescriptorsAndMessages(DESCRIPTOR, 'file_restore_pb2', globals())
if _descriptor._USE_C_DESCRIPTORS == False:

  DESCRIPTOR._options = None
  _RESTOREREQUEST._serialized_start=38
  _RESTOREREQUEST._serialized_end=122
  _RESTORERESPONSE._serialized_start=124
  _RESTORERESPONSE._serialized_end=158
  _FILERESTORE._serialized_start=160
  _FILERESTORE._serialized_end=251
# @@protoc_insertion_point(module_scope)
