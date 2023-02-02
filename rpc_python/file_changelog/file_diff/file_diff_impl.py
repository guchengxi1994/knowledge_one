import numpy as np
import pickle

MATRIX_WIDTH = 6

def dump_file(p: str, f):
    with open(p, 'wb') as fi:
        pickle.dump(f, fi)

def _load_file_by_numpy(p: str) -> list:
    array = np.fromfile(p, dtype=np.int32)
    return array.tolist()


def _format(a: list) -> np.ndarray:
    aLen = len(a)
    height = int(aLen / MATRIX_WIDTH) + 1
    _zeroLength = height * MATRIX_WIDTH - aLen
    _zeros = [0 for _ in range(_zeroLength)]
    # r = np.hstack((a, _zeros))
    a.extend(_zeros)
    mat = np.reshape(np.array(a, dtype=np.int32), (height, MATRIX_WIDTH))
    return mat


def _normalize(mat1: np.ndarray, mat2: np.ndarray) -> tuple:
    mat1Height = mat1.shape[0]
    mat2Height = mat2.shape[0]
    diffHeight = abs(mat1Height - mat2Height)
    if mat1Height <= mat2Height:
        mat1 = np.vstack((mat1, np.zeros((diffHeight, MATRIX_WIDTH))))
    else:
        mat2 = np.vstack((mat2, np.zeros((diffHeight, MATRIX_WIDTH))))

    return mat1, mat2


def get_diff(p1: str, p2: str,save_path="diff.mtx"):
    a1 = _load_file_by_numpy(p1)
    a2 = _load_file_by_numpy(p2)

    mat1 = _format(a1)
    mat2 = _format(a2)

    mat1, mat2 = _normalize(mat1, mat2)

    diff = mat2 - mat1
    # print(np.min(diff))
    dump_file(save_path,diff)


# if __name__ == "__main__":
#     get_diff("C:\\Users\\xiaoshuyui\\Desktop\\我的图片.png","C:\\Users\\xiaoshuyui\\Desktop\\我的图片 - 副本.png")