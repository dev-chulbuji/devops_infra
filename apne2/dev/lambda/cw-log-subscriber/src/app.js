const zlib = require('zlib');

exports.handler = (input, context) => {
    const payload = Buffer.from(input.awslogs.data, 'base64');
    zlib.gunzip(payload, (e, result) => {
        if (e) { 
            context.fail(e);
        } else {
            result = JSON.parse(result.toString('ascii'));
            console.log("Event Data:", JSON.stringify(result, null, 2));
            context.succeed();
        }
    });
};