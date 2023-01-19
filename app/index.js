const express = require("express")
const fs = require("fs")
const sass = require("sass")
const {dbAccess} = require("./modules/dbacc.js")

var dbInstance = dbAccess.getInstance()
if(dbInstance) console.log("Connected to database")

app = express()

app.set("view engine", "ejs")
app.use("/resources", express.static(__dirname + "/resources"))
app.use("/node_modules", express.static(__dirname + "/node_modules"))

function cssToScss() {
    console.log("Compiling SCSS files...")
    let content = fs.readFileSync(__dirname + "/resources/json/scss.json").toString("utf-8")
    JSON.parse(content).files.forEach(function(e) {
        let compiled = sass.compile(__dirname + "/resources/scss/" + e + ".scss", {sourceMap: true})
        fs.writeFileSync(__dirname + "/resources/css/" + e + ".css", compiled.css)
    })
}
cssToScss()

app.get("/favicon.ico", function(req, res) {})
app.get("/*", function(req, res) {
    console.log("Requesting", req.url)
    res.render("pages" + req.url, function(err=null, renderRes) {
        if(err)
            throw err
        else
            res.send(renderRes)
    })
})

app.listen(8080)
console.log("Server Started\n----------")