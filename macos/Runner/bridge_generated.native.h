#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>
typedef struct _Dart_Handle* Dart_Handle;

typedef struct DartCObject DartCObject;

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
  struct wire_uint_8_list *diff_path;
} wire_NativeFileNewVersion;

typedef struct wire_NativeFileSummary {
  struct wire_uint_8_list *file_name;
  struct wire_uint_8_list *file_path;
  struct wire_uint_8_list *file_hash;
  int64_t version_control;
} wire_NativeFileSummary;

typedef struct DartCObject *WireSyncReturn;

void store_dart_post_cobject(DartPostCObjectFnType ptr);

Dart_Handle get_dart_object(uintptr_t ptr);

void drop_dart_object(uintptr_t ptr);

uintptr_t new_dart_opaque(Dart_Handle handle);

intptr_t init_frb_dart_api_dl(void *obj);

void wire_create_all_directory(int64_t port_, struct wire_uint_8_list *s);

void wire_get_changelog_from_id(int64_t port_, int64_t id, struct wire_uint_8_list *file_hash);

void wire_get_file_hash(int64_t port_, struct wire_uint_8_list *file_path);

void wire_delete_file_by_file_hash(int64_t port_, struct wire_uint_8_list *file_hash);

void wire_change_version_control(int64_t port_, struct wire_uint_8_list *file_hash);

void wire_create_new_version(int64_t port_, struct wire_NativeFileNewVersion *model);

void wire_create_new_disk_file(int64_t port_, struct wire_uint_8_list *file_path);

void wire_get_file_logs(int64_t port_, struct wire_uint_8_list *file_hash);

void wire_change_file_hash_by_id(int64_t port_,
                                 struct wire_uint_8_list *ori_file_path,
                                 struct wire_uint_8_list *file_path,
                                 int64_t file_id,
                                 struct wire_uint_8_list *diff_path);

void wire_init_mysql(int64_t port_, struct wire_uint_8_list *conf_path);

void wire_get_status_types(int64_t port_);

void wire_get_todos(int64_t port_);

void wire_get_files(int64_t port_);

void wire_new_file(int64_t port_, struct wire_NativeFileSummary *f);

void wire_clean_svg_file(int64_t port_, struct wire_uint_8_list *file_path);

void wire_clean_svg_string(int64_t port_, struct wire_uint_8_list *content);

struct wire_NativeFileNewVersion *new_box_autoadd_native_file_new_version_0(void);

struct wire_NativeFileSummary *new_box_autoadd_native_file_summary_0(void);

struct wire_uint_8_list *new_uint_8_list_0(int32_t len);

void free_WireSyncReturn(WireSyncReturn ptr);

static int64_t dummy_method_to_enforce_bundling(void) {
    int64_t dummy_var = 0;
    dummy_var ^= ((int64_t) (void*) wire_create_all_directory);
    dummy_var ^= ((int64_t) (void*) wire_get_changelog_from_id);
    dummy_var ^= ((int64_t) (void*) wire_get_file_hash);
    dummy_var ^= ((int64_t) (void*) wire_delete_file_by_file_hash);
    dummy_var ^= ((int64_t) (void*) wire_change_version_control);
    dummy_var ^= ((int64_t) (void*) wire_create_new_version);
    dummy_var ^= ((int64_t) (void*) wire_create_new_disk_file);
    dummy_var ^= ((int64_t) (void*) wire_get_file_logs);
    dummy_var ^= ((int64_t) (void*) wire_change_file_hash_by_id);
    dummy_var ^= ((int64_t) (void*) wire_init_mysql);
    dummy_var ^= ((int64_t) (void*) wire_get_status_types);
    dummy_var ^= ((int64_t) (void*) wire_get_todos);
    dummy_var ^= ((int64_t) (void*) wire_get_files);
    dummy_var ^= ((int64_t) (void*) wire_new_file);
    dummy_var ^= ((int64_t) (void*) wire_clean_svg_file);
    dummy_var ^= ((int64_t) (void*) wire_clean_svg_string);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_native_file_new_version_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_native_file_summary_0);
    dummy_var ^= ((int64_t) (void*) new_uint_8_list_0);
    dummy_var ^= ((int64_t) (void*) free_WireSyncReturn);
    dummy_var ^= ((int64_t) (void*) store_dart_post_cobject);
    dummy_var ^= ((int64_t) (void*) get_dart_object);
    dummy_var ^= ((int64_t) (void*) drop_dart_object);
    dummy_var ^= ((int64_t) (void*) new_dart_opaque);
    return dummy_var;
}