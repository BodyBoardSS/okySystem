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
router.get('/api/categories', auth, CategoryController.index)
router.get('/api/categories/:id', auth, CategoryController.find, CategoryController.update)
router.post('/api/categories', auth, GlobalPolicy.isAdmin, CategoryController.create)
router.put('/api/categories', auth, GlobalPolicy.isAdmin, CategoryController.find, CategoryController.update)
router.delete('/api/categories', auth, GlobalPolicy.isAdmin, CategoryController.find, CategoryController.delete)

//Product
router.get('/api/products', auth, ProductController.index)
router.get('/api/products/:categoryId', auth, ProductController.findByCategory)
router.post('/api/products', auth, upload.array('image',3), GlobalPolicy.isAdmin, ProductController.create)
router.put('/api/products', auth, GlobalPolicy.isAdmin, ProductController.update)
router.delete('/api/products', auth, GlobalPolicy.isAdmin, ProductController.delete)

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