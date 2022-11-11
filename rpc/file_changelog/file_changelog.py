import multiprocessing
import grpc
import time
from concurrent import futures

from file_diff.file_diff_impl import get_diff
from file_diff.file_diff_pb2_grpc import FileDiffServicer, add_FileDiffServicer_to_server
from file_diff.file_diff_pb2 import GenerateDiffResponse

from file_restore.file_restore_impl import restore_from_file
from file_restore.file_restore_pb2_grpc import FileRestoreServicer,add_FileRestoreServicer_to_server
from file_restore.file_restore_pb2 import RestoreResponse

_ONE_DAY_IN_SECONDS = 60 * 60 * 24
_HOST = "localhost"
_PORT = "15556"


class Diff(FileDiffServicer):

    def GenerateDiff(self, request, context):
        filePath1 = request.before
        filePath2 = request.after
        savePath = request.savePath
        try:
            get_diff(filePath1, filePath2, savePath)
            return GenerateDiffResponse(message=0)
        except:
            return GenerateDiffResponse(message=1)

class Restore(FileRestoreServicer):

    def Restore(self, request, context):
        filePath:str = request.filePath
        diffs:list = request.diffs
        fileSize:list = request.fileSize
        saveDir:str = request.saveDir

        try:
            s = restore_from_file(filePath,diffs,fileSize,saveDir)
            return RestoreResponse(message=s)
        except:
            return RestoreResponse(message="")


def serve():
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=4))
    add_FileDiffServicer_to_server(Diff(),server=server)
    add_FileRestoreServicer_to_server(Restore(),server=server)
    server.add_insecure_port(_HOST+':'+_PORT)
    server.start()
    try:
        while True:
            time.sleep(_ONE_DAY_IN_SECONDS)
    except KeyboardInterrupt:
        server.stop(0)

if __name__ == "__main__":
    multiprocessing.freeze_support()
    serve()
