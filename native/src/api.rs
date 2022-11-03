use crate::{
    database::{connection::init_mysql_db, load_config::load_config},
    storage, DATABASE_ADDR, DATABASE_DATABASE, DATABASE_PASSWORD, DATABASE_PORT, DATABASE_USERNAME,
};
use std::sync::atomic::{AtomicU64, Ordering};
use crate::database::model;

pub fn main() {
    println!("Hello from native!");
}

static COUNTER: AtomicU64 = AtomicU64::new(0);

pub fn get_counter() -> u64 {
    COUNTER.load(Ordering::SeqCst)
}

pub fn increment() -> u64 {
    COUNTER.fetch_add(1, Ordering::SeqCst);
    COUNTER.load(Ordering::SeqCst)
}

pub fn decrement() -> u64 {
    COUNTER.fetch_sub(1, Ordering::SeqCst);
    COUNTER.load(Ordering::SeqCst)
}

pub fn create_storage_directory(s: String) -> i32 {
    storage::create_folder::create_storage_dir(s)
}

pub fn init_mysql(conf_path:String) {
    let info = load_config(&conf_path);

    DATABASE_ADDR
        .lock()
        .unwrap()
        .push_str(&format!("{}", info.address));
    DATABASE_PORT
        .lock()
        .unwrap()
        .push_str(&format!("{}", info.port));
    DATABASE_USERNAME
        .lock()
        .unwrap()
        .push_str(&format!("{}", info.username));
    DATABASE_PASSWORD
        .lock()
        .unwrap()
        .push_str(&format!("{}", info.password));
    DATABASE_DATABASE
        .lock()
        .unwrap()
        .push_str(&format!("{}", info.database));
    init_mysql_db();
}


pub fn get_status_types() ->Vec<String>{
    let t = model::todo_status::TodoStatus::get_all_status_types();
    let mut res:Vec<String> = Vec::new();
    for v in t {
        res.push(v.todo_status_name.unwrap());
    } 
    res
}