const express = require('express')
const router = express.Router()
const userController = require('../controllers/userController.js')

router.get('/dashboard', (req, res) =>{
  res.send('Dashboard')
})

//POST
router.get('/', (req, res) =>{
  res.send('I am up and running bitches! -- Welcome to Fitsy')
})

//Add New User
router.post('/adduser', userController.addNew)
//Authenticate User
router.post('/authenticate', userController.authenticate)


//GET

//Get information for a new user
router.get('/getinfo', userController.getinfo)


module.exports = router