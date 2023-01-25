use super::*;
// Section: wire functions

#[wasm_bindgen]
pub fn wire_create_all_directory(port_: MessagePort, s: String) {
    wire_create_all_directory_impl(port_, s)
}

#[wasm_bindgen]
pub fn wire_get_faker_locale(port_: MessagePort, config_path: String) {
    wire_get_faker_locale_impl(port_, config_path)
}

#[wasm_bindgen]
pub fn wire_get_app_config(port_: MessagePort, config_path: String) {
    wire_get_app_config_impl(port_, config_path)
}

#[wasm_bindgen]
pub fn wire_get_changelog_from_id(port_: MessagePort, id: i64, file_hash: String) {
    wire_get_changelog_from_id_impl(port_, id, file_hash)
}

#[wasm_bindgen]
pub fn wire_get_file_hash(port_: MessagePort, file_path: String) {
    wire_get_file_hash_impl(port_, file_path)
}

#[wasm_bindgen]
pub fn wire_delete_file_by_file_hash(port_: MessagePort, file_hash: String) {
    wire_delete_file_by_file_hash_impl(port_, file_hash)
}

#[wasm_bindgen]
pub fn wire_change_version_control(port_: MessagePort, file_hash: String) {
    wire_change_version_control_impl(port_, file_hash)
}

#[wasm_bindgen]
pub fn wire_create_new_version(port_: MessagePort, model: JsValue) {
    wire_create_new_version_impl(port_, model)
}

#[wasm_bindgen]
pub fn wire_create_new_disk_file(port_: MessagePort, file_path: String) {
    wire_create_new_disk_file_impl(port_, file_path)
}

#[wasm_bindgen]
pub fn wire_get_file_logs(port_: MessagePort, file_hash: String) {
    wire_get_file_logs_impl(port_, file_hash)
}

#[wasm_bindgen]
pub fn wire_change_file_hash_by_id(
    port_: MessagePort,
    ori_file_path: String,
    file_path: String,
    file_id: i64,
    diff_path: Option<String>,
) {
    wire_change_file_hash_by_id_impl(port_, ori_file_path, file_path, file_id, diff_path)
}

#[wasm_bindgen]
pub fn wire_init_database(port_: MessagePort, conf_path: String, is_first_time: bool) {
    wire_init_database_impl(port_, conf_path, is_first_time)
}

#[wasm_bindgen]
pub fn wire_get_status_types(port_: MessagePort) {
    wire_get_status_types_impl(port_)
}

#[wasm_bindgen]
pub fn wire_get_todos(port_: MessagePort) {
    wire_get_todos_impl(port_)
}

#[wasm_bindgen]
pub fn wire_get_files(port_: MessagePort) {
    wire_get_files_impl(port_)
}

#[wasm_bindgen]
pub fn wire_new_file(port_: MessagePort, f: JsValue) {
    wire_new_file_impl(port_, f)
}

#[wasm_bindgen]
pub fn wire_clean_svg_file(port_: MessagePort, file_path: String) {
    wire_clean_svg_file_impl(port_, file_path)
}

#[wasm_bindgen]
pub fn wire_clean_svg_string(port_: MessagePort, content: String) {
    wire_clean_svg_string_impl(port_, content)
}

#[wasm_bindgen]
pub fn wire_insert_a_new_log(port_: MessagePort, log: JsValue) {
    wire_insert_a_new_log_impl(port_, log)
}

#[wasm_bindgen]
pub fn wire_query_all_operation_logs(port_: MessagePort) {
    wire_query_all_operation_logs_impl(port_)
}

// Section: allocate functions

// Section: related functions

// Section: impl Wire2Api

impl Wire2Api<String> for String {
    fn wire2api(self) -> String {
        self
    }
}

impl Wire2Api<NativeFileNewVersion> for JsValue {
    fn wire2api(self) -> NativeFileNewVersion {
        let self_ = self.dyn_into::<JsArray>().unwrap();
        assert_eq!(
            self_.length(),
            7,
            "Expected 7 elements, got {}",
            self_.length()
        );
        NativeFileNewVersion {
            prev_file_path: self_.get(0).wire2api(),
            prev_file_hash: self_.get(1).wire2api(),
            prev_file_name: self_.get(2).wire2api(),
            new_version_file_path: self_.get(3).wire2api(),
            new_version_file_hash: self_.get(4).wire2api(),
            new_version_file_name: self_.get(5).wire2api(),
            diff_path: self_.get(6).wire2api(),
        }
    }
}
impl Wire2Api<NativeFileSummary> for JsValue {
    fn wire2api(self) -> NativeFileSummary {
        let self_ = self.dyn_into::<JsArray>().unwrap();
        assert_eq!(
            self_.length(),
            4,
            "Expected 4 elements, got {}",
            self_.length()
        );
        NativeFileSummary {
            file_name: self_.get(0).wire2api(),
            file_path: self_.get(1).wire2api(),
            file_hash: self_.get(2).wire2api(),
            version_control: self_.get(3).wire2api(),
        }
    }
}
impl Wire2Api<OperationLogSummary> for JsValue {
    fn wire2api(self) -> OperationLogSummary {
        let self_ = self.dyn_into::<JsArray>().unwrap();
        assert_eq!(
            self_.length(),
            2,
            "Expected 2 elements, got {}",
            self_.length()
        );
        OperationLogSummary {
            operation_content: self_.get(0).wire2api(),
            operation_name: self_.get(1).wire2api(),
        }
    }
}
impl Wire2Api<Option<String>> for Option<String> {
    fn wire2api(self) -> Option<String> {
        self.map(Wire2Api::wire2api)
    }
}

impl Wire2Api<Vec<u8>> for Box<[u8]> {
    fn wire2api(self) -> Vec<u8> {
        self.into_vec()
    }
}
// Section: impl Wire2Api for JsValue

impl Wire2Api<String> for JsValue {
    fn wire2api(self) -> String {
        self.as_string().expect("non-UTF-8 string, or not a string")
    }
}
impl Wire2Api<bool> for JsValue {
    fn wire2api(self) -> bool {
        self.is_truthy()
    }
}
impl Wire2Api<i64> for JsValue {
    fn wire2api(self) -> i64 {
        ::std::convert::TryInto::try_into(self.dyn_into::<js_sys::BigInt>().unwrap()).unwrap()
    }
}
impl Wire2Api<Option<String>> for JsValue {
    fn wire2api(self) -> Option<String> {
        (!self.is_undefined() && !self.is_null()).then(|| self.wire2api())
    }
}
impl Wire2Api<u8> for JsValue {
    fn wire2api(self) -> u8 {
        self.unchecked_into_f64() as _
    }
}
impl Wire2Api<Vec<u8>> for JsValue {
    fn wire2api(self) -> Vec<u8> {
        self.unchecked_into::<js_sys::Uint8Array>().to_vec().into()
    }
}
