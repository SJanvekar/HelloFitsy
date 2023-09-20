import 'package:balance/Requests/UserRequests.dart';
import 'package:balance/constants.dart';
import 'package:balance/screen/login/components/SignIn.dart';
import 'package:balance/sharedWidgets/fitsySharedLogic/StripeLogic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../feModels/UserModel.dart';
import '../../../Requests/StripeRequests.dart';

class SetUpTrainerStripeAccount extends StatefulWidget {
  SetUpTrainerStripeAccount({Key? key, required this.userInstance})
      : super(key: key);

  final User userInstance;

  @override
  State<SetUpTrainerStripeAccount> createState() =>
      _SetUpTrainerStripeAccountState();
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
          if (isEnabled == true)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  pageTitle(),
                  pageText(),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 20,
                      bottom: 20,
                    ),
                    child: GestureDetector(
                      child: connectWithStripe(),
                      onTap: () {
                        if (isEnabled) {
                          Future.delayed(Duration(milliseconds: 50), () {
                            HapticFeedback.mediumImpact;
                            setState(() {
                              //Set isEnabled to false
                              isEnabled = !isEnabled;
                            });
                            StripeLogic().stripeSetUp(widget.userInstance);
                          });
                        }
                      },
                    ),
                  ),
                  GestureDetector(
                    child: const Text('I\'ll do this later',
                        style: buttonText3Jetblack40),
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            )
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
