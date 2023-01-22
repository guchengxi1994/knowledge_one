use sqlx::types::chrono;

use crate::constants::{OPERATION_LOG_INSERT_ERROR, OPERATION_LOG_INSERT_OK};

#[derive(Clone, Debug, sqlx::FromRow)]
pub struct OperationLog {
    pub operation_content: String,
    pub operation_name: String,
    pub operation_id: i64,
    pub create_at: chrono::DateTime<chrono::Utc>,
}

#[derive(Clone, Debug, sqlx::FromRow)]
pub struct OperationLogSummary {
    pub operation_content: String,
    pub operation_name: String,
}

impl OperationLogSummary {
    #[tokio::main]
    pub async fn insert_new_log(&mut self) -> i64 {
        let pool = crate::database::sqlx_connection::POOL.read().await;
        let sql = sqlx::query(
            r#"INSERT INTO operation_log (operation_content,operation_name) values(?,?)"#,
        )
        .bind(self.operation_content.clone())
        .bind(self.operation_name.clone())
        .execute(pool.get_pool())
        .await;

        match sql {
            Ok(_) => {
                // println!("{:?}",result);
                return OPERATION_LOG_INSERT_OK;
            }
            Err(_) => {
                // println!("{:?}",err);
                return OPERATION_LOG_INSERT_ERROR;
            }
        }
    }
}

impl OperationLog {
    #[tokio::main]
    pub async fn get_all_operation_logs() -> Vec<OperationLog> {
        let pool = crate::database::sqlx_connection::POOL.read().await;
        let results = sqlx::query_as::<sqlx::MySql, OperationLog>(
            r#"SELECT operation_content,operation_name,operation_id,create_at from operation_log"#,
        )
        .fetch_all(pool.get_pool())
        .await;
        results.unwrap()
    }
}
