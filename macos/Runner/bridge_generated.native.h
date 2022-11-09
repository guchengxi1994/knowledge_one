#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>

typedef int64_t DartPort;

typedef bool (*DartPostCObjectFnType)(DartPort port_id, void *message);

typedef struct wire_uint_8_list {
  uint8_t *ptr;
  int32_t len;
} wire_uint_8_list;

typedef struct wire_NativeFileNewVersion {
  struct wire_uint_8_list *prev_file_path;
  struct wire_uint_8_list *prev_file_hash;
  struct wire_uint_8_list *prev_file_name;
  struct wire_uint_8_list *new_version_file_path;
  struct wire_uint_8_list *new_version_file_hash;
  struct wire_uint_8_list *new_version_file_name;
} wire_NativeFileNewVersion;

typedef struct wire_NativeFileSummary {
  struct wire_uint_8_list *file_name;
  struct wire_uint_8_list *file_path;
  struct wire_uint_8_list *file_hash;
  int64_t version_control;
} wire_NativeFileSummary;

typedef struct WireSyncReturnStruct {
  uint8_t *ptr;
  int32_t len;
  bool success;
} WireSyncReturnStruct;

void store_dart_post_cobject(DartPostCObjectFnType ptr);

void wire_create_storage_directory(int64_t port_, struct wire_uint_8_list *s);

void wire_create_diff_directory(int64_t port_, struct wire_uint_8_list *s);

void wire_get_file_hash(int64_t port_, struct wire_uint_8_list *file_path);

void wire_delete_file_by_file_hash(int64_t port_, struct wire_uint_8_list *file_hash);

void wire_change_version_control(int64_t port_, struct wire_uint_8_list *file_hash);

void wire_create_new_version(int64_t port_, struct wire_NativeFileNewVersion *model);

void wire_init_mysql(int64_t port_, struct wire_uint_8_list *conf_path);

void wire_get_status_types(int64_t port_);

void wire_get_todos(int64_t port_);

void wire_get_files(int64_t port_);

void wire_new_file(int64_t port_, struct wire_NativeFileSummary *f);

struct wire_NativeFileNewVersion *new_box_autoadd_native_file_new_version_0(void);

struct wire_NativeFileSummary *new_box_autoadd_native_file_summary_0(void);

struct wire_uint_8_list *new_uint_8_list_0(int32_t len);

void free_WireSyncReturnStruct(struct WireSyncReturnStruct val);

static int64_t dummy_method_to_enforce_bundling(void) {
    int64_t dummy_var = 0;
    dummy_var ^= ((int64_t) (void*) wire_create_storage_directory);
    dummy_var ^= ((int64_t) (void*) wire_create_diff_directory);
    dummy_var ^= ((int64_t) (void*) wire_get_file_hash);
    dummy_var ^= ((int64_t) (void*) wire_delete_file_by_file_hash);
    dummy_var ^= ((int64_t) (void*) wire_change_version_control);
    dummy_var ^= ((int64_t) (void*) wire_create_new_version);
    dummy_var ^= ((int64_t) (void*) wire_init_mysql);
    dummy_var ^= ((int64_t) (void*) wire_get_status_types);
    dummy_var ^= ((int64_t) (void*) wire_get_todos);
    dummy_var ^= ((int64_t) (void*) wire_get_files);
    dummy_var ^= ((int64_t) (void*) wire_new_file);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_native_file_new_version_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_native_file_summary_0);
    dummy_var ^= ((int64_t) (void*) new_uint_8_list_0);
    dummy_var ^= ((int64_t) (void*) free_WireSyncReturnStruct);
    dummy_var ^= ((int64_t) (void*) store_dart_post_cobject);
    return dummy_var;
}