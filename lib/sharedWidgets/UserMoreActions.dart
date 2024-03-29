import 'package:balance/constants.dart';
import 'package:balance/sharedWidgets/PageDivider.dart';
import 'package:balance/sharedWidgets/FooterButton.dart';
import 'package:flutter/material.dart';

class UserMoreActions extends StatelessWidget {
  UserMoreActions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      decoration:
          BoxDecoration(color: snow, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 8.0, right: 26.0, left: 26.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 6,
                    width: 35,
                    decoration: BoxDecoration(
                      color: bone,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 16.0,
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: shark20,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                      ),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 17, bottom: 17),
                        child: Text('Report class',
                            style: TextStyle(
                              color: strawberry,
                              fontFamily: 'SFDisplay',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                    ),
                  ),
                  PageDivider(leftPadding: 0, rightPadding: 0),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: shark20,
                    ),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 17, bottom: 17),
                      child: Text('Share class',
                          style: TextStyle(
                            color: jetBlack80,
                            fontFamily: 'SFDisplay',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                  ),
                  PageDivider(leftPadding: 0, rightPadding: 0),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: shark20,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                    ),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 17, bottom: 17),
                      child: Text('Share trainer',
                          style: TextStyle(
                            color: jetBlack80,
                            fontFamily: 'SFDisplay',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 20),
              child: GestureDetector(
                child: FooterButton(
                    buttonColor: snow,
                    textColor: jetBlack,
                    buttonText: 'Cancel'),
                onTap: () => {Navigator.pop(context)},
              ),
            )
          ],
        ),
      ),
    );
  }
}
