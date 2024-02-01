import 'package:balance/fitsy_icons_set1_icons.dart';
import 'package:balance/screen/login/components/SignIn.dart';
import 'package:balance/screen/login/components/personalInfo.dart';
import 'package:balance/sharedWidgets/loginFooterButton.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';

class ForgotPasswordPage extends StatelessWidget {
//------Widgets-------//

//Email
  Widget textInputPhone(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: snow,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: jetBlack40),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 10),
            child: Center(
                child: SvgPicture.asset(
              'assets/icons/generalIcons/phone.svg',
              width: 18,
              color: jetBlack60,
            )),
          ),
          Expanded(
            child: TextFormField(
              validator: (value) {
                if (EmailValidator.validate(value!)) {
                  return null;
                }
                print('object');
                return 'Please enter a valid email address.';
              },
              autocorrect: true,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(
                  fontFamily: 'SFDisplay',
                  color: jetBlack,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
              decoration: InputDecoration.collapsed(
                border: InputBorder.none,
                hintText: 'Phone',
                hintStyle: const TextStyle(
                  fontFamily: 'SFDisplay',
                  color: jetBlack40,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onChanged: (val) {},
              textInputAction: TextInputAction.done,
            ),
          ),
        ],
      ),
    );
  }

  //-------Main Code Body-------//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: snow,
      appBar: AppBar(
        toolbarHeight: 50,
        centerTitle: false,
        elevation: 0,
        backgroundColor: snow,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                child: const Icon(
                  Icons.close_rounded,
                  color: jetBlack80,
                  size: 25,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 26.0, right: 26.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    bottom: 8.0,
                  ),
                  child: Text(
                    'Forgot your password?',
                    style: logInPageTitleH2,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10.0,
                  ),
                  child: Text(
                    'No problem, we’ve got you covered!',
                    style: logInPageBodyText,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 30.0,
              ),
              child: Text(
                'Please enter your phone number below, and we’ll get started with your password reset.',
                textAlign: TextAlign.left,
                style: logInPageBodyTextNote,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: textInputPhone(context),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 45.0),
              child: GestureDetector(
                child: FooterButton(
                    buttonColor: strawberry,
                    textColor: snow,
                    buttonText: 'Reset Password'),
                onTap: () => {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
