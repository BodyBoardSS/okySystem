const express = require('express');
const app = express();
const { sequelize } = require('./models/index')
const cors = require('cors');

//Settings
const PORT = process.env.PORT || 3001;

app.use(cors());

//Middlewares
// For parsing application/json
app.use(express.json())
app.disable('x-powered-by');
// For parsing application/x-www-form-urlencoded
app.use(express.urlencoded({extended: true}))

//Routes
app.use(require('./routes'))

app.listen(PORT, () => {
  console.log(`Example app listening on port ${PORT}`)

  sequelize.authenticate().then(() => {
    console.log('Conectado')
  }).catch(function (err) {
    console.log(`No conectado: ${err}`)
    console.log(process.env.DB_PASSWORD)
  })
});