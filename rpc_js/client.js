const hello_proto = require('./proto')
const grpc = require('@grpc/grpc-js')

function main() {
    var client = new hello_proto.Greeter('localhost:50051', grpc.credentials.createInsecure())
    client.sayHello({ message: 'Hello' }, function(err, response) {
        if (err) {
            console.error('Error: ', err)
        } else {
            console.log(response.message)
        }
    })
}

main()

