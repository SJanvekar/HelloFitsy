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

  //Create new Stripe Customer & Payment Intent
  newPaymentIntent: async function (req, res){
    try {
      
      // Payment intents require CustomerID, so create that first
      // CustomerID null check
      var customerID;
  
      if (req.body.customerID == null) {
        const customer = await fitsyStripe.customers.create(
        {  name: req.body.customerName,
          email: req.body.receipt_email, }
        );
        customerID = customer.id;
      } 
      else {
        customerID = req.body.customerID;
      }
  
      // Generate Ephemeral Key (Grants SDK temporary access to customer)
      const ephemeralKey = await fitsyStripe.ephemeralKeys.create(
        {customer: customerID},
        //TODO: Hardcoded apiVersion, fix later
        {apiVersion: '2022-11-15'}
      );
      
      // Create payment intent
      const paymentIntent = await fitsyStripe.paymentIntents.create({
        amount: req.body.amount,
        currency: 'cad',
        // customer: customerID,
        receipt_email: req.body.receipt_email,
        // In the latest version of the API, specifying the `automatic_payment_methods` 
        // parameter is optional because Stripe enables its functionality by default.
        automatic_payment_methods: {
          enabled: true,
        },
        application_fee_amount: req.body.fitsyFee,
        transfer_data: {
          destination: req.body.accountID,
        },
      });
  
      res.json({ 
        success: true, 
        msg: 'Successfully created new payment intent', 
        paymentIntent: paymentIntent, 
        client_secret: paymentIntent.client_secret, 
        customerID: customerID, 
        ephemeralKey: ephemeralKey
      });
    } catch (err) {
      res.status(500).json({ 
        success: false, 
        msg: 'Error creating new payment intent', 
        error: err.message 
      });
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