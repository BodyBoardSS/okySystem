const express = require('express')
const router = express.Router()
const multer = require('multer')

//Middlewares
const auth = require('./middlewares/auth')

//Temporary Storage
const upload = multer({
    storage: multer.memoryStorage()
  });

//Policies
const GlobalPolicy = require('./middlewares/globalPolicy')

//Controllers
const AuthController = require('./controllers/AuthController')
const CategoryController = require('./controllers/CategoryController')
const ProductController = require('./controllers/ProductController')
const PaymentMethodController = require('./controllers/PaymentMethodController')
const OrderController = require('./controllers/OrderController');
const UserController = require('./controllers/UserController');

//Routes
router.get('/', (req, res) => {
    res.json({ appName: "GuanacosApp" })
})

//SigIn & SignUp
router.post('/api/signin', AuthController.signIn)
router.post('/api/signup', AuthController.signUp)
router.post('/api/signUpWithImage',upload.array('image',1), AuthController.signUpWithImage)

//Users
router.put('/api/users/updateWithImage', auth, upload.array('image',1), UserController.updateUserWithImage)
router.put('/api/users', auth, UserController.update)


//Categories
router.get('/api/category', auth, CategoryController.index)
router.get('/api/category/:id', auth, CategoryController.find, CategoryController.update)
router.post('/api/category', auth, GlobalPolicy.isAdmin, CategoryController.create)
router.put('/api/category/:id', auth, GlobalPolicy.isAdmin, CategoryController.find, CategoryController.update)
router.delete('/api/category/:id', auth, GlobalPolicy.isAdmin, CategoryController.find, CategoryController.delete)

//Product
router.get('/api/product', auth, ProductController.index)
router.post('/api/product', auth, GlobalPolicy.isAdmin, ProductController.create)
router.put('/api/product/:id', auth, GlobalPolicy.isAdmin, ProductController.update)
router.delete('/api/product/:id', auth, GlobalPolicy.isAdmin, ProductController.delete)

//Method
router.get('/api/method', auth, PaymentMethodController.index)
router.post('/api/method', auth, GlobalPolicy.isAdmin, PaymentMethodController.create)
router.put('/api/method/:id', auth, GlobalPolicy.isAdmin, PaymentMethodController.update)
router.delete('/api/method/:id', auth, GlobalPolicy.isAdmin, PaymentMethodController.delete)

//Order
router.get('/api/order', auth, OrderController.index)
router.post('/api/order', auth, GlobalPolicy.isAdmin, OrderController.create)
router.put('/api/order/:id', auth, GlobalPolicy.isAdmin, OrderController.update)
router.delete('/api/order/:id', auth, GlobalPolicy.isAdmin, OrderController.delete)


module.exports = router;