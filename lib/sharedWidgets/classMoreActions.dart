import 'package:balance/constants.dart';
import 'package:balance/sharedWidgets/loginFooterButton.dart';
import 'package:balance/sharedWidgets/pageDivider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class classMoreActions extends StatelessWidget {
  const classMoreActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 315,
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 10.0, right: 26.0, left: 26.0),
              child: Container(
                  decoration: const BoxDecoration(
                      color: snow,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                        child: Text('Report',
                            style: TextStyle(
                              color: strawberry,
                              fontFamily: 'SFDisplay',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10),
                        child: PageDivider(),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                        child: Text('Block',
                            style: TextStyle(
                              color: strawberry,
                              fontFamily: 'SFDisplay',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10),
                        child: PageDivider(),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                        child: Text('Share this profile',
                            style: TextStyle(
                              color: jetBlack,
                              fontFamily: 'SFDisplay',
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10),
                        child: PageDivider(),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                        child: Text('Copy profile url',
                            style: TextStyle(
                              color: jetBlack,
                              fontFamily: 'SFDisplay',
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                    ],
                  )),
            ),
            GestureDetector(
              child: LoginFooterButton(
                  buttonColor: snow, textColor: jetBlack, buttonText: 'Cancel'),
              onTap: () => {Navigator.pop(context)},
            )
          ],
        ),
      ),
    );
  }
}
