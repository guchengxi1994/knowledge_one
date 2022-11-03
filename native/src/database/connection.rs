use mysql::{Pool,  Opts};

pub struct MysqlDataSource {
    pool: Option<Pool>,
}

static mut MYSQL_DATA_SOURCE: MysqlDataSource = MysqlDataSource { pool: None };

pub fn init_mysql_db() {
    unsafe {
        let port: String = crate::DATABASE_PORT.lock().unwrap().to_string();
        let username: String = crate::DATABASE_USERNAME.lock().unwrap().to_string();
        let password: String = crate::DATABASE_PASSWORD.lock().unwrap().to_string();
        let ipaddr: String = crate::DATABASE_ADDR.lock().unwrap().to_string();
        let database: String = crate::DATABASE_DATABASE.lock().unwrap().to_string();
        let url = format!("mysql://{}:{}@{}:{}/{}", username, password, ipaddr, port, database);
        let ops: Opts = Opts::from_url(&url).unwrap();
        let pool = Pool::new(ops).unwrap();
        MYSQL_DATA_SOURCE.pool = Some(pool);
        print!("数据库连接初始化完成")
    }
}


pub fn get_mysql_conn_pool() -> Option<&'static Pool> {
    unsafe {
        MYSQL_DATA_SOURCE.pool.as_ref()
    }
}