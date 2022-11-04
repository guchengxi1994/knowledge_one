use serde::{Deserialize, Serialize};

#[derive(Clone, Debug, Serialize, Deserialize)]
pub struct Todo {
    pub todo_id: i64,
    pub task_id: i64,
    pub todo_name: Option<String>,
    pub todo_content: Option<String>,
    pub todo_status_id: i64,
    pub todo_from: Option<String>,
    pub todo_to: Option<String>,
    pub is_deleted: i64,
    pub create_at: Option<String>,
    pub update_at: Option<String>,
}

#[derive(Clone, Debug, Serialize, Deserialize, sqlx::FromRow)]
pub struct TodoDetails {
    pub todo_id: i64,
    pub todo_name: Option<String>,
    pub todo_content: Option<String>,
    pub todo_status_name: Option<String>,
    pub todo_from: Option<String>,
    pub todo_to: Option<String>,
    pub task_name: Option<String>,
    pub task_id: i64,
    pub todo_status_color: Option<String>,
}

impl TodoDetails {
    #[tokio::main]
    pub async fn get_all() -> Vec<TodoDetails> {
        let pool = crate::database::sqlx_connection::POOL.read().await;

        let result = sqlx::query_as::<sqlx::MySql, TodoDetails>(
            r#"SELECT
            t1.todo_id,
            t1.todo_name,
            t1.todo_content,
            t2.todo_status_name,
            t1.todo_from,
            t1.todo_to,
            t3.task_name,
            t3.task_id,
            t2.todo_status_color  
        FROM
            todo AS t1
            LEFT JOIN todo_status AS t2 ON t2.todo_status_id = t1.todo_status_id
            LEFT JOIN task AS t3 ON t3.task_id = t1.task_id 
        WHERE
            t1.is_deleted = 0 
            AND t3.is_deleted = 0
        "#,
        )
        .fetch_all(pool.get_pool())
        .await;

        return result.unwrap();
    }
}
