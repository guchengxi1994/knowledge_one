use std::sync::Mutex;

mod bridge_generated;
mod api;
mod storage;
mod database;

#[macro_use]
extern crate lazy_static;
lazy_static! {
    static  ref DATABASE_ADDR: Mutex<String> = Mutex::new(String::new());
    static  ref DATABASE_PORT: Mutex<String> = Mutex::new(String::new());
    static  ref DATABASE_USERNAME: Mutex<String> = Mutex::new(String::new());
    static  ref DATABASE_PASSWORD: Mutex<String> = Mutex::new(String::new());
    static  ref DATABASE_DATABASE: Mutex<String> = Mutex::new(String::new());
}