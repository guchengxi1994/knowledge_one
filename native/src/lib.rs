use std::sync::Mutex;

mod api;
mod bridge_generated;
mod database;
mod storage;
pub mod svg;
pub mod constants;
pub mod native_sysinfo;

#[macro_use]
#[deprecated="unused"]
extern crate lazy_static;
lazy_static! {
    static ref DATABASE_ADDR: Mutex<String> = Mutex::new(String::new());
    static ref DATABASE_PORT: Mutex<String> = Mutex::new(String::new());
    static ref DATABASE_USERNAME: Mutex<String> = Mutex::new(String::new());
    static ref DATABASE_PASSWORD: Mutex<String> = Mutex::new(String::new());
    static ref DATABASE_DATABASE: Mutex<String> = Mutex::new(String::new());
}


