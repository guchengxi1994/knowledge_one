use sqlx::types::chrono;

use super::file::FileDetails;

#[derive(Clone, Debug, sqlx::FromRow)]
pub struct FileChangelog {
    pub changelog_id: i64,
    pub file_id: i64,
    pub version_id: Option<String>,
    pub prev_version_id: Option<String>,
    pub is_deleted: i64,
    pub create_at: chrono::DateTime<chrono::Utc>,
    pub update_at: chrono::DateTime<chrono::Utc>,
    pub file_length: i64,
    pub file_path: Option<String>,
    pub diff_path: Option<String>,
}

impl FileChangelog {
    #[tokio::main]
    pub async fn get_filelogs_by_file_hash(file_hash: String) -> Option<Vec<FileChangelog>> {
        let pool = crate::database::sqlx_connection::POOL.read().await;
        let sql = sqlx::query_as::<sqlx::MySql, FileDetails>(
            r#"SELECT * FROM FILE WHERE file_hash=? and is_deleted=0"#,
        )
        .bind(file_hash)
        .fetch_one(pool.get_pool())
        .await;

        match sql {
            Ok(s) => {
                let file_id = s.file_id;
                let r = sqlx::query_as::<sqlx::MySql, FileChangelog>(
                    r#"SELECT * FROM file_changelog WHERE file_id=? and is_deleted=0"#,
                )
                .bind(file_id)
                .fetch_all(pool.get_pool())
                .await;
                match r {
                    Ok(rs) => {
                        return Some(rs);
                    }
                    Err(e) => {
                        println!("{:?}", e);
                        return None;
                    }
                }
            }
            Err(e) => {
                println!("{:?}", e);
                return None;
            }
        }
    }

    #[tokio::main]
    pub async fn get_filelogs_by_id_after_some_file_hash(
        id: i64,
        file_hash: String,
    ) -> Option<Vec<FileChangelog>> {
        let pool = crate::database::sqlx_connection::POOL.read().await;
        let sql = sqlx::query_as::<sqlx::MySql, FileChangelog>(
            r#"SELECT * FROM file_changelog WHERE file_id=? and is_deleted=0"#,
        )
        .bind(id)
        .fetch_all(pool.get_pool())
        .await;

        match sql {
            Ok(s) => {
                let mut id = 0;
                for i in 0..s.len() {
                    let this_file_hash = &s[i].version_id;
                    match this_file_hash {
                        None => {
                            continue;
                        }
                        Some(tfh) => {
                            if tfh.eq(&file_hash) {
                                id = i;
                                break;
                            }
                        }
                    }
                }

                let mut sv: Vec<FileChangelog> = Vec::new();
                for i in id..s.len() {
                    sv.push(s[i].clone());
                }
                return Some(sv);
            }
            Err(_) => {
                return None;
            }
        }
    }
}

#[derive(Clone, Debug)]
pub struct NativeFileNewVersion {
    pub prev_file_path: String,
    // version id
    pub prev_file_hash: String,
    pub prev_file_name: String,
    // mtx
    pub new_version_file_path: String,
    // new version id
    pub new_version_file_hash: String,
    pub new_version_file_name: String,
    pub diff_path: Option<String>,
}

impl NativeFileNewVersion {
    #[tokio::main]
    pub async fn create_new_version(self) -> i64 {
        let pool = crate::database::sqlx_connection::POOL.read().await;
        let mut tx = pool.get_pool().begin().await.unwrap();
        let sql = sqlx::query_as::<sqlx::MySql, FileDetails>(
            r#"SELECT * FROM FILE WHERE file_hash=? and is_deleted=0"#,
        )
        .bind(self.prev_file_hash.clone())
        .fetch_one(pool.get_pool())
        .await;

        match sql {
            Ok(s) => {
                // println!("{}", sql.unwrap().file_id);
                let file_id = s.file_id;
                // println!("{}", file_id);

                let file_path = self.new_version_file_path.clone();

                let file_size = crate::storage::file_size::get_file_size(file_path);
                let _ = sqlx::query(
            r#"INSERT INTO file_changelog (file_id,version_id,prev_version_id,file_length,file_path,diff_path) VALUES(?,?,?,?,?,?) "#,
        ).bind(file_id).bind(self.new_version_file_hash.clone()).bind(self.prev_file_hash.clone()).bind(file_size).bind(self.new_version_file_path.clone()).bind(self.diff_path.clone()).execute(&mut tx).await;

                let _ = sqlx::query(
                    r#"UPDATE file SET file_hash = ?,file_name=?,file_path=? WHERE file_id=? "#,
                )
                .bind(self.new_version_file_hash.clone())
                .bind(self.new_version_file_name.clone())
                .bind(self.new_version_file_path.clone())
                .bind(file_id)
                .execute(&mut tx)
                .await;
                let r = tx.commit().await;
                match r {
                    Ok(_) => 0,
                    Err(e) => {
                        println!("{:?}", e);
                        return 1;
                    }
                }
            }
            Err(e) => {
                println!("{:?}", e);
                return 1;
            }
        }
    }
}
