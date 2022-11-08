use sqlx::types::chrono;

#[derive(Clone, Debug)]
pub struct Task{
    pub task_id:i64,
    pub task_name:Option<String>,
    pub is_deleted:i64,
    pub create_at:chrono::DateTime<chrono::Utc>,
    pub update_at:chrono::DateTime<chrono::Utc>
}