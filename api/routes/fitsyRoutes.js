const express = require('express')
const router = express.Router()
const userController = require('../controllers/userController.js')
const classController = require('../controllers/classController.js')
const followingController = require('../controllers/followingController.js')
const followerController = require('../controllers/followerController.js')

router.get('/dashboard', (req, res) =>{
  res.send('Dashboard')
})

//GET

  //Get information for a new user
  router.get('/getinfo', userController.getinfo)
  //Get information for a new class
  router.get('/getClasses', classController.getClasses)
  //Get current user's following list
  router.get('/getFollowingList', followingController.getUserFollowing)
  //Get current user's follower list
  router.get('/getFollowerList', followerController.getUserFollower)

  router.get('/', (req, res) =>{
    res.send('I am up and running bitches! -- Welcome to Fitsy')
  })

//POST

  //Add New User
  router.post('/adduser', userController.addNew)
  //Authenticate User
  router.post('/authenticate', userController.authenticate)
  //Add New Class
  router.post('/addclass', classController.addNewClass)
  //Update user information
  router.post('/updateUserInfo', userController.updateUserinfo)
  //Add New Following
  router.post('/addFollowing', followingController.addFollowing)
  //Add New Follower
  router.post('/addFollower', followerController.addFollower)

//TESTING
  router.post('/testing', classController.testing)

//PUT

module.exports = router