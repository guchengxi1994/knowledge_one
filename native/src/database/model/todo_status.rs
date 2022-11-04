use mysql::prelude::Queryable;
use serde::{Deserialize, Serialize};

use crate::database::connection::get_mysql_conn_pool;

#[derive(Clone, Debug, Serialize, Deserialize)]
pub struct TodoStatus {
    pub todo_status_id: i64,
    pub todo_status_name: Option<String>,
    pub todo_status_color: Option<String>,
}

impl TodoStatus {
    pub fn get_all_status_types() -> Vec<TodoStatus> {
        let pool = get_mysql_conn_pool().unwrap();
        let mut conn = pool.get_conn().unwrap();
        let results = conn.query_map(
            "SELECT todo_status_id,todo_status_name,todo_status_color from todo_status",
            |(todo_status_id, todo_status_name, todo_status_color)| TodoStatus {
                todo_status_id: todo_status_id,
                todo_status_name: todo_status_name,
                todo_status_color: todo_status_color,
            },
        );
        results.unwrap()
    }
}
