use futures::executor::block_on;
use lazy_static::lazy_static;
use sqlx::{MySql, MySqlPool, Pool};
use std::sync::Arc;
use tokio::sync::RwLock;

use super::model::file::NativeFileSummary;


/// 自定义连接池结构体
pub struct MyPool(Option<Pool<MySql>>);

impl MyPool {
    /// 创建连接池
    async fn new(uri: &str) -> Self {
        let pool = MySqlPool::connect(uri).await.unwrap();
        MyPool(Some(pool))
    }

    /// 获取连接池
    pub fn get_pool(&self) -> &Pool<MySql> {
        self.0.as_ref().unwrap()
    }
}

/// 实现 Default trait
impl Default for MyPool {
    fn default() -> Self {
        MyPool(None)
    }
}

// 声明创建静态连接池
lazy_static! {
   pub static ref POOL: Arc<RwLock<MyPool>> = Arc::new(RwLock::new(Default::default()));
}

// 初始化静态连接池
#[tokio::main]
pub async fn init(url:String) {
    block_on(async {
        // let port: String = crate::DATABASE_PORT.lock().unwrap().to_string();
        // let username: String = crate::DATABASE_USERNAME.lock().unwrap().to_string();
        // let password: String = crate::DATABASE_PASSWORD.lock().unwrap().to_string();
        // let ipaddr: String = crate::DATABASE_ADDR.lock().unwrap().to_string();
        // let database: String = crate::DATABASE_DATABASE.lock().unwrap().to_string();
        // let url = format!(
        //     "mysql://{}:{}@{}:{}/{}",
        //     username, password, ipaddr, port, database
        // );
        let pool = POOL.clone();
        let mut pool = pool.write().await;
        *pool = MyPool::new(&url).await;
        println!("{:}", url);
    })
}

#[tokio::test]
async fn hello() {
    let url = format!(
        "mysql://{}:{}@{}:{}/{}",
        "root", "123456", "localhost", "3306", "knowledge_one"
    );
	// 初始化连接池
	let pool = POOL.clone();
    let mut pool = pool.write().await;
	*pool = MyPool::new(&url).await;
 
    let result = sqlx::query_as::<sqlx::MySql, super::model::todo_status::TodoStatus>(r#"SELECT todo_status_id,todo_status_name,todo_status_color from todo_status"#).fetch_all(pool.get_pool()).await.unwrap();
    
    for r in result{
        println!("{:?}",r.todo_status_name);
    }
}

#[tokio::test]
async fn hello2() {
    let url = format!(
        "mysql://{}:{}@{}:{}/{}",
        "root", "123456", "localhost", "3306", "knowledge_one"
    );
	// 初始化连接池
	let pool = POOL.clone();
    let mut pool = pool.write().await;
	*pool = MyPool::new(&url).await;

    let sql = sqlx::query(
        r#"INSERT INTO file (file_name,file_path,file_hash) VALUES(?,?,?) "#,
    )
    .bind(Some(String::from("我的图片.png")))
    .bind(Some(String::from("C:\\Users\\xiaoshuyui\\Desktop\\我的图片.png")))
    .bind("file_hash")
    .execute(pool.get_pool())
    .await;
    
    // let mut f = NativeFileSummary{file_name:Some(String::from("我的图片.png")),file_path:Some(String::from("C:\\Users\\xiaoshuyui\\Desktop\\我的图片.png"))};

    match sql {
        Ok(result) => {
            println!("{:?}",result.last_insert_id());

        },
        Err(err) => {
            println!("{:?}",err);
  
        }
    }

}
