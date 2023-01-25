use std::fs;

use serde::{Deserialize, Serialize};
use sqlx::{types::chrono, MySql};

use crate::{
    constants::{FILE_ALREADY_EXISTS_WHEN_CREATION, FILE_DETAILS_ALREADY_EXISTS_WHEN_CREATION},
    storage::file_hash::get_file_hash,
};

use super::changelog::FileChangelog;

#[derive(Clone, Debug, sqlx::FromRow)]
pub struct FileDetails {
    pub file_id: i64,
    pub file_name: Option<String>,
    pub file_path: Option<String>,
    pub is_deleted: i64,
    pub create_at: chrono::DateTime<chrono::Utc>,
    pub update_at: chrono::DateTime<chrono::Utc>,
    pub file_hash: Option<String>,
    pub version_control: i64,
}

#[derive(Clone, Debug, Serialize, Deserialize)]
pub struct NativeFileSummary {
    pub file_name: Option<String>,
    pub file_path: Option<String>,
    pub file_hash: Option<String>,
    pub version_control: i64,
}

#[tokio::main]
pub async fn change_file_hash_by_id(
    ori_file_path: String,
    file_path: String,
    file_id: i64,
    diff_path: Option<String>,
) -> String {
    println!("rust {:?}", ori_file_path);
    println!("rust {:?}", file_path);
    println!("rust {:?}", file_id);
    println!("rust {:?}", diff_path);

    let file_hash = get_file_hash(file_path.clone());
    let pool = crate::database::sqlx_connection::POOL.read().await;

    let f = sqlx::query_as::<MySql, FileDetails>(r#"SELECT * FROM file  WHERE file_id=? "#)
        .bind(file_id)
        .fetch_one(pool.get_pool())
        .await;

    match f {
        Err(e) => {
            println!("{:?}", e);
            return String::from("");
        }
        Ok(fi) => {
            let c = fs::copy(file_path.clone(), ori_file_path);

            match c {
                Ok(_) => {
                    let mut tx = pool.get_pool().begin().await.unwrap();
                    if fi.version_control == 1 {
                        // 添加一条新版本
                        let d_p: String;
                        match diff_path {
                            None => {
                                d_p = String::from("");
                            }
                            Some(p) => {
                                d_p = p;
                            }
                        }

                        let file_size = crate::storage::file_size::get_file_size(file_path.clone());

                        let _ = sqlx::query(
                        r#"INSERT INTO file_changelog (file_id,version_id,prev_version_id,file_length,file_path,diff_path) VALUES(?,?,?,?,?,?) "#,
                    ).bind(file_id).bind(file_hash.clone()).bind(fi.file_hash.clone()).bind(file_size).bind(fi.file_path.unwrap().clone()).bind(d_p.clone()).execute(&mut tx).await;
                    }
                    let _ = sqlx::query(r#"UPDATE file SET file_hash = ? WHERE file_id=? "#)
                        .bind(file_hash.clone())
                        .bind(file_id)
                        .execute(&mut tx)
                        .await;
                    let r = tx.commit().await;

                    match r {
                        Ok(_) => String::from(file_hash),
                        Err(_) => String::from(""),
                    }
                }
                Err(e) => {
                    println!("rust error {:?}", e);
                    return String::from("");
                }
            }
        }
    }
}

#[tokio::main]
pub async fn delete_file_by_file_hash(file_hash: String) -> i64 {
    let pool = crate::database::sqlx_connection::POOL.read().await;
    let file = sqlx::query_as::<sqlx::MySql, FileDetails>(
        r#"SELECT * from file WHERE is_deleted=0 and file_hash=?"#,
    )
    .bind(&file_hash)
    .fetch_one(pool.get_pool())
    .await;
    match file {
        Ok(f) => {
            let mut tx = pool.get_pool().begin().await.unwrap();
            let _ = sqlx::query(r#"UPDATE file SET is_deleted = 1 WHERE file_id=? "#)
                .bind(f.file_id)
                .execute(&mut tx)
                .await;
            let _ = sqlx::query(r#"UPDATE file_changelog SET is_deleted = 1 WHERE file_id=? "#)
                .bind(f.file_id)
                .execute(&mut tx)
                .await;
            let result = tx.commit().await;
            match result {
                Err(_) => {
                    // println!("{:?}",err);
                    return 1;
                }
                Ok(_) => {
                    return 0;
                }
            }
        }
        Err(_) => {
            // println!("{:?}",err);
            return 1;
        }
    }
}

#[tokio::main]
pub async fn set_version_control_by_file_hash(file_hash: String) -> i64 {
    let pool = crate::database::sqlx_connection::POOL.read().await;

    let file = sqlx::query_as::<sqlx::MySql, FileDetails>(
        r#"SELECT * from file WHERE is_deleted=0 and file_hash=?"#,
    )
    .bind(&file_hash)
    .fetch_one(pool.get_pool())
    .await;

    match file {
        Ok(f) => {
            let file_path = f.file_path.unwrap();
            let file_size = crate::storage::file_size::get_file_size(file_path.clone());

            let mut tx = pool.get_pool().begin().await.unwrap();
            let _ = sqlx::query(
                        r#"INSERT INTO file_changelog (file_id,version_id,prev_version_id,file_length,file_path) VALUES(?,?,?,?,?) "#,
                    ).bind(f.file_id).bind(&file_hash).bind("").bind(file_size).bind(&file_path).execute(&mut tx).await;
            let _ = sqlx::query(r#"UPDATE file SET version_control = 1 WHERE file_hash=? "#)
                .bind(&file_hash)
                .execute(&mut tx)
                .await;

            let result = tx.commit().await;

            match result {
                Ok(_) => {
                    return 0;
                }
                Err(_) => {
                    return 1;
                }
            }
        }
        Err(_) => {
            return 1;
        }
    }
}

impl FileDetails {
    #[tokio::main]
    pub async fn get_all_file_details() -> Vec<FileDetails> {
        let pool = crate::database::sqlx_connection::POOL.read().await;
        let results = sqlx::query_as::<sqlx::MySql,FileDetails>(r#"SELECT file_id,file_name,file_path,file_hash,create_at,version_control from file WHERE is_deleted=0"#).fetch_all(pool.get_pool()).await;
        results.unwrap()
    }
}

impl NativeFileSummary {
    #[tokio::main]
    pub async fn create_new_file(&mut self) -> i64 {
        match self.file_path.clone() {
            Some(e) => {
                let pool = crate::database::sqlx_connection::POOL.read().await;
                let file_hash: String;
                match &self.file_hash {
                    Some(s) => {
                        file_hash = s.clone();
                    }
                    None => {
                        file_hash = crate::storage::file_hash::get_file_hash(e);
                    }
                }

                if file_hash != "" {
                    let logs = sqlx::query_as::<sqlx::MySql, FileChangelog>(
                        r#"SELECT * from file_changelog WHERE is_deleted=0 and version_id=?"#,
                    )
                    .bind(&file_hash)
                    .fetch_all(pool.get_pool())
                    .await
                    .unwrap();

                    if logs.len() > 0 {
                        return FILE_ALREADY_EXISTS_WHEN_CREATION;
                    }

                    let results = sqlx::query_as::<sqlx::MySql, FileDetails>(
                        r#"SELECT * from file WHERE is_deleted=0 and file_hash=?"#,
                    )
                    .bind(&file_hash)
                    .fetch_all(pool.get_pool())
                    .await;
                    match results {
                        Ok(result) => {
                            if result.len() > 0 {
                                return FILE_DETAILS_ALREADY_EXISTS_WHEN_CREATION;
                            } else {
                                let sql = sqlx::query(
                                    r#"INSERT INTO file (file_name,file_path,file_hash) VALUES(?,?,?) "#,
                                )
                                .bind(self.file_name.clone())
                                .bind(self.file_path.clone())
                                .bind(file_hash)
                                .execute(pool.get_pool())
                                .await;
                                match sql {
                                    Ok(result) => {
                                        // println!("{:?}",result);
                                        return result.last_insert_id() as i64;
                                    }
                                    Err(_) => {
                                        // println!("{:?}",err);
                                        return 0;
                                    }
                                }
                            }
                        }
                        Err(_) => {
                            return 0;
                        }
                    }
                } else {
                    return 0;
                }
            }
            None => {
                return 0;
            }
        }
    }
}
