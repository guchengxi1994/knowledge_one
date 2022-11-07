use serde::{Deserialize, Serialize};

#[derive(Clone, Debug, Serialize, Deserialize, sqlx::FromRow)]
pub struct  FileChangelog{
    pub changelog_id:i64,
    pub file_id:i64,
    pub version_id:String,
    pub prev_version_id:String,
    pub is_deleted:i64,
    pub create_at:Option<String>,
    pub update_at:Option<String>,
    pub file_length:i64
}