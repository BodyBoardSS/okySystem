const express = require('express')
const router = express.Router()

//Middlewares
const auth = require('./middlewares/auth')

//Policies
const GlobalPolicy = require('./middlewares/globalPolicy')

//Controllers
const AuthController = require('./controllers/AuthController')
const CategoriaController = require('./controllers/CategoriaController')
const ProductoController = require('./controllers/ProductoController')
const MetodoController = require('./controllers/MetodoController')
const PedidoController = require('./controllers/PedidoController')

//Routes
router.get('/', (req, res) => {
    res.json({ hello: "Hello World" })
})

//SigIn & SignUp
router.post('/api/signin', AuthController.signIn)
router.post('/api/signup', AuthController.signUp)

//Categorias
router.get('/api/categoria', auth, CategoriaController.index)
router.get('/api/categoria/:id', auth, CategoriaController.find, CategoriaController.update)
router.post('/api/categoria', auth, GlobalPolicy.isAdmin, CategoriaController.create)
router.put('/api/categoria/:id', auth, GlobalPolicy.isAdmin, CategoriaController.find, CategoriaController.update)
router.delete('/api/categoria/:id', auth, GlobalPolicy.isAdmin, CategoriaController.find, CategoriaController.delete)

//Producto
router.get('/api/producto', auth, ProductoController.index)
router.post('/api/producto', auth, GlobalPolicy.isAdmin, ProductoController.create)
router.put('/api/producto/:id', auth, GlobalPolicy.isAdmin, ProductoController.update)
router.delete('/api/producto/:id', auth, GlobalPolicy.isAdmin, ProductoController.delete)

//Metodo
router.get('/api/metodo', auth, MetodoController.index)
router.post('/api/metodo', auth, GlobalPolicy.isAdmin, MetodoController.create)
router.put('/api/metodo/:id', auth, GlobalPolicy.isAdmin, MetodoController.update)
router.delete('/api/metodo/:id', auth, GlobalPolicy.isAdmin, MetodoController.delete)

//Pedido
router.get('/api/pedido', auth, PedidoController.index)
router.post('/api/pedido', auth, GlobalPolicy.isAdmin, PedidoController.create)
router.put('/api/pedido/:id', auth, GlobalPolicy.isAdmin, PedidoController.update)
router.delete('/api/pedido/:id', auth, GlobalPolicy.isAdmin, PedidoController.delete)


module.exports = router;