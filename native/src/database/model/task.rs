use serde::{Deserialize, Serialize};

#[derive(Clone, Debug,Serialize,Deserialize)]
pub struct Task{
    pub task_id:i64,
    pub task_name:Option<String>,
    pub is_deleted:i64,
    pub create_at:Option<String>,
    pub update_at:Option<String>
}