use std::{fs::File, path::Path};

pub fn create_file(s: String) -> i64 {
    let target_path = Path::new(&s);
    if target_path.exists() {
        return 500;
    }

    let file = File::create(s);
    match file {
        Ok(_) => {
            return 0;
        }
        Err(_) => {
            return 1;
        }
    }
}

#[test]
fn test_create() {
    let r = create_file(String::from(
        "D:/github_repo/knowledge_one/build/windows/runner/Debug/_private/test",
    ));

    println!("{:?}", r);
}
