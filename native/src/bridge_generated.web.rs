use super::*;
// Section: wire functions

#[wasm_bindgen]
pub fn wire_main(port_: MessagePort) {
    wire_main_impl(port_)
}

#[wasm_bindgen]
pub fn wire_get_counter(port_: MessagePort) {
    wire_get_counter_impl(port_)
}

#[wasm_bindgen]
pub fn wire_increment(port_: MessagePort) {
    wire_increment_impl(port_)
}

#[wasm_bindgen]
pub fn wire_decrement(port_: MessagePort) {
    wire_decrement_impl(port_)
}

#[wasm_bindgen]
pub fn wire_create_storage_directory(port_: MessagePort, s: String) {
    wire_create_storage_directory_impl(port_, s)
}

#[wasm_bindgen]
pub fn wire_init_mysql(port_: MessagePort, conf_path: String) {
    wire_init_mysql_impl(port_, conf_path)
}

#[wasm_bindgen]
pub fn wire_init_mysql2(port_: MessagePort, conf_path: String) {
    wire_init_mysql2_impl(port_, conf_path)
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
pub fn wire_test_sqlx(port_: MessagePort) {
    wire_test_sqlx_impl(port_)
}

// Section: allocate functions

// Section: impl Wire2Api

impl Wire2Api<String> for String {
    fn wire2api(self) -> String {
        self
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
