import pickle
import numpy as np
import os
import time

MATRIX_WIDTH = 6


def restore_from_file(filePath: str, diffs: list, fileSize: list,
                      saveDir: str) -> str:
    ext = os.path.splitext(filePath)[1]
    # 逆序排列，从最近的开始
    diffs.reverse()
    fileSize.reverse()
    t = int(time.time())

    for i in range(0, len(diffs) - 1):
        if i == 0:
            _restore_from_mtx(diffs[i], filePath, fileSize[i + 1],
                              saveDir + os.sep + str(t) + "." + ext)
        else:
            _restore_from_mtx(diffs[i], saveDir + os.sep + str(t) + "." + ext,
                              fileSize[i + 1],
                              saveDir + os.sep + str(t) + "." + ext)
        return saveDir + os.sep + str(t) + "." + ext


def _load_file_by_numpy(p: str) -> list:
    array = np.fromfile(p, dtype=np.int32)
    return array.tolist()


def load_pickle(f: str):
    with open(f, "rb") as fi:
        r = pickle.load(fi)
    return r


def _restore_from_mtx(mtx: str,
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
        mat = np.reshape(np.array(f, dtype=np.int32), (height, MATRIX_WIDTH))
        diffHeight = mat.shape[0] - diffMatShape[0]
        diffMat = np.vstack((diffMat, np.zeros((diffHeight, MATRIX_WIDTH))))

    else:
        height = diffMatShape[0]

        _zeroLength = height * MATRIX_WIDTH - len(f)
        _zeros = [0 for _ in range(_zeroLength)]
        f.extend(_zeros)
        mat = np.reshape(np.array(f, dtype=np.int32), (height, MATRIX_WIDTH))

    mat = mat - diffMat
    mat = mat.astype(np.int32)
    _list = mat.flatten().tolist()
    fileData = _list[:fileLen]
    with open(savePath, 'wb') as f:
        for i in fileData:
            f.write(i.to_bytes(4, 'little', signed=True))


# if __name__ == "__main__":
#     # restore_from_mtx("diff.mtx",
#     #                  "C:\\Users\\xiaoshuyui\\Desktop\\我的图片 - 副本.png", 1066708)
#     restore_from_file(
#         "C:\\Users\\xiaoshuyui\\Desktop\\我的图片 - 副本.png",
#         diffs=[
#             "",
#             r"D:\github_repo\knowledge_one\rpc_python\file_changelog\file_diff\diff.mtx",
#         ],
#         fileSize=[1066708, 1138771],
#         saveDir=
#         "D:/github_repo/knowledge_one/rpc_python/file_changelog/file_diff/")
