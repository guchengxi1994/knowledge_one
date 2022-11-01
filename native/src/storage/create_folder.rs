use std::fs;
use std::path::Path;

const STORAGE_FOLDER_NAME: &str = "_private";

pub fn create_storage_dir(base_path: String) -> i32 {
    let exists = Path::new(&(base_path.clone() + "/" + STORAGE_FOLDER_NAME)).exists();
    if exists {
        return 0;
    }

    let result = fs::create_dir(base_path + "/" + STORAGE_FOLDER_NAME);
    match result {
        Ok(_) => 0,
        Err(_) => 1,
    }
}
