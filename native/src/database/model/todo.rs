use crate::database::connection::get_mysql_conn_pool;
use mysql::prelude::Queryable;
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

#[derive(Clone, Debug, Serialize, Deserialize)]
pub struct TodoDetails {
    pub todo_id: i64,
    pub todo_name: Option<String>,
    pub todo_content: Option<String>,
    pub todo_status_name: Option<String>,
    pub todo_from: Option<String>,
    pub todo_to: Option<String>,
    pub task_name: Option<String>,
    pub task_id: i64,
    pub todo_status_color:Option<String>
}

impl TodoDetails {
    pub fn get_all() -> Vec<TodoDetails> {
        let pool = get_mysql_conn_pool().unwrap();
        let mut conn = pool.get_conn().unwrap();
        let results = conn.query_map(
            "SELECT
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
        AND t3.is_deleted = 0",
            |(
                todo_id,
                todo_name,
                todo_content,
                todo_status_name,
                todo_from,
                todo_to,
                task_name,
                task_id,
                todo_status_color
            )| {
                TodoDetails {
                    todo_id: todo_id,
                    todo_name: todo_name,
                    todo_content: todo_content,
                    todo_status_name: todo_status_name,
                    todo_from: todo_from,
                    todo_to: todo_to,
                    task_name: task_name,
                    task_id: task_id,
                    todo_status_color:todo_status_color
                }
            },
        );

        results.unwrap()
    }
}
