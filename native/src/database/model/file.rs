use serde::{Deserialize, Serialize};

#[derive(Clone, Debug, Serialize, Deserialize, sqlx::FromRow)]
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
    #[tokio::main]
    pub async fn get_all_file_details() -> Vec<FileDetails> {
        let pool = crate::database::sqlx_connection::POOL.read().await;
        let results = sqlx::query_as::<sqlx::MySql,FileDetails>(r#"SELECT file_id,file_name,file_path,file_hash,create_at fron file WHERE is_deleted=0"#).fetch_all(pool.get_pool()).await;
        results.unwrap()
    }
}

impl NativeFileSummary {
    #[tokio::main]
    pub async fn create_new_file(&mut self) -> u64 {
        match self.file_path.clone() {
            Some(e) => {
                let pool = crate::database::sqlx_connection::POOL.read().await;
                let file_hash = crate::storage::file_hash::get_file_hash(e);
                if file_hash != "" {
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
                            return result.last_insert_id();
                        },
                        Err(_) => {
                            // println!("{:?}",err);
                            return  0;
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
