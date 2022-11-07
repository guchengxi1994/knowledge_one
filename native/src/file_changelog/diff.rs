use std::fs;

use super::file_io::read_file_as_vec;
use nalgebra::{DMatrix, Dynamic, Matrix, VecStorage};
use nalgebra_sparse::{
    convert::serial::convert_coo_dense,
    io::{load_coo_from_matrix_market_file, save_to_matrix_market_file},
    CooMatrix,
};
const MATRIX_WIDTH: usize = 6;

pub struct FileMat {
    pub file_path: String,
}

impl FileMat {
    pub fn get_file_matrix(
        &self,
    ) -> Matrix<i16, Dynamic, Dynamic, VecStorage<i16, Dynamic, Dynamic>> {
        let file_data_origin = read_file_as_vec(&self.file_path);
        let mut file_data = Vec::new();
        for i in file_data_origin {
            file_data.push(i as i16);
        }

        if file_data.len() == 0 {
            let mut m = Vec::new();
            let mut i = 0;
            while i < MATRIX_WIDTH {
                m.push(0 as i16);
                i = i + 1;
            }
            let r = DMatrix::from_vec(1, MATRIX_WIDTH, m);
            return r;
        } else {
            let mat_height = file_data.len() / MATRIX_WIDTH + 1;
            let padding = mat_height * 6 - file_data.len();
            let padding_zeros = std::iter::repeat(0).take(padding);
            file_data.append(&mut Vec::from_iter(padding_zeros));
            let r = DMatrix::from_vec(mat_height, MATRIX_WIDTH, file_data);

            return r;
        }
    }

    pub fn diff(
        &self,
        other: FileMat,
    ) -> Matrix<i16, Dynamic, Dynamic, VecStorage<i16, Dynamic, Dynamic>> {
        let mut m = Vec::new();
        let mut i = 0;
        while i < MATRIX_WIDTH {
            m.push(0 as i16);
            i = i + 1;
        }

        let m1 = self.get_file_matrix();
        let m2 = other.get_file_matrix();
        let m1_height = m1.shape().0;
        let m2_height = m2.shape().0;
        // m1高度小于m2,零填充m1
        if m1_height <= m2_height {
            let h = m2_height - m1_height;
            let new_m1 = m1.insert_rows(m1_height, h, 0);

            return m2 - new_m1;
        } else {
            let h = m1_height - m2_height;
            let new_m2 = m2.insert_rows(m2_height, h, 0);
            return new_m2 - m1;
        }
    }

    pub fn save_diff(&self, other: FileMat, p: &str) {
        let diff_mat = self.diff(other);
        let coo = CooMatrix::from(&diff_mat);
        let r = save_to_matrix_market_file(&coo, p);
        match r {
            Ok(_) => {
                println!("OK");
            }
            Err(e) => {
                println!("{:?}", e);
            }
        }
    }

    pub fn restore_from_mtx(&self, file_length: usize, mtx_path: &str, save_path: &str) {
        let coo = load_coo_from_matrix_market_file::<i16, _>(mtx_path);
        match coo {
            Ok(mtx) => {
                let diff = convert_coo_dense(&mtx);
                let diff_height = diff.shape().0;
                // let m2_height = m2.shape().0;
                let m = self.get_file_matrix();
                let m_height = m.shape().0;
                let result;
                if diff_height >= m_height {
                    let h = diff_height - m_height;
                    let new_m = m.insert_rows(m_height, h, 0);
                    result = new_m + diff;
                } else {
                    let h = m_height - diff_height;
                    let new_diff = diff.insert_rows(diff_height, h, 0);
                    result = m + new_diff;
                }

                let width = result.shape().0 * MATRIX_WIDTH;

                let v = result.reshape_generic(Dynamic::new(1), Dynamic::new(width));
                let mut i: usize = 0;
                let mut data: Vec<u8> = Vec::new();
                while i < file_length {
                    data.push(*(v.index(i)) as u8);
                    i = i + 1;
                }

                let r = fs::write(save_path, data);
                match r {
                    Ok(_) => {
                        println!("OK");
                    }
                    Err(e) => {
                        println!("{:?}", e);
                    }
                }
            }
            Err(e) => {
                println!("{:?}", e);
            }
        }
    }
}


