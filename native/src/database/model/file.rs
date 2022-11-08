use serde::{Deserialize, Serialize};
use sqlx::types::chrono;

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
pub async fn delete_file_by_file_hash(file_hash: String) -> i64 {
    let pool = crate::database::sqlx_connection::POOL.read().await;
    let sql = sqlx::query(r#"UPDATE file SET is_deleted = 1 WHERE file_hash=? "#)
        .bind(file_hash)
        .execute(pool.get_pool())
        .await;
    match sql {
        Ok(_) => {
            // println!("{:?}",result);
            return 0;
        }
        Err(_) => {
            // println!("{:?}",err);
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
                    let results = sqlx::query_as::<sqlx::MySql, FileDetails>(
                        r#"SELECT * from file WHERE is_deleted=0 and file_hash=?"#,
                    )
                    .bind(&file_hash)
                    .fetch_all(pool.get_pool())
                    .await;
                    match results {
                        Ok(result) => {
                            if result.len() > 0 {
                                return -1;
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
