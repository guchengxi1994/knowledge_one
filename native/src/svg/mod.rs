use std::fmt::Display;
use std::time::SystemTime;
use svgcleaner::cleaner;
use svgcleaner::{CleaningOptions, ParseOptions, WriteOptions};

#[derive(Debug)]
pub struct CleanerResult {
    pub duration: u32,
    pub radio: f64,
    pub result: String,
}

impl CleanerResult {
    pub fn new(duration: u32, radio: f64, result: String) -> Self {
        return CleanerResult {
            duration,
            radio,
            result,
        };
    }
}

impl Display for CleanerResult {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(
            f,
            "cost {}ms, radio {}%, current size {}",
            self.duration,
            self.radio,
            self.result.len()
        )
    }
}

/// svg cleaner for a svg file
pub fn file_cleaner(p: String) -> Option<CleanerResult> {
    let file = cleaner::load_file(&p);
    match file {
        Ok(raw) => {
            let input_size = raw.len();
            let mut buf = raw.into_bytes();
            let mut prev_size = 0;
            let t1 = SystemTime::now();
            loop {
                let mut doc = match cleaner::parse_data(
                    std::str::from_utf8(&buf).unwrap(),
                    &ParseOptions::default(),
                ) {
                    Ok(d) => d,
                    Err(_) => {
                        return None;
                    }
                };

                match cleaner::clean_doc(
                    &mut doc,
                    &CleaningOptions::default(),
                    &WriteOptions::default(),
                ) {
                    Ok(_) => {}
                    Err(_) => {
                        return None;
                    }
                }

                buf.clear();

                cleaner::write_buffer(&doc, &WriteOptions::default(), &mut buf);

                if prev_size == buf.len() {
                    break;
                }

                prev_size = buf.len();
            }

            let t2 = SystemTime::now();
            let duration = t2.duration_since(t1).unwrap().as_millis();
            let ratio = 100.0 - (buf.len() as f64) / (input_size as f64) * 100.0;

            return Some(CleanerResult::new(
                duration.try_into().unwrap(),
                ratio,
                String::from_utf8(buf).unwrap(),
            ));
        }
        Err(_) => {
            return None;
        }
    }
}

/// svg cleaner for a svg string
pub fn string_cleaner(p: String) -> Option<CleanerResult> {
    let input_size = p.len();
    let mut buf = p.into_bytes();
    let mut prev_size = 0;
    let t1 = SystemTime::now();
    loop {
        let mut doc =
            match cleaner::parse_data(std::str::from_utf8(&buf).unwrap(), &ParseOptions::default())
            {
                Ok(d) => d,
                Err(_) => {
                    return None;
                }
            };

        match cleaner::clean_doc(
            &mut doc,
            &CleaningOptions::default(),
            &WriteOptions::default(),
        ) {
            Ok(_) => {}
            Err(_) => {
                return None;
            }
        }

        buf.clear();

        cleaner::write_buffer(&doc, &WriteOptions::default(), &mut buf);

        if prev_size == buf.len() {
            break;
        }

        prev_size = buf.len();
    }

    let t2 = SystemTime::now();
    let duration = t2.duration_since(t1).unwrap().as_millis();
    let ratio = 100.0 - (buf.len() as f64) / (input_size as f64) * 100.0;

    return Some(CleanerResult::new(
        duration.try_into().unwrap(),
        ratio,
        String::from_utf8(buf).unwrap(),
    ));
}

#[test]
fn test_clean() {
    let r = file_cleaner(String::from(
        r"D:\github_repo\knowledge_one\native\svg_test\0.svg",
    ));

    match r {
        Some(ro) => {
            println!("{}", ro);

            print!("{}", ro.result)
        }
        None => todo!(),
    }
}
