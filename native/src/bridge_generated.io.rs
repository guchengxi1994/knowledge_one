use super::*;
// Section: wire functions

#[no_mangle]
pub extern "C" fn wire_main(port_: i64) {
    wire_main_impl(port_)
}

#[no_mangle]
pub extern "C" fn wire_get_counter(port_: i64) {
    wire_get_counter_impl(port_)
}

#[no_mangle]
pub extern "C" fn wire_increment(port_: i64) {
    wire_increment_impl(port_)
}

#[no_mangle]
pub extern "C" fn wire_decrement(port_: i64) {
    wire_decrement_impl(port_)
}

#[no_mangle]
pub extern "C" fn wire_create_storage_directory(port_: i64, s: *mut wire_uint_8_list) {
    wire_create_storage_directory_impl(port_, s)
}

#[no_mangle]
pub extern "C" fn wire_init_mysql(port_: i64, conf_path: *mut wire_uint_8_list) {
    wire_init_mysql_impl(port_, conf_path)
}

#[no_mangle]
pub extern "C" fn wire_get_status_types(port_: i64) {
    wire_get_status_types_impl(port_)
}

// Section: allocate functions

#[no_mangle]
pub extern "C" fn new_uint_8_list_0(len: i32) -> *mut wire_uint_8_list {
    let ans = wire_uint_8_list {
        ptr: support::new_leak_vec_ptr(Default::default(), len),
        len,
    };
    support::new_leak_box_ptr(ans)
}

// Section: impl Wire2Api

impl Wire2Api<String> for *mut wire_uint_8_list {
    fn wire2api(self) -> String {
        let vec: Vec<u8> = self.wire2api();
        String::from_utf8_lossy(&vec).into_owned()
    }
}

impl Wire2Api<Vec<u8>> for *mut wire_uint_8_list {
    fn wire2api(self) -> Vec<u8> {
        unsafe {
            let wrap = support::box_from_leak_ptr(self);
            support::vec_from_leak_ptr(wrap.ptr, wrap.len)
        }
    }
}
// Section: wire structs

#[repr(C)]
#[derive(Clone)]
pub struct wire_uint_8_list {
    ptr: *mut u8,
    len: i32,
}

// Section: impl NewWithNullPtr

pub trait NewWithNullPtr {
    fn new_with_null_ptr() -> Self;
}

impl<T> NewWithNullPtr for *mut T {
    fn new_with_null_ptr() -> Self {
        std::ptr::null_mut()
    }
}

// Section: sync execution mode utility

#[no_mangle]
pub extern "C" fn free_WireSyncReturnStruct(val: support::WireSyncReturnStruct) {
    unsafe {
        let _ = support::vec_from_leak_ptr(val.ptr, val.len);
    }
}
