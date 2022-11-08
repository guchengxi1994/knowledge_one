use std::sync::Mutex;

mod api;
mod bridge_generated;
mod database;
mod storage;
#[deprecated = "performance and unfixed bugs"]
mod file_changelog;

#[macro_use]
extern crate lazy_static;
lazy_static! {
    static ref DATABASE_ADDR: Mutex<String> = Mutex::new(String::new());
    static ref DATABASE_PORT: Mutex<String> = Mutex::new(String::new());
    static ref DATABASE_USERNAME: Mutex<String> = Mutex::new(String::new());
    static ref DATABASE_PASSWORD: Mutex<String> = Mutex::new(String::new());
    static ref DATABASE_DATABASE: Mutex<String> = Mutex::new(String::new());
}

#[cfg(test)]
mod tests {
    use crate::database::load_config::load_config;

    #[tokio::test]
   async fn init_db() {
        let info = load_config("web_config.toml");

        let url = format!(
            "mysql://{}:{}@{}:{}/{}",
            info.username, info.password, info.address, info.port, info.database
        );
        crate::database::sqlx_connection::init(String::from(url));
    }
}
