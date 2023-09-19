import 'package:balance/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../feModels/UserModel.dart';
import '../../../Requests/StripeRequests.dart';

// var image = AssetImage('assets/images/profilePictureDefault.png');
var image;

class SetUpTrainerStripeAccount extends StatefulWidget {
  SetUpTrainerStripeAccount({Key? key, required this.userInstance})
      : super(key: key);

  final User userInstance;

  @override
  State<SetUpTrainerStripeAccount> createState() =>
      _SetUpTrainerStripeAccountState();
}

void stripeSetUp() {
  StripeRequests().createStripeAccount().then((val) async {
    if (val?.data['success'] ?? false) {
      print('Stripe Account Creation was Successful!');
      print(val.data['id']);

      //Initialize Shared Prefs instance
      final sharedPrefs = await SharedPreferences.getInstance();

      //Assign the accountID to the sharedPrefs variable stripeAccountID
      sharedPrefs.setString('stripeAccountID', val.data['id']);
      //Store account ID
      String accountID = val.data['id'];

      //Wait 50ms - Avoid async issues
      Future.delayed(const Duration(milliseconds: 50), () {
        //Create Account Link (Request)
        StripeRequests().createStripeAccountLink(accountID).then((val) async {
          if (val?.data['success'] ?? false) {
            print('Stripe Account Creation was Successful!');
            print(val.data['url']);

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

class _SetUpTrainerStripeAccountState extends State<SetUpTrainerStripeAccount> {
  bool isEnabled = true;
  var buttonColorEnabled = strawberry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: isEnabled
                  ? Image.asset(
                      'assets/images/getPaid.png',
                      height: 100,
                    )
                  : LoadingAnimationWidget.discreteCircle(
                      color: strawberry,
                      secondRingColor: strawberry40,
                      thirdRingColor: bone,
                      size: 100,
                    )),
          if (isEnabled == true) pageTitle(),
          if (isEnabled == true) pageText(),
          if (isEnabled == true)
            Padding(
              padding: EdgeInsets.only(
                top: 20,
                bottom: 20,
              ),
              child: GestureDetector(
                child: connectWithStripe(),
                onTap: () {
                  if (isEnabled) {
                    Future.delayed(Duration(milliseconds: 100), () {
                      HapticFeedback.mediumImpact;
                      setState(() {
                        //Set isEnabled to false
                        isEnabled = !isEnabled;
                      });
                      stripeSetUp();
                    });
                  }
                },
              ),
            ),
          if (isEnabled == true)
            GestureDetector(
              child: const Text('I\'ll do this later',
                  style: buttonText3Jetblack40),
              onTap: () => Navigator.of(context).pop(),
            ),
        ],
      ),
    );
  }

  Widget pageTitle() {
    return Center(
      child: Container(
          decoration: BoxDecoration(color: snow),
          child: Text(
            'Get paid with Fitsy',
            style: sectionTitles,
          )),
    );
  }

  Widget pageText() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 5,
      ),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: popUpMenuText,
          children: [
            TextSpan(
              text:
                  'Connect your bank account details to start receiving payouts from your classes',
            )
          ],
        ),
      ),
    );
  }

  Widget connectWithStripe() {
    return Container(
        decoration: BoxDecoration(
            color: buttonColorEnabled, borderRadius: BorderRadius.circular(20)),
        child: const Padding(
          padding: EdgeInsets.only(
            left: 50.0,
            right: 50.0,
            top: 10,
            bottom: 10,
          ),
          child: Text(
            'Set up account',
            style: buttonText2snow,
          ),
        ));
  }

  Widget skip() {
    return Text('I\'ll do this later', style: buttonText3Jetblack40);
  }
}
