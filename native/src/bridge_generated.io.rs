use super::*;
// Section: wire functions

#[no_mangle]
pub extern "C" fn wire_create_storage_directory(port_: i64, s: *mut wire_uint_8_list) {
    wire_create_storage_directory_impl(port_, s)
}

#[no_mangle]
pub extern "C" fn wire_create_diff_directory(port_: i64, s: *mut wire_uint_8_list) {
    wire_create_diff_directory_impl(port_, s)
}

#[no_mangle]
pub extern "C" fn wire_create_restore_directory(port_: i64, s: *mut wire_uint_8_list) {
    wire_create_restore_directory_impl(port_, s)
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
    file_path: *mut wire_uint_8_list,
    file_id: i64,
) {
    wire_change_file_hash_by_id_impl(port_, file_path, file_id)
}

#[no_mangle]
pub extern "C" fn wire_init_mysql(port_: i64, conf_path: *mut wire_uint_8_list) {
    wire_init_mysql_impl(port_, conf_path)
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

// Section: sync execution mode utility

#[no_mangle]
pub extern "C" fn free_WireSyncReturnStruct(val: support::WireSyncReturnStruct) {
    unsafe {
        let _ = support::vec_from_leak_ptr(val.ptr, val.len);
    }
}
