use std::sync::atomic::{AtomicU64,Ordering};
use crate::storage;

pub fn main() {
    println!("Hello from native!");
}

static COUNTER:AtomicU64 = AtomicU64::new(0);

pub fn get_counter() -> u64{
    COUNTER.load(Ordering::SeqCst)
}

pub fn increment() -> u64{
    COUNTER.fetch_add(1, Ordering::SeqCst);
    COUNTER.load(Ordering::SeqCst)
}

pub fn decrement() -> u64{
    COUNTER.fetch_sub(1, Ordering::SeqCst);
    COUNTER.load(Ordering::SeqCst)
}

pub fn create_storage_directory(s:String)->i32{
    storage::create_folder::create_storage_dir(s)
}