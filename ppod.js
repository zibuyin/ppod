const express = require("express");
const app = express();
const { exec } = require("child_process");
const crypto = require("crypto");
// TODO:
// 1. Set whitelist for github IP
// 2. Prevent replay attacks

app.use(express.raw({ type: "application/json", limit: "1mb"}));

// Load config
process.loadEnvFile('./ppod.conf')



function HMAC(key, message) {
  return crypto
    .createHmac("sha256", key)
    .update(Buffer.isBuffer(message) ? message : Buffer.from(message))
    .digest("hex");
}

async function checkKey(key, body, githubHash) {
    const generatedHash = await HMAC(key, body)
    console.log(generatedHash)

    // Prevents timing attacks
    return crypto.timingSafeEqual(
        Buffer.from(generatedHash, "hex"),
        Buffer.from(githubHash, "hex")
    )
}

async function deployment(pathToScript) {
    return new Promise((resolve, reject) => {
        exec(pathToScript, function (error, stdout, stderr) {
            // Only print if there is a need to
            if (stdout){
                console.log(stdout);
            }
            if (stderr){
                console.log(stderr);
            }

            if (error !== null) {
                return reject(error);
            }

            resolve();
        });
    });
}


app.post("/webhook", async (req, res) => {
    console.log("got POST");

    try {
        const body = req.body
        const signatureHeader = req.headers["x-hub-signature-256"];

        if (!signatureHeader || !signatureHeader.startsWith("sha256=")) {
            return res.status(400).send("Missing or invalid signature header");
        }

        const hash = signatureHeader.substring(7);

        // Check if the hash matches
        if (await checkKey(process.env.secret, body, hash)){
            await deployment(process.env.path_to_deployment_script)
            return res.send("OK")
        }

        return res.status(401).send("Invalid signature")
    } catch (error) {
        console.error(error);
        return res.status(500).send("Internal server error");
    }
})

app.listen(process.env.port, () => {
    console.log(`Server running on port ${process.env.port}`)
})