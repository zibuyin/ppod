const fs = require("fs")
const readline = require('readline');
const path = require("path");

function input(question = "") {
    const rl = readline.createInterface({
        input: process.stdin,
        output: process.stdout,
    });

    return new Promise((resolve) => {
        rl.question(question, (answer) => {
            rl.close();
            resolve(answer);
        });
    });
}

async function initApp(){
    const logPathInput = await input("Input log file path (press enter for default ./log/ppod.log): ");
    const logPath = (logPathInput || "").trim() || "./log/ppod.log";
        return initializeLogPath(logPath);
    }

    function initializeLogPath(logPath = "./log/ppod.log") {
        const normalizedLogPath = (logPath || "").trim() || "./log/ppod.log";
        const logDir = path.dirname(normalizedLogPath);

    if (!fs.existsSync(logDir)) {
        fs.mkdirSync(logDir, { recursive: true });
    }

        if (!fs.existsSync(normalizedLogPath)){
            fs.writeFileSync(normalizedLogPath, "", "utf8")
    }

        return normalizedLogPath;
}

    module.exports = { initApp, initializeLogPath }