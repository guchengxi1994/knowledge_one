const { quicktypeJSON, quicktypeJSONSchema } = require('./quicktype_call.js') 


async function main() {
    const { lines: swiftPerson } = await quicktypeJSON(
        "swift",
        "Person",
        '{"a":"a"}'
    );
    console.log(swiftPerson.join("\n"));

}

main();