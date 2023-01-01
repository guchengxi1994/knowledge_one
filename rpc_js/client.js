const quicktype_proto = require('./proto')
const grpc = require('@grpc/grpc-js')

function main() {
    var client = new quicktype_proto.Generate('localhost:50051', grpc.credentials.createInsecure())
    client.generateCode({ content: '{"a":"a"}', langType: "python", structName: "Test" }, function (err, response) {
        if (err) {
            console.error('Error: ', err)
        } else {
            console.log(response.result)
        }
    })
}

main()