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

// Section: allocate functions

// Section: impl Wire2Api

// Section: impl Wire2Api for JsValue
