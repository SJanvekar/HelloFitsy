const dotenv = require('dotenv');
dotenv.config();

//Get Stripe Key & intialize stripe variable
const StripeKey = process.env.STRIPE_SECRET
const fitsyStripe = require('stripe')(StripeKey);


var functions = {

// Create Stripe Account Link
createStripeAccountLink: async function (req, res) {
  // Check if the 'account' parameter is present in the request body

  if (!req.body.account) {
    return res.status(400).json({ success: false, msg: 'Missing account parameter in the request body ' + req.body.account});

  }

  try {
  
    const accountLink = await fitsyStripe.accountLinks.create({
      account: req.body.account,
      refresh_url: 'http://localhost:8888/createStripeAccountLink',
      return_url: 'http://localhost:8888',
      type: 'account_onboarding',   
    });

    res.json({ success: true, msg: 'Successfully created Stripe Account Link', url: accountLink.url });
    

  } catch (err) {
    res.status(500).json({ success: false, msg: 'Error creating Stripe Account Link', error: err.message });
  }
},
  
  //Create new Stripe Connected Account
  createNewStripeAccount: async function (req, res){
    try {
      const account = await fitsyStripe.accounts.create({
        type: 'express',
      });
  
      res.json({ success: true, msg: 'Successfully created Stripe Account', id: account.id });
    } catch (err) {
      res.status(500).json({ success: false, msg: 'Error creating Stripe Account', error: err.message });
    }
  },

  //Retrieve Account Details
  retrieveStripeAccountDetails: async function (req, res){
    try {
      const accountID = req.query.accountID; // Retrieve the account ID from the request query parameters
  
      const account = await fitsyStripe.accounts.retrieve(accountID);
  
      // Respond with the Stripe account details
      res.status(200).json({success: true, account: account});
    } catch (error) {
      console.error(error);
      res.status(500).json({ success: false, error: 'Error retrieving Stripe account details' });
    }
  }
    
}

module.exports = functions