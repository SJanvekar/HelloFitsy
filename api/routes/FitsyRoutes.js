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
    router.get('/getClassPurchased', classPurchasedController.getClassPurchased)

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
    //Get trainer info for classes only
    router.get('/getClassTrainerInfo', userController.getClassTrainerInfo)
    //Get information for a new user
    router.get('/getLogInInfo', userController.getLogInInfo)
    //Get information for a new user
    router.get('/getUserInfo', userController.getUserInfo)
    //Search trainers
    router.get('/searchTrainers', userController.searchTrainers)

  router.get('/', (req, res) =>{
    res.send('I am up and running! -- Welcome to Fitsy')
  })

//****POST REQUESTS****//

  //Class routes
    //Add New Class
    router.post('/addclass', classController.addNewClass)
    //Add Class Schedule
    router.post('/addClassTimes', classController.addClassTimes)
    //Change Class Schedule
    router.post('/changeClassTimes', classController.changeClassTimes)
    //Remove Class Schedule
    router.post('/removeClassTimes', classController.removeClassTimes)
    //Add Updated Class Schedule
    router.post('/addUpdatedClassTimes', classController.addUpdatedClassTimes)
    //Change Updated Class Schedule
    router.post('/changeUpdatedClassTimes', classController.changeUpdatedClassTimes)
    //Remove Updated Class Schedule
    router.post('/removeUpdatedClassTimes', classController.removeUpdatedClassTimes)
    //Add Cancelled Class Schedule
    router.post('/addCancelledClassTimes', classController.addCancelledClassTimes)
    //Remove Cancelled Class Schedule
    router.post('/removeCancelledClassTimes', classController.removeCancelledClassTimes)

  //Class History routes
    //Add Class History
    router.post('/addClassHistory', classHistoryController.addClassHistory)

  //Class Liked routes
    //Add Class Liked
    router.post('/addClassLiked', classLikedController.addClassLiked)
    //Remove Class Liked
    router.post('/removeClassLiked', classLikedController.removeClassLiked)

  //Class Purchased routes
    //Add Class Purchased
    router.post('/addClassPurchased', classPurchasedController.addNewClassPurchased)
    //Add Class Purchased Update Schedule
    router.post('/addClassPurchasedUpdatedSchedule', classPurchasedController.addClassPurchasedUpdatedSchedule)
    //Change Class Purchased Update Schedule
    router.post('/changeClassPurchasedUpdatedSchedule', classPurchasedController.changeClassPurchasedUpdatedSchedule)
    //Add Class Purchased Cancelled Schedule
    router.post('/addClassPurchasedCancelledSchedule', classPurchasedController.addClassPurchasedCancelledSchedule)
    //Add Class Purchased Missed
    router.post('/addClassPurchasedMissed', classPurchasedController.addClassPurchasedMissed)
    //Add Class Purchased Cancelled
    router.post('/addClassPurchasedCancelled', classPurchasedController.addClassPurchasedCancelled)
    //Add Class Purchased Cancellation Reason
    router.post('/addClassPurchasedCancelReason', classPurchasedController.addClassPurchasedCancelReason)

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
    //Update user stripe account ID
    router.post('/updateUserStripeCustomerID', userController.updateUserStripeCustomerID)
    //Create new payment intent
    router.post('/newPaymentIntent', stripeController.newPaymentIntent)

module.exports = router