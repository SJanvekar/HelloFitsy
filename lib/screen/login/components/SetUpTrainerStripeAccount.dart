import 'package:balance/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../feModels/UserModel.dart';

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

class _SetUpTrainerStripeAccountState extends State<SetUpTrainerStripeAccount> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Image.asset(
              'assets/images/getPaid.png',
              height: 100,
            ),
          ),
          pageTitle(),
          pageText(),
          Padding(
              padding: EdgeInsets.only(
                top: 20,
                bottom: 20,
              ),
              child: connectWithStripe()),
          GestureDetector(
            child: Text('I\'ll do this later', style: buttonText3Jetblack40),
            onTap: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
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
          color: strawberry, borderRadius: BorderRadius.circular(20)),
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
