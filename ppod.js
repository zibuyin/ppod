const express = require("express");
const app = express();
const { exec } = require("child_process");
const crypto = require("crypto");
const fs = require("fs")
// const { initApp, initializeLogPath }= require("./init.js")

const CONFIG_PATH = "./ppod.conf";
const DEFAULT_LOG_PATH = "./log/ppod.log";

// TODO: Replace with log file
const pino = require("pino")

function createLogger(logPath) {
    if (!fs.existsSync(logPath)){
        fs.mkdirSync("./logs")
        fs.writeFileSync(logPath,"")
    }
    return pino(
        {
            formatters: {
                level: (label) => ({ level: label.toUpperCase() })
            }
        },
        pino.destination({
            dest: logPath,
            sync: true
        })
    );
}





// TODO:
// 1. Set whitelist for github IP
// 2. Prevent replay attacks
// 3. Change file locations to proper locations


app.use(express.raw({ type: "application/json", limit: "1mb"}));

// Quit the program
function die(deathMessage){
    console.log("\x1b[31m%s\x1b[0m", `FATAL ERROR: ${deathMessage}`)
    process.exit(1)
}
// Load config
function loadConfig(configPath){
    configPath = "./ppod.conf" //REMOVE IN PRODUCTION
    try{
        if (fs.existsSync(configPath)){
            process.loadEnvFile(configPath)
        }
        // Generate a default config if not found
        // else {
        //     fs.readFile('./ppod.conf.template', 'utf8', (err, data) => {
        //         if (err) {
        //             console.error(err);
        //             return;
        //         }
        //         // fs.mkdirSync("/etc/ppod/")
        //         fs.writeFileSync(configPath, data, (err) => {
        //         if(err){
        //             console.log(err)
        //         }
        //     })
                    
        //     });
            
        // }
       
    }
    catch(error){
        logger.fatal(error, "Error loading config")
        die(`Error loading config: ${error}`)
    }
    
}

// Load seen deliveries
function loadDB(DBPath){
    try{
        return require(DBPath)

    }
    catch(error){
        logger.fatal(error, "Fail to load DB")
        die("Fail to load DB")
    }
}


// INIT
const logger = createLogger("./logs/ppod.log")

const DB_PATH = "./db.json";
const db = loadDB(DB_PATH)

// loadConfig("/etc/ppod/ppod.conf")
loadConfig("./ppod.conf")


// END OF INIT
if (!Array.isArray(db.seenDeliveries)) {
    db.seenDeliveries = [];
}

function persistDB(DBPath, DBContent) {
    fs.writeFileSync(DBPath, `${JSON.stringify(DBContent, null, 2)}\n`, "utf8");
}

function HMAC(key, message) {
  return crypto
    .createHmac("sha256", key)
    .update(Buffer.isBuffer(message) ? message : Buffer.from(message))
    .digest("hex");
}

async function checkKey(key, body, githubHash) {
    const generatedHash = await HMAC(key, body)
    logger.info({ generatedHash }, "Generated webhook signature")

    // Signatures should be 64-char hex for sha256.
    if (!/^[a-fA-F0-9]{64}$/.test(githubHash)) {
        return false;
    }

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
                logger.info({ stdout: stdout.trim() }, "Deployment stdout");
                console.log(stdout)
            }
            if (stderr){
                logger.warn({ stderr: stderr.trim() }, "Deployment stderr");
                console.log(stderr)
            }

            if (error !== null) {
                logger.error(error, "Deployment command failed");
                return reject(error);
            }

            resolve();
        });
    });
}

app.get("/health", (req, res) => {
    return res.status(200).send("OK");
});

app.head("/health", (req, res) => {
    return res.sendStatus(200);
});

app.post(process.env.endpoint, async (req, res) => {
    logger.info("Received webhook POST request");

    try {
        const body = req.body
        const signatureHeader = req.headers["x-hub-signature-256"];
        const eventType = req.headers["x-github-event"];
        const delivery = req.headers["x-github-delivery"];
        if (delivery && Array.isArray(db.seenDeliveries) && db.seenDeliveries.includes(delivery) && process.env.ignoreReplay == "false"){
            logger.warn("Duplicated POST request, suspected replay attack");
            return res.status(409).send("Replay detected");
        }
        // Checks if signature is missing
        if (!signatureHeader || !signatureHeader.startsWith("sha256=")) {
            logger.warn("Missing or invalid signature header");
            return res.status(400).send("Missing or invalid signature header");
        }
        // Remove the 'sha256=' part
        const hash = signatureHeader.substring(7);

        // Check if the hash matches
        if (await checkKey(process.env.secret, body, hash)){
            if (delivery && process.env.ignoreReplay == "false") {
                db.seenDeliveries.push(delivery);
                persistDB(DB_PATH, db);
            }

            if (eventType == "push"){
                logger.info("Webhook signature valid, triggering deployment");
                deployment(process.env.path_to_deployment_script);
                logger.info("Deployment completed successfully");
            } else {
                logger.info("HASH matches but event type is not 'push', not deployed")
                
            }
            return res.send("OK")
            
        }

        logger.warn("Invalid webhook signature");
        return res.status(401).send("Invalid signature")
    } catch (error) {
        logger.error(error, "Unhandled webhook error");
        return res.status(500).send("Internal server error");
    }
})





app.listen(process.env.port, () => {
    console.log(`PPOD started on port ${process.env.port}`)
    logger.info({ port: process.env.port }, "Server started")
})