use crate::database::connection::get_mysql_conn_pool;
use mysql::{ prelude::Queryable};
use serde::{Deserialize, Serialize};

#[derive(Clone, Debug, Serialize, Deserialize)]
pub struct FileDetails {
    pub file_id: i64,
    pub file_name: Option<String>,
    pub file_path: Option<String>,
    pub is_deleted: i64,
    pub create_at: Option<String>,
    pub update_at: Option<String>,
    pub file_hash: Option<String>,
}

#[derive(Clone, Debug, Serialize, Deserialize)]
pub struct NativeFileSummary {
    pub file_name: Option<String>,
    pub file_path: Option<String>,
}

impl FileDetails {
    pub fn get_all_file_details() -> Vec<FileDetails> {
        let pool = get_mysql_conn_pool().unwrap();
        let mut conn = pool.get_conn().unwrap();
        let results = conn.query_map(
            "SELECT file_id,file_name,file_path,file_hash,create_at fron file WHERE is_deleted=0",
            |(file_id, file_name, file_path, file_hash, create_at, update_at)| FileDetails {
                file_id,
                file_name,
                file_path,
                is_deleted: 0,
                create_at: create_at,
                update_at: update_at,
                file_hash,
            },
        );

        results.unwrap()
    }
}

impl NativeFileSummary {
    pub fn create_new_file(&mut self) -> i64 {
        match self.file_path.clone() {
            Some(e) => {
                let pool = get_mysql_conn_pool().unwrap();
                let mut conn = pool.get_conn().unwrap();
                let file_hash = crate::storage::file_hash::get_file_hash(e);
                if file_hash != "" {
                    let p = conn
                        .prep("INSERT INTO file (file_name,file_path,file_hash) VALUES(?,?,?) ")
                        .unwrap();
                    let r = conn
                        .exec_drop(
                            p,
                            (self.file_name.clone(), self.file_path.clone(), file_hash),
                        )
                        .is_ok();
                    if r {
                        return 0;
                    } else {
                        return 1;
                    }
                } else {
                    return 1;
                }
                
            }
            None => {
                return 1;
            }
        }
    }
}
