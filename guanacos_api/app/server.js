const express = require('express');
const app = express();
const { sequelize } = require('./models/index')
const cors = require('cors');

class Server{
  constructor(){
    this.app = express()

    //Settings
    this.PORT = process.env.PORT || 3001

    //Middlewares
    this.middlewares()

    //rutas de ingreso al server
    this.routes()
  }

  middlewares(){
      this.app.use(express.static('public'))
      this.app.use(cors())
      this.app.use(express.json()) // For parsing application/json
      this.app.disable('x-powered-by');
      this.app.use(express.urlencoded({extended: true})) // For parsing application/x-www-form-urlencoded
  }

  routes(){
      this.app.use('/api',require('../routes/authentication'))
      this.app.use('/api/users',require('../routes/users'))
      this.app.use('/api/categories',require('../routes/categories'))
      this.app.use('/api/products',require('../routes/products'))
      this.app.use('/api/address',require('../routes/address'))
      this.app.use('/api/orders',require('../routes/orders'))
  }

  listen(){
    this.app.listen(this.PORT, () => {
      console.log(`App listening on port ${this.PORT}`)
    
      sequelize.authenticate().then(() => {
        console.log('Conectado')
      }).catch(function (err) {
        console.log(`No conectado: ${err}`)
      })
    });
  }
}

module.exports = Server;