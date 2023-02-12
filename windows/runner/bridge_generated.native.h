#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>
typedef struct _Dart_Handle* Dart_Handle;

#define DATABASE_INIT_OK 10000

#define DATABASE_INIT_FILE_NOT_FOUND 10001

#define DATABASE_INIT_CREATE_FAILED 10002

#define DATABASE_INIT_OTHER_ERROR 10004

#define DATABASE_TABLE_CREATION_SUCCESS 11000

#define DATABASE_TABLE_CREATION_FAIL 11001

#define FILE_ALREADY_EXISTS_WHEN_CREATION -500

#define FILE_DETAILS_ALREADY_EXISTS_WHEN_CREATION -501

#define OPERATION_LOG_INSERT_ERROR 20001

#define OPERATION_LOG_INSERT_OK 20000

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

typedef struct wire_OperationLogSummary {
  struct wire_uint_8_list *operation_content;
  struct wire_uint_8_list *operation_name;
} wire_OperationLogSummary;

typedef struct DartCObject *WireSyncReturn;

void store_dart_post_cobject(DartPostCObjectFnType ptr);

Dart_Handle get_dart_object(uintptr_t ptr);

void drop_dart_object(uintptr_t ptr);

uintptr_t new_dart_opaque(Dart_Handle handle);

intptr_t init_frb_dart_api_dl(void *obj);

void wire_create_all_directory(int64_t port_, struct wire_uint_8_list *s);

void wire_get_faker_locale(int64_t port_, struct wire_uint_8_list *config_path);

void wire_get_redis_memory(int64_t port_);

void wire_get_app_config(int64_t port_, struct wire_uint_8_list *config_path);

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

void wire_init_database(int64_t port_, struct wire_uint_8_list *conf_path, bool is_first_time);

void wire_get_status_types(int64_t port_);

void wire_get_todos(int64_t port_);

void wire_get_files(int64_t port_);

void wire_new_file(int64_t port_, struct wire_NativeFileSummary *f);

void wire_clean_svg_file(int64_t port_, struct wire_uint_8_list *file_path);

void wire_clean_svg_string(int64_t port_, struct wire_uint_8_list *content);

void wire_insert_a_new_log(int64_t port_, struct wire_OperationLogSummary *log);

void wire_query_all_operation_logs(int64_t port_);

struct wire_NativeFileNewVersion *new_box_autoadd_native_file_new_version_0(void);

struct wire_NativeFileSummary *new_box_autoadd_native_file_summary_0(void);

struct wire_OperationLogSummary *new_box_autoadd_operation_log_summary_0(void);

struct wire_uint_8_list *new_uint_8_list_0(int32_t len);

void free_WireSyncReturn(WireSyncReturn ptr);

static int64_t dummy_method_to_enforce_bundling(void) {
    int64_t dummy_var = 0;
    dummy_var ^= ((int64_t) (void*) wire_create_all_directory);
    dummy_var ^= ((int64_t) (void*) wire_get_faker_locale);
    dummy_var ^= ((int64_t) (void*) wire_get_redis_memory);
    dummy_var ^= ((int64_t) (void*) wire_get_app_config);
    dummy_var ^= ((int64_t) (void*) wire_get_changelog_from_id);
    dummy_var ^= ((int64_t) (void*) wire_get_file_hash);
    dummy_var ^= ((int64_t) (void*) wire_delete_file_by_file_hash);
    dummy_var ^= ((int64_t) (void*) wire_change_version_control);
    dummy_var ^= ((int64_t) (void*) wire_create_new_version);
    dummy_var ^= ((int64_t) (void*) wire_create_new_disk_file);
    dummy_var ^= ((int64_t) (void*) wire_get_file_logs);
    dummy_var ^= ((int64_t) (void*) wire_change_file_hash_by_id);
    dummy_var ^= ((int64_t) (void*) wire_init_database);
    dummy_var ^= ((int64_t) (void*) wire_get_status_types);
    dummy_var ^= ((int64_t) (void*) wire_get_todos);
    dummy_var ^= ((int64_t) (void*) wire_get_files);
    dummy_var ^= ((int64_t) (void*) wire_new_file);
    dummy_var ^= ((int64_t) (void*) wire_clean_svg_file);
    dummy_var ^= ((int64_t) (void*) wire_clean_svg_string);
    dummy_var ^= ((int64_t) (void*) wire_insert_a_new_log);
    dummy_var ^= ((int64_t) (void*) wire_query_all_operation_logs);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_native_file_new_version_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_native_file_summary_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_operation_log_summary_0);
    dummy_var ^= ((int64_t) (void*) new_uint_8_list_0);
    dummy_var ^= ((int64_t) (void*) free_WireSyncReturn);
    dummy_var ^= ((int64_t) (void*) store_dart_post_cobject);
    dummy_var ^= ((int64_t) (void*) get_dart_object);
    dummy_var ^= ((int64_t) (void*) drop_dart_object);
    dummy_var ^= ((int64_t) (void*) new_dart_opaque);
    return dummy_var;
}