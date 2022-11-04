use crate::database::model;
use crate::{
    database::{connection::init_mysql_db, load_config::load_config},
    storage, DATABASE_ADDR, DATABASE_DATABASE, DATABASE_PASSWORD, DATABASE_PORT, DATABASE_USERNAME,
};
use anyhow::{self, Ok};
use futures::executor::block_on;
use std::sync::atomic::{AtomicU64, Ordering};

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

pub fn init_mysql(conf_path: String) {
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


pub fn init_mysql2(conf_path: String) {
    let info = load_config(&conf_path);

    let url = format!(
        "mysql://{}:{}@{}:{}/{}",
        info.username, info.password, info.address, info.port, info.database
    );
    crate::database::sqlx_connection::init(url);
}

pub fn get_status_types() -> Vec<model::todo_status::TodoStatus> {
    let t = model::todo_status::TodoStatus::get_all_status_types();
    t
}

pub fn get_todos() -> Vec<model::todo::TodoDetails> {
    // model::todo::TodoDetails::get_all()
    block_on(async {
        model::todo::TodoDetails::get_all()
    })
}

pub fn get_files() -> Vec<model::file::FileDetails> {
    model::file::FileDetails::get_all_file_details()
}

// pub async fn new_file(mut f: model::file::NativeFileSummary) -> i64 {
//     let reuslt = f.create_new_file();
//     reuslt.await
// }

pub fn test_sqlx() -> anyhow::Result<Vec<model::todo_status::TodoStatus>> {
    block_on(async {
        let data = get_test_sqlx();
        Ok(data)
    })
}

#[tokio::main]
async fn get_test_sqlx() -> Vec<model::todo_status::TodoStatus> {
    let result = model::todo_status::TodoStatus::sqlx_test().await;
    return result;
}
