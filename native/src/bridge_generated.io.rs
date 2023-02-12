use super::*;
// Section: wire functions

#[no_mangle]
pub extern "C" fn wire_create_all_directory(port_: i64, s: *mut wire_uint_8_list) {
    wire_create_all_directory_impl(port_, s)
}

#[no_mangle]
pub extern "C" fn wire_get_faker_locale(port_: i64, config_path: *mut wire_uint_8_list) {
    wire_get_faker_locale_impl(port_, config_path)
}

#[no_mangle]
pub extern "C" fn wire_get_redis_memory(port_: i64) {
    wire_get_redis_memory_impl(port_)
}

#[no_mangle]
pub extern "C" fn wire_get_app_config(port_: i64, config_path: *mut wire_uint_8_list) {
    wire_get_app_config_impl(port_, config_path)
}

#[no_mangle]
pub extern "C" fn wire_get_changelog_from_id(
    port_: i64,
    id: i64,
    file_hash: *mut wire_uint_8_list,
) {
    wire_get_changelog_from_id_impl(port_, id, file_hash)
}

#[no_mangle]
pub extern "C" fn wire_get_file_hash(port_: i64, file_path: *mut wire_uint_8_list) {
    wire_get_file_hash_impl(port_, file_path)
}

#[no_mangle]
pub extern "C" fn wire_delete_file_by_file_hash(port_: i64, file_hash: *mut wire_uint_8_list) {
    wire_delete_file_by_file_hash_impl(port_, file_hash)
}

#[no_mangle]
pub extern "C" fn wire_change_version_control(port_: i64, file_hash: *mut wire_uint_8_list) {
    wire_change_version_control_impl(port_, file_hash)
}

#[no_mangle]
pub extern "C" fn wire_create_new_version(port_: i64, model: *mut wire_NativeFileNewVersion) {
    wire_create_new_version_impl(port_, model)
}

#[no_mangle]
pub extern "C" fn wire_create_new_disk_file(port_: i64, file_path: *mut wire_uint_8_list) {
    wire_create_new_disk_file_impl(port_, file_path)
}

#[no_mangle]
pub extern "C" fn wire_get_file_logs(port_: i64, file_hash: *mut wire_uint_8_list) {
    wire_get_file_logs_impl(port_, file_hash)
}

#[no_mangle]
pub extern "C" fn wire_change_file_hash_by_id(
    port_: i64,
    ori_file_path: *mut wire_uint_8_list,
    file_path: *mut wire_uint_8_list,
    file_id: i64,
    diff_path: *mut wire_uint_8_list,
) {
    wire_change_file_hash_by_id_impl(port_, ori_file_path, file_path, file_id, diff_path)
}

#[no_mangle]
pub extern "C" fn wire_init_database(
    port_: i64,
    conf_path: *mut wire_uint_8_list,
    is_first_time: bool,
) {
    wire_init_database_impl(port_, conf_path, is_first_time)
}

#[no_mangle]
pub extern "C" fn wire_get_status_types(port_: i64) {
    wire_get_status_types_impl(port_)
}

#[no_mangle]
pub extern "C" fn wire_get_todos(port_: i64) {
    wire_get_todos_impl(port_)
}

#[no_mangle]
pub extern "C" fn wire_get_files(port_: i64) {
    wire_get_files_impl(port_)
}

#[no_mangle]
pub extern "C" fn wire_new_file(port_: i64, f: *mut wire_NativeFileSummary) {
    wire_new_file_impl(port_, f)
}

#[no_mangle]
pub extern "C" fn wire_clean_svg_file(port_: i64, file_path: *mut wire_uint_8_list) {
    wire_clean_svg_file_impl(port_, file_path)
}

#[no_mangle]
pub extern "C" fn wire_clean_svg_string(port_: i64, content: *mut wire_uint_8_list) {
    wire_clean_svg_string_impl(port_, content)
}

#[no_mangle]
pub extern "C" fn wire_insert_a_new_log(port_: i64, log: *mut wire_OperationLogSummary) {
    wire_insert_a_new_log_impl(port_, log)
}

#[no_mangle]
pub extern "C" fn wire_query_all_operation_logs(port_: i64) {
    wire_query_all_operation_logs_impl(port_)
}

// Section: allocate functions

#[no_mangle]
pub extern "C" fn new_box_autoadd_native_file_new_version_0() -> *mut wire_NativeFileNewVersion {
    support::new_leak_box_ptr(wire_NativeFileNewVersion::new_with_null_ptr())
}

#[no_mangle]
pub extern "C" fn new_box_autoadd_native_file_summary_0() -> *mut wire_NativeFileSummary {
    support::new_leak_box_ptr(wire_NativeFileSummary::new_with_null_ptr())
}

#[no_mangle]
pub extern "C" fn new_box_autoadd_operation_log_summary_0() -> *mut wire_OperationLogSummary {
    support::new_leak_box_ptr(wire_OperationLogSummary::new_with_null_ptr())
}

#[no_mangle]
pub extern "C" fn new_uint_8_list_0(len: i32) -> *mut wire_uint_8_list {
    let ans = wire_uint_8_list {
        ptr: support::new_leak_vec_ptr(Default::default(), len),
        len,
    };
    support::new_leak_box_ptr(ans)
}

// Section: related functions

// Section: impl Wire2Api

impl Wire2Api<String> for *mut wire_uint_8_list {
    fn wire2api(self) -> String {
        let vec: Vec<u8> = self.wire2api();
        String::from_utf8_lossy(&vec).into_owned()
    }
}

impl Wire2Api<NativeFileNewVersion> for *mut wire_NativeFileNewVersion {
    fn wire2api(self) -> NativeFileNewVersion {
        let wrap = unsafe { support::box_from_leak_ptr(self) };
        Wire2Api::<NativeFileNewVersion>::wire2api(*wrap).into()
    }
}
impl Wire2Api<NativeFileSummary> for *mut wire_NativeFileSummary {
    fn wire2api(self) -> NativeFileSummary {
        let wrap = unsafe { support::box_from_leak_ptr(self) };
        Wire2Api::<NativeFileSummary>::wire2api(*wrap).into()
    }
}
impl Wire2Api<OperationLogSummary> for *mut wire_OperationLogSummary {
    fn wire2api(self) -> OperationLogSummary {
        let wrap = unsafe { support::box_from_leak_ptr(self) };
        Wire2Api::<OperationLogSummary>::wire2api(*wrap).into()
    }
}

impl Wire2Api<NativeFileNewVersion> for wire_NativeFileNewVersion {
    fn wire2api(self) -> NativeFileNewVersion {
        NativeFileNewVersion {
            prev_file_path: self.prev_file_path.wire2api(),
            prev_file_hash: self.prev_file_hash.wire2api(),
            prev_file_name: self.prev_file_name.wire2api(),
            new_version_file_path: self.new_version_file_path.wire2api(),
            new_version_file_hash: self.new_version_file_hash.wire2api(),
            new_version_file_name: self.new_version_file_name.wire2api(),
            diff_path: self.diff_path.wire2api(),
        }
    }
}
impl Wire2Api<NativeFileSummary> for wire_NativeFileSummary {
    fn wire2api(self) -> NativeFileSummary {
        NativeFileSummary {
            file_name: self.file_name.wire2api(),
            file_path: self.file_path.wire2api(),
            file_hash: self.file_hash.wire2api(),
            version_control: self.version_control.wire2api(),
        }
    }
}
impl Wire2Api<OperationLogSummary> for wire_OperationLogSummary {
    fn wire2api(self) -> OperationLogSummary {
        OperationLogSummary {
            operation_content: self.operation_content.wire2api(),
            operation_name: self.operation_name.wire2api(),
        }
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
pub struct wire_NativeFileNewVersion {
    prev_file_path: *mut wire_uint_8_list,
    prev_file_hash: *mut wire_uint_8_list,
    prev_file_name: *mut wire_uint_8_list,
    new_version_file_path: *mut wire_uint_8_list,
    new_version_file_hash: *mut wire_uint_8_list,
    new_version_file_name: *mut wire_uint_8_list,
    diff_path: *mut wire_uint_8_list,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_NativeFileSummary {
    file_name: *mut wire_uint_8_list,
    file_path: *mut wire_uint_8_list,
    file_hash: *mut wire_uint_8_list,
    version_control: i64,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_OperationLogSummary {
    operation_content: *mut wire_uint_8_list,
    operation_name: *mut wire_uint_8_list,
}

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

impl NewWithNullPtr for wire_NativeFileNewVersion {
    fn new_with_null_ptr() -> Self {
        Self {
            prev_file_path: core::ptr::null_mut(),
            prev_file_hash: core::ptr::null_mut(),
            prev_file_name: core::ptr::null_mut(),
            new_version_file_path: core::ptr::null_mut(),
            new_version_file_hash: core::ptr::null_mut(),
            new_version_file_name: core::ptr::null_mut(),
            diff_path: core::ptr::null_mut(),
        }
    }
}

impl NewWithNullPtr for wire_NativeFileSummary {
    fn new_with_null_ptr() -> Self {
        Self {
            file_name: core::ptr::null_mut(),
            file_path: core::ptr::null_mut(),
            file_hash: core::ptr::null_mut(),
            version_control: Default::default(),
        }
    }
}

impl NewWithNullPtr for wire_OperationLogSummary {
    fn new_with_null_ptr() -> Self {
        Self {
            operation_content: core::ptr::null_mut(),
            operation_name: core::ptr::null_mut(),
        }
    }
}

// Section: sync execution mode utility

#[no_mangle]
pub extern "C" fn free_WireSyncReturn(ptr: support::WireSyncReturn) {
    unsafe {
        let _ = support::box_from_leak_ptr(ptr);
    };
}
