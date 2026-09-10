const mysql = require('mysql2/promise');

const db = mysql.createPool({
    host:'mysql_db',
    user:'root',
    password:'root1234',
    database:'app_db',
    connectionLimit:10,
    queueLimit:0,
    charset:'utf8mb4'
})

module.exports = db;