use sqlx::types::chrono;

#[derive(Clone, Debug, sqlx::FromRow)]
pub struct  FileChangelog{
    pub changelog_id:i64,
    pub file_id:i64,
    pub version_id:String,
    pub prev_version_id:String,
    pub is_deleted:i64,
    pub create_at:chrono::DateTime<chrono::Utc>,
    pub update_at:chrono::DateTime<chrono::Utc>,
    pub file_length:i64,
    pub file_path:Option<String>
}