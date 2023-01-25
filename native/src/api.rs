use crate::{
    constants::*,
    database::{
        engine::create_tables,
        load_config::{load_app_config, load_config, AppConfig},
        model::{
            self,
            operation_log::{OperationLog, OperationLogSummary},
        },
    },
    storage,
    svg::{file_cleaner, string_cleaner, CleanerResult},
};
use futures::executor::block_on;

pub fn create_all_directory(s: String) {
    storage::create_folder::create_cache_dir(s.clone());
    storage::create_folder::create_diff_dir(s.clone());
    storage::create_folder::create_restore_dir(s.clone());
    storage::create_folder::create_storage_dir(s.clone());
}

/// 获取faker locale
#[deprecated]
pub fn get_faker_locale(config_path: String) -> Vec<String> {
    let r = load_app_config(config_path);
    match r {
        Some(r0) => {
            return r0.faker_supported_locales;
        }
        None => {
            return Vec::new();
        }
    }
}

/// 获取所有Config
pub fn get_app_config(config_path: String) -> Option<AppConfig> {
    load_app_config(config_path)
}

/// 根据file_id 和hash值获取修改的changelog
pub fn get_changelog_from_id(
    id: i64,
    file_hash: String,
) -> Option<Vec<crate::database::model::changelog::FileChangelog>> {
    block_on(async {
        crate::database::model::changelog::FileChangelog::get_filelogs_by_id_after_some_file_hash(
            id, file_hash,
        )
    })
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
pub fn create_new_version(model: crate::database::model::changelog::NativeFileNewVersion) -> i64 {
    block_on(async { model.create_new_version() })
}

/// 创建一个物理文件
pub fn create_new_disk_file(file_path: String) -> i64 {
    crate::storage::create_file::create_file(file_path)
}

/// 根据现在的hash值获取变更记录
pub fn get_file_logs(
    file_hash: String,
) -> Option<Vec<crate::database::model::changelog::FileChangelog>> {
    block_on(async {
        crate::database::model::changelog::FileChangelog::get_filelogs_by_file_hash(file_hash)
    })
}

/// 根据文件id修改文件hash
pub fn change_file_hash_by_id(
    ori_file_path: String,
    file_path: String,
    file_id: i64,
    diff_path: Option<String>,
) -> String {
    block_on(async {
        crate::database::model::file::change_file_hash_by_id(
            ori_file_path,
            file_path,
            file_id,
            diff_path,
        )
    })
}

/// 初始化数据库，创建数据库连接池
pub fn init_database(conf_path: String, is_first_time: bool) -> i64 {
    let info = load_config(&conf_path);

    match info {
        Some(s) => {
            if s.db_type == "mysql" {
                let url = format!(
                    "mysql://{}:{}@{}:{}/{}",
                    s.database.username,
                    s.database.password,
                    s.database.address,
                    s.database.port,
                    s.database.database
                );
                crate::database::sqlx_connection::init(url);
            }

            if s.db_type == "sqlite" {}

            if is_first_time {
                let r = create_tables_in_the_beginning(s.db_type);
                println!("rust result {:?}", r);
            }

            return DATABASE_INIT_OK;
        }
        None => DATABASE_INIT_FILE_NOT_FOUND,
    }
}

fn create_tables_in_the_beginning(db_type: String) -> i64 {
    block_on(async { create_tables(db_type) })
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

/// svg_cleaner for file
pub fn clean_svg_file(file_path: String) -> Option<CleanerResult> {
    file_cleaner(file_path)
}

/// svg_cleaner for string
pub fn clean_svg_string(content: String) -> Option<CleanerResult> {
    string_cleaner(content)
}

/// operation logs
pub fn insert_a_new_log(mut log: OperationLogSummary) -> i64 {
    log.insert_new_log()
}

pub fn query_all_operation_logs() -> Vec<OperationLog> {
    OperationLog::get_all_operation_logs()
}
