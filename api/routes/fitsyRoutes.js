const express = require('express')
const router = express.Router()
const userController = require('../controllers/userController.js')

router.get('/dashboard', (req, res) =>{
  res.send('Dashboard')
})

//POST

//Add New User
router.post('/adduser', userController.addNew)
//Authenticate User
router.post('/authenticate', userController.authenticate)


//GET

//Get information for a new user
router.get('/getinfo', userController.getinfo)


module.exports = router