use std::sync::Mutex;

mod api;
mod bridge_generated;
mod database;
mod storage;
pub mod svg;

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

        match info {
            Some(s) => {
                let url = format!(
                    "mysql://{}:{}@{}:{}/{}",
                    s.username, s.password, s.address, s.port, s.database
                );
                crate::database::sqlx_connection::init(String::from(url));
            }
            None => todo!(),
        }
    }
}
