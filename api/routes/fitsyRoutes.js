const express = require('express')
const router = express.Router()
const userController = require('../controllers/userController.js')
const classController = require('../controllers/classController.js')

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
//Add New Class
router.post('/addclass', classController.addNewClass)
//TESTING
router.post('/testing', classController.testing)

//GET

//Get information for a new user
router.get('/getinfo', userController.getinfo)
//Get information for a new class
router.get('/getClasses', classController.getClasses)
//Get current user's following list
router.get('/getUserFollowing', userController.getUserFollowing)

module.exports = router