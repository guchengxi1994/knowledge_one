use serde::{Deserialize, Serialize};

#[derive(Clone, Debug,Serialize,Deserialize)]
pub struct  Todo{
    pub todo_id:i64,
    pub task_id:i64,
    pub todo_name:Option<String>,
    pub todo_status_id:i64,
    pub todo_from:Option<String>,
    pub todo_to:Option<String>,
    pub is_deleted:i64,
    pub create_at:Option<String>,
    pub update_at:Option<String>
}