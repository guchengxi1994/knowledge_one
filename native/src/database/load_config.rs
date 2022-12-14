use serde::{Deserialize, Serialize};
use std::fs::File;
use std::io::Read;


#[derive(Serialize, Deserialize, Debug)]
pub struct DatabaseInfo {
    pub name: String,
    pub address: String,
    pub port: String,
    pub username: String,
    pub password: String,
    pub database: String,
}

#[derive(Serialize, Deserialize, Debug)]
pub struct Config{
    title :String,
    database:DatabaseInfo,
}

pub fn load_config(conf_path:&str) ->  Option<DatabaseInfo>  {
    let file_path = conf_path;
    let mut file: File = match File::open(file_path) {
        Ok(f) => f,
        Err(_) => {
            println!("can not load db_config file by native");
            return  None;
        }
    };

    let mut str_val = String::new();
    match file.read_to_string(&mut str_val) {
        Ok(s) => s,
        Err(_) => {
            println!("can not load db info by native");
            return None;
        }
    };

    let p:Config = toml::from_str(&str_val).unwrap();
    Some(p.database)
}