const { Router } = require('express')
const router = Router()

const auth = require('../app/middlewares/auth')
const GlobalPolicy = require('../app/middlewares/globalPolicy')
const categoryController = require('../app/controllers/CategoryController')


router.get('/', auth, categoryController.index)
router.get('/:id', auth, categoryController.findById)
router.post('/', auth, GlobalPolicy.isAdmin, categoryController.create)
router.put('/', auth, GlobalPolicy.isAdmin, categoryController.find, categoryController.update)
router.delete('/', auth, GlobalPolicy.isAdmin, categoryController.find, categoryController.delete)



module.exports = router