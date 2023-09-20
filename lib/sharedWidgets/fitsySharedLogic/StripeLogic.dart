import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Requests/StripeRequests.dart';
import '../../Requests/UserRequests.dart';
import '../../feModels/UserModel.dart';

class StripeLogic {
  //Set Up Express Account
  stripeSetUp(User userInstance) {
    StripeRequests().createStripeAccount().then((val) async {
      if (val.data['success']) {
        //Initialize Shared Prefs instance
        final sharedPrefs = await SharedPreferences.getInstance();

        //Assign the accountID to the sharedPrefs variable stripeAccountID
        sharedPrefs.setString('stripeAccountID', val.data['id']);

        //Store account ID
        String accountID = val.data['id'];

        //Wait 50ms - Avoid async issues
        Future.delayed(const Duration(milliseconds: 0), () {
          //Update the AccountID on the user level in the database
          UserRequests()
              .updateUserStripeAccountID(
            accountID,
            userInstance.userName,
          )
              .then((val) {
            if (val.data['success']) {
              print('Stripe Account update was successful');
            }
          });

          //Create Account Link (Request)
          StripeRequests().createStripeAccountLink(accountID).then((val) async {
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

  //Check if details are submitted
  stripeDetailsSubmitted(
    User userInstance,
  ) {
    StripeRequests()
        .retrieveStripeAccount(userInstance.stripeAccountID)
        .then((val) async {
      if (val.data['success']) {
        bool isStripeDetailsSubmitted = val.data['details_submitted'];

        //Initialize Shared Prefs instance
        final sharedPrefs = await SharedPreferences.getInstance();

        //Assign the accountID to the sharedPrefs variable stripeAccountID
        sharedPrefs.setString(
            'isStripeDetailsSubmitted', '$isStripeDetailsSubmitted');
      }
    });
  }
}
