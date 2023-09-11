const dotenv = require('dotenv');
dotenv.config();
const stripe = require('stripe')(process.env.STRIPE_SECRET);


var functions = {

  createStripeAccountLink: async function (req, res){
    const accountLink = await stripe.accountLinks.create({
      account: req.params.account,
      refresh_url: 'http://localhost:8888/createStripeAccountLink/{{account}}',
      return_url: 'http://localhost:8888',
      type: 'account_onboarding',
    });
    if(err) {
      res.json({success: false, msg: err})
     }
    else {
      res.json({success: true, msg: 'Successfully created Stripe Account Link'})
  }
  },

    createNewStripeAccount: async function (req, res){
    const account = await stripe.accounts.create({
      type: 'express',
    });
    if(err) {
      res.json({success: false, msg: err})
     }
    else {
      res.json({success: true, msg: 'Successfully created Stripe Account'})
      createStripeAccountLink(req,res,account)
  }
  },

    //Create Stripe Account Link
    
}

module.exports = functions