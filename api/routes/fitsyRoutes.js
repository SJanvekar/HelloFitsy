const express = require('express')
const router = express.Router()
const userController = require('../controllers/userController.js')
const classController = require('../controllers/classController.js')

router.get('/dashboard', (req, res) =>{
  res.send('Dashboard')
})

//GET
  router.get('/', (req, res) =>{
    res.send('I am up and running bitches! -- Welcome to Fitsy')
  })
  //User routes
    //Get information for a new user
    router.get('/getinfo', userController.getinfo)
    //Get current user's following list
    router.get('/getUserFollowing', userController.getUserFollowing)
    //Search trainers
    router.get('/searchTrainers', userController.searchTrainers)
  //Class routes
    //Get information for a new class
    router.get('/getClasses', classController.getClasses)

//POST
  //User routes
    //Add New User
    router.post('/adduser', userController.addNew)
    //Authenticate User
    router.post('/authenticate', userController.authenticate)
    //Update user information
    router.post('/updateUserInfo', userController.updateUserinfo)
  //Class routes
    //Add New Class
    router.post('/addclass', classController.addNewClass)
    //TESTING
    router.post('/testing', classController.testing)

module.exports = router