const express = require('express')
const morgan = require('morgan')
const cors = require('cors')
const connectDB = require('./config/Public/db')
const passport = require('passport')
const bodyParser = require('body-parser')
const routes = require( './api/routes/FitsyRoutes')
const path = require('path'); 
connectDB()
const app = express()
const dotenv = require('dotenv');
dotenv.config();

if(process.env.NODE_ENV === 'development'){
  app.use(morgan('dev'))
}

// Serve static files from the 'public' directory
app.use(express.static('public'));

// Route to serve the AASA file from the '.well-known' directory
app.get('/apple-app-site-association', (req, res) => {
  // Construct an absolute path to the AASA file
  const aasaFilePath = path.join(__dirname, 'apple-app-site-association');
    // Set appropriate headers to allow the AASA file to be read by browsers
    res.setHeader('Content-Type', 'application/json');
    res.setHeader('Content-Disposition', 'inline');
  
    // Send the AASA file
    res.sendFile(aasaFilePath);
  });
  // Send the AASA file



app.use(cors())
app.use(bodyParser.urlencoded({ extended: false}))
app.use(bodyParser.json())
app.use(routes)
app.use(passport.initialize())
require('./config/Public/passport')(passport)

const PORT  = process.env.PORT || 8888

app.listen(PORT, console.log('Fitsy Server running in',process.env.NODE_ENV, 'mode on port', PORT))

// Note: In order to run the server properly to test, enter this command whilst in terminal and in the Backbone folder: npm run dev //