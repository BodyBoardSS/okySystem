const { Router } = require('express')
const router = Router()
const multer = require('multer')

const auth = require('../app/middlewares/auth')
const GlobalPolicy = require('../app/middlewares/globalPolicy')
const productController = require('../app/controllers/ProductController')

//Temporary Storage
const upload = multer({
    storage: multer.memoryStorage()
  });

router.get('/', auth, productController.index)
router.get('/:categoryId', auth, productController.findByCategory)
router.get('/:categoryId/:name', auth, productController.findByCategoryAndName)
router.post('/', auth, upload.array('image',3), GlobalPolicy.isAdmin, productController.create)
router.put('/', auth, GlobalPolicy.isAdmin, productController.update)
router.delete('/', auth, GlobalPolicy.isAdmin, productController.delete)


module.exports = router