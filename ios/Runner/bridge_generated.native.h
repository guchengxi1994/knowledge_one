#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>

typedef int64_t DartPort;

typedef bool (*DartPostCObjectFnType)(DartPort port_id, void *message);

typedef struct wire_uint_8_list {
  uint8_t *ptr;
  int32_t len;
} wire_uint_8_list;

typedef struct WireSyncReturnStruct {
  uint8_t *ptr;
  int32_t len;
  bool success;
} WireSyncReturnStruct;

void store_dart_post_cobject(DartPostCObjectFnType ptr);

void wire_main(int64_t port_);

void wire_get_counter(int64_t port_);

void wire_increment(int64_t port_);

void wire_decrement(int64_t port_);

void wire_create_storage_directory(int64_t port_, struct wire_uint_8_list *s);

void wire_init_mysql(int64_t port_, struct wire_uint_8_list *conf_path);

void wire_get_status_types(int64_t port_);

void wire_get_todos(int64_t port_);

struct wire_uint_8_list *new_uint_8_list_0(int32_t len);

void free_WireSyncReturnStruct(struct WireSyncReturnStruct val);

static int64_t dummy_method_to_enforce_bundling(void) {
    int64_t dummy_var = 0;
    dummy_var ^= ((int64_t) (void*) wire_main);
    dummy_var ^= ((int64_t) (void*) wire_get_counter);
    dummy_var ^= ((int64_t) (void*) wire_increment);
    dummy_var ^= ((int64_t) (void*) wire_decrement);
    dummy_var ^= ((int64_t) (void*) wire_create_storage_directory);
    dummy_var ^= ((int64_t) (void*) wire_init_mysql);
    dummy_var ^= ((int64_t) (void*) wire_get_status_types);
    dummy_var ^= ((int64_t) (void*) wire_get_todos);
    dummy_var ^= ((int64_t) (void*) new_uint_8_list_0);
    dummy_var ^= ((int64_t) (void*) free_WireSyncReturnStruct);
    dummy_var ^= ((int64_t) (void*) store_dart_post_cobject);
    return dummy_var;
}