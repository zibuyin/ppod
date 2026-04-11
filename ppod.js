const express = require("express");
const test = require("node:test");
const app = express();
const { exec } = require("child_process");

app.use(express.raw({ type: "application/json" }));

// Load config
process.loadEnvFile('./ppod.conf')

async function HMAC(key, message) {
  const enc = new TextEncoder();

  const cryptoKey = await crypto.subtle.importKey(
    "raw",
    enc.encode(key),
    { name: "HMAC", hash: "SHA-256" },
    false,
    ["sign"]
  );

  const sig = await crypto.subtle.sign(
    "HMAC",
    cryptoKey,
    enc.encode(message)
  );

  return [...new Uint8Array(sig)]
    .map(b => b.toString(16).padStart(2, "0"))
    .join("");
}

async function checkKey(key, body, githubHash) {
    generatedHash = await HMAC(key, body)
    console.log(generatedHash)
    if (generatedHash == githubHash){
        return true
    }
        
}

async function deployment(pathToScript) {
    // console.log("test")
    exec(pathToScript,
    function (error, stdout, stderr) {

        // Only print if there is a need to
        if (stdout){
            console.log(stdout);
        }
        if (stderr){
            console.log(stderr);
        }
        
        if (error !== null) {
             console.log('exec error: ' + error);
        }
    });
    
}


app.post("/webhook", (req, res) => {
    console.log("got POST");
    const body = req.body
    console.log(body);
    // Get the HASH
    const hash = (req.headers["x-hub-signature-256"].substring(7));
    console.log(hash)

    // Check if the hash matches
    if (checkKey(process.env.secret, body, hash)){
        deployment(process.env.path_to_deployment_script)
    }
    



    res.send("OK")
})

app.listen(8000, () => {
    console.log("Server running on port 8000")
})