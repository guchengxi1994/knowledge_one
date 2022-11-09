use std::fs;

pub fn get_file_size(filepath:String)->u64{
    let metaf = fs::File::open(&filepath);
    match metaf {
        Ok(mf) => {
            mf.metadata().unwrap().len()
        },
        Err(_) => {
            0
        },
    }
}