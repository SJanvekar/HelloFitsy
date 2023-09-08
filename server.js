const express = require('express')
const morgan = require('morgan')
const cors = require('cors')
const connectDB = require('./config/Public/db')
const passport = require('passport')
const bodyParser = require('body-parser')
const routes = require( './api/routes/fitsyRoutes')
const config = require('config')
connectDB()
const app = express()
const dotenv = require('dotenv');
dotenv.config();

if(process.env.NODE_ENV === 'development'){
  app.use(morgan('dev'))
}

const stripe = require('stripe')('process.env.STRIPE_SECRET');
const account = await stripe.accounts.create({
  type: 'express',
});

app.use(cors())
app.use(bodyParser.urlencoded({ extended: false}))
app.use(bodyParser.json())
app.use(routes)
app.use(passport.initialize())
require('./config/Public/passport')(passport)

const PORT  = process.env.PORT || 8888

app.listen(PORT, console.log('Fitsy Server running in',process.env.NODE_ENV, 'mode on port', PORT))

// Note: In order to run the server properly to test, enter this command whilst in terminal and in the Backbone folder: npm run dev //