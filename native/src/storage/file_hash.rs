use data_encoding::HEXUPPER;
use ring::digest::{Context, Digest, SHA256};
use std::io::Error;
use std::fs::File;
use std::io::{BufReader, Read};

pub fn get_file_hash(file_path:String)->String{  
    let inp = File::open(file_path);
    match inp {
        Ok(i) => {
            let reader = BufReader::new(i);
            let digest = sha256_digest(reader).unwrap();
            HEXUPPER.encode(digest.as_ref())
        },
        Err(_) => {
            String::from("")
        },
    }
}

fn sha256_digest<R: Read>(mut reader: R) -> Result<Digest,Error> {
    let mut context = Context::new(&SHA256);
    let mut buffer = [0; 1024];

    loop {
        let count = reader.read(&mut buffer)?;
        if count == 0 {
            break;
        }
        context.update(&buffer[..count]);
    }

    Ok(context.finish())
}