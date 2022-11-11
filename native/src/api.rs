use crate::{
    database::{load_config::load_config, model},
    storage,
};
use futures::executor::block_on;

pub fn create_storage_directory(s: String) -> i32 {
    storage::create_folder::create_storage_dir(s)
}

pub fn create_diff_directory(s: String) -> i32 {
    storage::create_folder::create_diff_dir(s)
}

pub fn create_restore_directory(s: String) -> i32 {
    storage::create_folder::create_restore_dir(s)
}

/// 获取文件hash值
pub fn get_file_hash(file_path: String) -> String {
    crate::storage::file_hash::get_file_hash(file_path)
}

/// 根据文件hash值软删除文件
pub fn delete_file_by_file_hash(file_hash: String) -> i64 {
    block_on(async { model::file::delete_file_by_file_hash(file_hash) })
}

/// 改变版本控制
pub fn change_version_control(file_hash: String) -> i64 {
    block_on(async { model::file::set_version_control_by_file_hash(file_hash) })
}

/// 手动更新新版本 （右键绑定新版本）
pub fn create_new_version(model:crate::database::model::changelog::NativeFileNewVersion)->i64{
    block_on(async {
        model.create_new_version()
    })  
}

/// 根据现在的hash值获取变更记录
pub fn get_file_logs(file_hash:String)->Option<Vec<crate::database::model::changelog::FileChangelog>>{
    block_on(async {
        crate::database::model::changelog::FileChangelog::get_filelogs_by_file_hash(file_hash)
    })
}

/// 初始化数据库，创建数据库连接池
pub fn init_mysql(conf_path: String) {
    let info = load_config(&conf_path);

    let url = format!(
        "mysql://{}:{}@{}:{}/{}",
        info.username, info.password, info.address, info.port, info.database
    );
    crate::database::sqlx_connection::init(url);
}

/// 获取所有状态
pub fn get_status_types() -> Vec<model::todo_status::TodoStatus> {
    block_on(async {
        let data = get_todustatus();
        data
    })
}

/// 获取所有todo
pub fn get_todos() -> Vec<model::todo::TodoDetails> {
    // model::todo::TodoDetails::get_all()
    block_on(async { model::todo::TodoDetails::get_all() })
}

/// 获取所有文件
pub fn get_files() -> Vec<model::file::FileDetails> {
    model::file::FileDetails::get_all_file_details()
}

/// 创建文件
pub fn new_file(mut f: model::file::NativeFileSummary) -> i64 {
    block_on(async { f.create_new_file() })
}

#[tokio::main]
async fn get_todustatus() -> Vec<model::todo_status::TodoStatus> {
    let result = model::todo_status::TodoStatus::get_all_status_types().await;
    return result;
}
