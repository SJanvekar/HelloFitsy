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
  Widget textInputEmail(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: bone60,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: Center(
                  child: SvgPicture.asset(
                'assets/icons/generalIcons/mail.svg',
                width: 18,
                color: jetBlack40,
              )),
            ),
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
                  color: jetBlack80,
                  fontSize: 15,
                  fontWeight: FontWeight.w700),
              decoration: InputDecoration.collapsed(
                border: InputBorder.none,
                hintText: 'Email',
                hintStyle: const TextStyle(
                  fontFamily: 'SFDisplay',
                  color: shark,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onChanged: (val) {
                userTemplate.userEmail = val;
              },
              textInputAction: TextInputAction.done,
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(right: 20, left: 10),
              child: GestureDetector(
                child: SvgPicture.asset(
                    'assets/icons/generalIcons/information.svg',
                    color: jetBlack40,
                    height: 20,
                    width: 20),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          informationDialog(context));
                },
              ))
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
          padding: const EdgeInsets.only(
            left: 0,
            right: 158,
          ),
          child: TextButton(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.transparent;
                }
                return snow;
              }),
            ),
            onPressed: () {
              print("Personal Information Pressed");
              Navigator.of(context).pop();
            },
            child: Text("Cancel", style: logInPageNavigationButtons),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 26.0, right: 26.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 8.0,
                  ),
                  child: Text(
                    'Forgot your password?',
                    style: logInPageTitle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 30.0,
                  ),
                  child: Text(
                    'No problem, we’ve got you covered!',
                    style: logInPageBodyText,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 45.0,
                  ),
                  child: Text(
                    'Please enter your email below and we’ll send you a link to reset your password.',
                    textAlign: TextAlign.center,
                    style: profileBodyTextFont,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 35.0),
                  child: textInputEmail(context),
                ),
                GestureDetector(
                  child: FooterButton(
                      buttonColor: strawberry,
                      textColor: snow,
                      buttonText: 'Reset Password'),
                  onTap: () => {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
