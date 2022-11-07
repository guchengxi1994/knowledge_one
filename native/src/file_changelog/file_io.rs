use std::fs;

pub fn read_file_as_vec(filepath:&str)->Vec<u8>{
    let data = fs::read(filepath);
    match data {
        Ok(d) => {
            return d;
        },
        Err(_) =>{
            return Vec::new();
        },
    }
}

/// https://stackoverflow.com/questions/71821028/how-do-you-simply-read-a-u32-from-a-file
/// 
/// read file into u32 vector
pub fn read_file_into_u32_vector(){}