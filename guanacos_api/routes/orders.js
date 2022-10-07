const { Router } = require('express')
const router = Router()

const auth = require('../app/middlewares/auth')
const orderController = require('../app/controllers/OrderController')


router.get('/', auth, orderController.index)
router.get('/:status', auth, orderController.findByStatus)
router.get('/:status/:iduser', auth, orderController.findByIdUser)
router.post('/', auth, orderController.create)
router.put('/:id', auth, orderController.find, orderController.update)

module.exports = router