require('dotenv').config()

module.exports = {
    username: process.env.DB_USERNAME || "root",
    password: process.env.DB_PASSWORD ||null,
    database: process.env.DB_DATABASE ||"",
    host: process.env.DB_HOST ||"localhost",
    dialect: process.env.DB_DIALECT ||"mysql",
    
    //Configurar Seeds

    seederStorage: "sequelize",
    seederStorageTableName: "seeds",

    //Configurar Migraciones

    migrationStorage: "sequelize",
    migrationStorageTableName: "migrations"
}
