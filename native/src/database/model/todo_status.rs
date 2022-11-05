use serde::{Deserialize, Serialize};
use sqlx;

#[derive(Clone, Debug, Serialize, Deserialize,sqlx::FromRow)]
pub struct TodoStatus {
    pub todo_status_id: i64,
    pub todo_status_name: Option<String>,
    pub todo_status_color: Option<String>,
}

impl TodoStatus {
    pub async fn get_all_status_types()->Vec<TodoStatus>{
        let pool = crate::database::sqlx_connection::POOL.read().await;
        // "SELECT todo_status_id,todo_status_name,todo_status_color from todo_status"
        let result = sqlx::query_as::<sqlx::MySql,TodoStatus>(r#"SELECT todo_status_id,todo_status_name,todo_status_color from todo_status"#).fetch_all(pool.get_pool()).await;
        result.unwrap()   
    }
}



