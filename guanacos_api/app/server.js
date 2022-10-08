const express = require('express');
const app = express();
const server = require('http').createServer(app);
const io = require('socket.io')(server);
const { sequelize } = require('./models/index')
const cors = require('cors');
const ordersSocket = require('../sockets/ordersSocket');

class Server{
  constructor(){
    //Settings
    this.PORT = process.env.PORT || 3001

    //Middlewares
    this.middlewares()

    //rutas de ingreso al server
    this.routes()

    ordersSocket(io);
  }

  middlewares(){
      app.use(express.static('public'))
      app.use(cors())
      app.use(express.json()) // For parsing application/json
      app.disable('x-powered-by');
      app.use(express.urlencoded({extended: true})) // For parsing application/x-www-form-urlencoded
  }

  routes(){
      app.use('/api',require('../routes/authentication'))
      app.use('/api/users',require('../routes/users'))
      app.use('/api/categories',require('../routes/categories'))
      app.use('/api/products',require('../routes/products'))
      app.use('/api/address',require('../routes/address'))
      app.use('/api/orders',require('../routes/orders'))
  }

  listen(){
    server.listen(this.PORT, () => {
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