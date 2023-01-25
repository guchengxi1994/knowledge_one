use crate::constants::{DATABASE_TABLE_CREATION_FAIL, DATABASE_TABLE_CREATION_SUCCESS};

#[tokio::main]
pub async fn create_tables(db_type: String) -> i64 {
    if db_type == String::from("mysql") {
        let pool = crate::database::sqlx_connection::POOL.read().await;

        let r = sqlx::query(CREATE_FILE_MYSQL)
            .execute(pool.get_pool())
            .await;
        let r2 = sqlx::query(CREATE_FILE_CHANGELOG_MYSQL)
            .execute(pool.get_pool())
            .await;

        match (r, r2) {
            (Ok(_), Ok(_)) => {
                return DATABASE_TABLE_CREATION_SUCCESS;
            }
            (Ok(_), Err(e)) => {
                println!("create table failed : {:?}",e);
                return DATABASE_TABLE_CREATION_FAIL;
            }
            (Err(e), Ok(_)) => {
                println!("create table failed : {:?}",e);
                return DATABASE_TABLE_CREATION_FAIL;
            }
            (Err(e1), Err(e2)) => {
                println!("create table failed : {:?}",e1);
                println!("create table failed : {:?}",e2);
                return DATABASE_TABLE_CREATION_FAIL;
            }
        }
    }

    if db_type == String::from("sqlite") {}

    DATABASE_TABLE_CREATION_FAIL
}

const CREATE_FILE_MYSQL:&'static str = "
CREATE TABLE  IF NOT EXISTS  `file` (
    `file_id` int NOT NULL AUTO_INCREMENT,
    `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
    `file_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
    `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `update_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `is_deleted` tinyint(1) NULL DEFAULT 0,
    `file_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
    `version_control` int NULL DEFAULT 0,
    PRIMARY KEY (`file_id`) USING BTREE
  ) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;
";

const CREATE_FILE_CHANGELOG_MYSQL:&'static str = "
CREATE TABLE  IF NOT EXISTS `file_changelog` (
    `changelog_id` int NOT NULL AUTO_INCREMENT,
    `file_id` int NULL DEFAULT NULL,
    `version_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
    `prev_version_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
    `is_deleted` tinyint(1) NULL DEFAULT 0,
    `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `update_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `file_length` bigint NOT NULL,
    `file_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
    `diff_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
    PRIMARY KEY (`changelog_id`) USING BTREE
  ) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;
";
