import pickle
import numpy as np
from file_diff_impl import _load_file_by_numpy, MATRIX_WIDTH


def load_pickle(f: str):
    with open(f, "rb") as fi:
        r = pickle.load(fi)
    return r


def restore_from_mtx(mtx: str,
                     filePath: str,
                     fileLen: int,
                     savePath: str = "result.png"):
    f = _load_file_by_numpy(filePath)

    diffMat: np.ndarray = load_pickle(mtx)
    diffMatShape = diffMat.shape
    diffMatLength = diffMatShape[0] * diffMatShape[1]
    if diffMatLength < len(f):
        height = int(len(f) / MATRIX_WIDTH) + 1
        _zeroLength = height * MATRIX_WIDTH - len(f)
        f.extend(_zeros)
        mat = np.reshape(np.array(f, dtype=np.uint8), (height, MATRIX_WIDTH))
        diffHeight = mat.shape[0] - diffMatShape[0]
        diffMat = np.vstack((diffMat, np.zeros((diffHeight, MATRIX_WIDTH))))

    else:
        height = diffMatShape[0]

        _zeroLength = height * MATRIX_WIDTH - len(f)
        _zeros = [0 for _ in range(_zeroLength)]
        f.extend(_zeros)
        mat = np.reshape(np.array(f, dtype=np.uint8), (height, MATRIX_WIDTH))

    mat = mat + diffMat
    mat = mat.astype(np.uint8)
    _list = mat.flatten().tolist()
    fileData = _list[:fileLen]
    with open(savePath, 'wb') as f:
        for i in fileData:
            f.write(i.to_bytes(1, 'little', signed=False))


# if __name__ == "__main__":
#     # restore_from_mtx("diff.mtx",
#     #                  "C:\\Users\\xiaoshuyui\\Desktop\\我的图片 - 副本.png", 1066708)
#     restore_from_mtx("diff.mtx",
#                      "C:\\Users\\xiaoshuyui\\Desktop\\我的图片.png", 1138771)
