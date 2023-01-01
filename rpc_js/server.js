const grpc = require('@grpc/grpc-js')
const quicktype_proto = require('./proto')
const { quicktypeJSON } = require('./quicktype_call.js')


async function generate(call, callback) {
    const { lines: model } = await quicktypeJSON(
        call.request.langType,
        call.request.structName,
        call.request.content
    );
    // console.log(model)
    callback(null, { result: model.join("\n") })
}


function main() {
    var server = new grpc.Server()
    server.addService(quicktype_proto.Generate.service, { generateCode: generate })
    server.bindAsync('0.0.0.0:50051', grpc.ServerCredentials.createInsecure(), () => {
        server.start()
        console.log('grpc server started')
    })
}

main()