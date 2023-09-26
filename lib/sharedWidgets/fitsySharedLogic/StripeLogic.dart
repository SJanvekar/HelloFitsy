import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Requests/StripeRequests.dart';
import '../../Requests/UserRequests.dart';
import '../../feModels/UserModel.dart';

class StripeLogic {
  //Set Up Express Account + generate account url
  stripeSetUp(User userInstance) {
    //If a user account does not exist -- run the logic to create a new account and update on the userInstance/SharedPref level
    if (userInstance.stripeAccountID == null) {
      StripeRequests().createStripeAccount().then((val) async {
        if (val.data['success']) {
          //Initialize Shared Prefs instance
          final sharedPrefs = await SharedPreferences.getInstance();

          //Assign the accountID to the sharedPrefs variable stripeAccountID
          sharedPrefs.setString('stripeAccountID', val.data['id']);

          //Store account ID
          String accountID = val.data['id'];

          //Update the AccountID on the user level in the database
          UserRequests()
              .updateUserStripeAccountID(
            accountID,
            userInstance.userName,
          )
              .then((val) {
            if (val.data['success']) {
              //Update userInstance.StripeAccountID with accountID if successful
              userInstance.stripeAccountID = accountID;

              //Wait 10ms - Avoid async issues with previous function if run (Create account)
              Future.delayed(const Duration(milliseconds: 10), () {
                //Create Account Link (Request)
                StripeRequests()
                    .createStripeAccountLink(userInstance.stripeAccountID)
                    .then((val) async {
                  if (val.data['success']) {
                    print('Stripe account link creation was successful!');

                    //Store accountLinkURL from response
                    final accountLinkURL = Uri.parse(val.data['url']);

                    //Check if Url can be launched and launch url
                    if (await canLaunchUrl(accountLinkURL)) {
                      await launchUrl(accountLinkURL);
                    } else {
                      print('invalid url, cannot launch');
                    }
                  } else {
                    print(val?.data);
                  }
                });
              });
            }
          });
        }
      });
    } else {
      //Get the account id and create a link
      Future.delayed(const Duration(milliseconds: 0), () {
        //Create Account Link (Request)
        StripeRequests()
            .createStripeAccountLink(userInstance.stripeAccountID)
            .then((val) async {
          if (val.data['success']) {
            print('Stripe account link creation was successful!');

            //Store accountLinkURL from response
            final accountLinkURL = Uri.parse(val.data['url']);

            //Check if Url can be launched and launch url
            if (await canLaunchUrl(accountLinkURL)) {
              await launchUrl(accountLinkURL);
            } else {
              print('invalid url, cannot launch');
            }
          } else {
            print(val?.data);
          }
        });
      });
    }
  }

  //Check if details are submitted
  stripeDetailsSubmitted(
    User userInstance,
  ) {
    StripeRequests()
        .retrieveStripeAccount(userInstance.stripeAccountID)
        .then((val) async {
      if (val.data['success']) {
        final accountDetails = val.data['account'];
        // Check if 'details_submitted' exists in the response
        if (accountDetails != null &&
            accountDetails.containsKey('details_submitted')) {
          final isStripeDetailsSubmitted = accountDetails['details_submitted'];
          //Initialize Shared Prefs instance
          final sharedPrefs = await SharedPreferences.getInstance();

          //Assign the accountID to the sharedPrefs variable stripeAccountID
          sharedPrefs.setString(
              'isStripeDetailsSubmitted', '$isStripeDetailsSubmitted');
          userInstance.isStripeDetailsSubmitted = isStripeDetailsSubmitted;
        }
      }
    });
  }
}
