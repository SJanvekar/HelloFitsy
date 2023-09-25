const express = require('express')
const router = express.Router()
const classController = require('../controllers/ClassController.js')
const classHistoryController = require('../controllers/ClassHistoryController.js')
const classLikedController = require('../controllers/ClassLikedController.js')
const classPurchasedController = require('../controllers/ClassPurchasedController.js')
const followerController = require('../controllers/FollowerController.js')
const followingController = require('../controllers/FollowingController.js')
const stripeController = require('../controllers/StripeControllerAPI.js')
const userController = require('../controllers/UserController.js')

router.get('/dashboard', (req, res) =>{
  res.send('Dashboard')
})

//****GET REQUESTS****//

  //Class routes
    //Get information for a class
    router.get('/getClasses', classController.getClasses)
    //Search trainers
    router.get('/searchClasses', classController.searchClasses)

  //Class History routes
    //Get current user's class history
    router.get('/getClassHistoryList', classHistoryController.getClassHistoryList)

  //Class Liked routes
    //Get current user's liked classes
    router.get('/getClassLikedList', classLikedController.getClassLikedList)
    //Get boolean if current user liked class
    router.get('/isLiked', classLikedController.isLiked)

  //Class Schedule routes
    //Get information for a class schedule
    router.get('/getSchedule', classPurchasedController.getPurchasedClassSchedule)

  //Follower routes
    //Get current user's follower list
    router.get('/getFollowerList', followerController.getUserFollower)
    //Remove Following
    router.get('/removeFollower', followerController.removeFollower)

  //Following routes
    //Get current user's following list
    router.get('/getFollowingList', followingController.getUserFollowing)
    //Remove Following
    router.get('/removeFollowing', followingController.removeFollowing)
    //Is current user following account
    router.get('/isFollowing', followingController.isFollowing)

  //Stripe Routes
    router.get('/retrieveStripeAccountDetails', stripeController.retrieveStripeAccountDetails)  

  //User routes
    //Get information for a new user
    router.get('/getLogInInfo', userController.getLogInInfo)
    //Search trainers
    router.get('/searchTrainers', userController.searchTrainers)
    //Get trainer info for classes only
    router.get('/getClassTrainerInfo', userController.getClassTrainerInfo)

  router.get('/', (req, res) =>{
    res.send('I am up and running! -- Welcome to Fitsy')
  })

//****POST REQUESTS****//

  //Class routes
    //Add New Class
    router.post('/addclass', classController.addNewClass)

  //Class History routes
    //Add Class History
    router.post('/addClassHistory', classHistoryController.addClassHistory)

  //Class Liked routes
    //Add Class Liked
    router.post('/addClassLiked', classLikedController.addClassLiked)
    //Remove Class Liked
    router.post('/removeClassLiked', classLikedController.removeClassLiked)

  //Class Schedule routes
    router.post('/addClassSchedule', classPurchasedController.addNewClassPurchased)

  //Follower routes
    //Add New Follower
    router.post('/addFollower', followerController.addFollower)

  //Following routes
    //Add New Following
    router.post('/addFollowing', followingController.addFollowing)

  //Stripe routes
    // Create Express account
    router.post('/createStripeAccount', stripeController.createNewStripeAccount)

    // Create Stripe account link
    router.post('/createStripeAccountLink', stripeController.createStripeAccountLink)

  //User routes
    //Add New User
    router.post('/adduser', userController.addNew)
    //Authenticate User
    router.post('/authenticate', userController.authenticate)
    //Update user information
    router.post('/updateUserInfo', userController.updateUserinfo)
    //Update user stripe account ID
    router.post('/updateUserStripeAccountID', userController.updateUserStripeAccountID)
    //Create new payment intent
    router.post('/createPaymentIntent', stripeController.newPaymentIntent)

  

module.exports = router