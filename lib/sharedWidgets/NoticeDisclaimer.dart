// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:balance/constants.dart';
import 'package:balance/sharedWidgets/BodyButton.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class NoticeDisclaimer extends StatelessWidget {
  NoticeDisclaimer(
      {Key? key,
      required this.textBoxSize,
      required this.disclaimerTitle,
      required this.disclaimerText,
      required this.buttonText,
      required this.buttonLeftRightPadding})
      : super(key: key);

  double textBoxSize;
  String disclaimerTitle;
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
          decoration: BoxDecoration(
            color: snow,
            boxShadow: <BoxShadow>[
              BoxShadow(
                offset: Offset(0, 0),
                blurRadius: 8,
                color: jetBlack.withOpacity(0.4),
              ),
            ],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            height: 80,
            width: width,
            decoration: BoxDecoration(
              color: jetBlack,
              borderRadius: BorderRadius.circular(15),
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
                                disclaimerTitle,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: snow,
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
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w400,
                                      color: snow,
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
                      padding: const EdgeInsets.only(
                        right: 12.0,
                        top: 10,
                        bottom: 10,
                      ),
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
        ),
      ],
    );
  }
}
