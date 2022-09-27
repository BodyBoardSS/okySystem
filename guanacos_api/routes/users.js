const { Router } = require('express')
const router = Router()
const multer = require('multer')

const auth = require('../app/middlewares/auth')
const userController = require('../app/controllers/UserController')

//Temporary Storage
const upload = multer({
    storage: multer.memoryStorage()
  });

router.put('/updateWithImage', auth, upload.array('image',1), userController.updateUserWithImage)
router.put('/', auth, userController.update)


module.exports = router