const express = require('express')
const router = express.Router()
const userController = require('../controllers/userController.js')
const classController = require('../controllers/classController.js')
const followingController = require('../controllers/followingController.js')
const followerController = require('../controllers/followerController.js')
const classLikedController = require('../controllers/classLikedController.js')
const classHistoryController = require('../controllers/classHistoryController.js')

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
  //Get current user's liked classes
  router.get('/getClassLikedList', classLikedController.getClassLikedList)
  //Get current user's class history
  router.get('/getClassHistoryList', classHistoryController.getClassHistoryList)

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
  //Add New Following
  router.post('/addFollowing', followingController.addFollowing)
  //Add New Follower
  router.post('/addFollower', followerController.addFollower)
  //Add Liked Class
  router.post('/addClassLiked', classLikedController.addClassLiked)
  //Add Class History
  router.post('/addClassLiked', classHistoryController.addClassHistory)
  //Update user information
  router.post('/updateUserInfo', userController.updateUserinfo)

//TESTING
  router.post('/testing', classController.testing)

//PUT

module.exports = router