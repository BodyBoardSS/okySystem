const { Router } = require('express')
const router = Router()

const auth = require('../app/middlewares/auth')
const addressController = require('../app/controllers/AddressController')


router.get('/', auth, addressController.index)
router.get('/:userId', auth, addressController.findByUser)
router.post('/', auth, addressController.create)
router.put('/:id', auth, addressController.find, addressController.update)

module.exports = router