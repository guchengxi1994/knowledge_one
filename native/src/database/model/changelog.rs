use sqlx::types::chrono;

#[derive(Clone, Debug, sqlx::FromRow)]
pub struct  FileChangelog{
    pub changelog_id:i64,
    pub file_id:i64,
    pub version_id:Option<String>,
    pub prev_version_id:Option<String>,
    pub is_deleted:i64,
    pub create_at:chrono::DateTime<chrono::Utc>,
    pub update_at:chrono::DateTime<chrono::Utc>,
    pub file_length:i64,
    pub file_path:Option<String>
}

#[derive(Clone, Debug)]
pub struct NativeFileNewVersion{
    pub prev_file_path:String,
    // version id
    pub prev_file_hash:String,
    pub prev_file_name:String,
    // mtx
    pub new_version_file_path:String,
    // new version id
    pub new_version_file_hash:String,
    pub new_version_file_name:String
}

impl NativeFileNewVersion {
    #[tokio::main]
    pub async fn create_new_version(self) {
        let file_path = self.new_version_file_path.clone();
        let pool = crate::database::sqlx_connection::POOL.read().await;
        let mut tx = pool.get_pool().begin().await.unwrap();
        let file_size = crate::storage::file_size::get_file_size(file_path);
    }
}