const mysql = require("mysql")

class dbAccess {
    static #instance = null

    constructor() {
        if(dbAccess.#instance) {
            throw new Error("Database object already instanced")
        }

        dbAccess.#instance = -1
    }

    initDB() {
        this.client = new mysql.createConnection({
            host: "localhost",
            user: "root",
            password: "antiguas",
            database: "db_biblioteca",
            port: 3306
        })

        this.client.connect(function(err) {
            if (err) throw err
        })
    }

    getClient() {
        if(!dbAccess.#instance || dbAccess.#instance == -1) {
            throw new Error("Database object not instanced")
        }

        return this.client
    }

    static getInstance() {
        if (!this.#instance) {
            this.#instance = new dbAccess()
            this.#instance.initDB()
        }

        return this.#instance
    }

    select({table = "", fields = [], whereClauses = []} = {}, callback) {
        let whereClause = ""
        if (whereClauses.length > 0) {
            whereClause = `WHERE ${whereClauses.join(" AND ")}`
        }

        let query = `SELECT ${fields.join(",")} FROM ${table} ${whereClause}`
        this.client.query(query, callback)
    }
}

module.exports = {dbAccess: dbAccess}