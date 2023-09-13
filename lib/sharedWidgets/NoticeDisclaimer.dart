// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:balance/constants.dart';
import 'package:balance/sharedWidgets/BodyButton.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class NoticeDisclaimer extends StatelessWidget {
  NoticeDisclaimer(
      {Key? key,
      required this.textBoxSize,
      required this.disclaimerText,
      required this.buttonText,
      required this.buttonLeftRightPadding})
      : super(key: key);

  double textBoxSize;
  String disclaimerText;
  String buttonText;
  double buttonLeftRightPadding;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width - (20 * 2);
    return Column(
      children: [
        //Notice Card
        Container(
          height: 100,
          width: width,
          decoration: BoxDecoration(
            color: strawberry.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, top: 12, bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    //Notice Details
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 3.0),
                            child: Text(
                              'Notice',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: jetBlack,
                                  fontFamily: 'SFDisplay'),
                            ),
                          ),
                          SizedBox(
                            width: textBoxSize,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 3.0),
                              child: Text(
                                disclaimerText,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: jetBlack,
                                    fontFamily: 'SFDisplay'),
                                maxLines: 2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                    padding:
                        const EdgeInsets.only(right: 12.0, top: 20, bottom: 20),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: strawberry,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: buttonLeftRightPadding,
                          right: buttonLeftRightPadding,
                          top: 10,
                          bottom: 10,
                        ),
                        child: Text(
                          buttonText,
                          style: buttonText2snow,
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
