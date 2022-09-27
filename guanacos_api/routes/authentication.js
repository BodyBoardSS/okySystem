const express = require('express')
const router = express.Router()
const multer = require('multer')

//Temporary Storage
const upload = multer({
    storage: multer.memoryStorage()
  });

//Controllers
const AuthController = require('../app/controllers/AuthController')


//SigIn & SignUp
router.post('/signin', AuthController.signIn)
router.post('/signup', AuthController.signUp)
router.post('/signUpWithImage',upload.array('image',1), AuthController.signUpWithImage)


module.exports = router;