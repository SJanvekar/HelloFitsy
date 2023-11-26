import 'package:balance/constants.dart';
import 'package:balance/sharedWidgets/PageDivider.dart';
import 'package:balance/sharedWidgets/categories/AddRemoveButton.dart';
import 'package:balance/sharedWidgets/loginFooterButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class classMoreActions extends StatelessWidget {
  classMoreActions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: snow, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.only(top: 40.0, bottom: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 8.0, right: 26.0, left: 26.0),
              child: Row(
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Container(
                        height: 90,
                        decoration: const BoxDecoration(
                          color: bone80,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        alignment: Alignment.center,
                        child: const Padding(
                          padding: const EdgeInsets.only(top: 17, bottom: 17),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 5.0),
                                child: Icon(
                                  Icons.report_rounded,
                                  color: strawberry,
                                  size: 25,
                                ),
                              ),
                              Text('Report',
                                  style: TextStyle(
                                    color: strawberry,
                                    fontFamily: 'SFDisplay',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                      child: Container(
                        height: 90,
                        decoration: const BoxDecoration(
                          color: bone80,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        alignment: Alignment.center,
                        child: const Padding(
                          padding: const EdgeInsets.only(top: 17, bottom: 17),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 5.0),
                                child: Icon(
                                  Icons.block,
                                  color: strawberry,
                                  size: 25,
                                ),
                              ),
                              Text('Block',
                                  style: TextStyle(
                                    color: strawberry,
                                    fontFamily: 'SFDisplay',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: GestureDetector(
                        child: Container(
                          height: 90,
                          decoration: const BoxDecoration(
                            color: bone80,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          alignment: Alignment.center,
                          child: const Padding(
                            padding: const EdgeInsets.only(top: 17, bottom: 17),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5.0),
                                  child: Icon(
                                    Icons.share_rounded,
                                    color: jetBlack,
                                    size: 25,
                                  ),
                                ),
                                Text('Share',
                                    style: TextStyle(
                                      color: jetBlack,
                                      fontFamily: 'SFDisplay',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    )),
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          HapticFeedback.selectionClick();
                          Share.share('Checkout this class I found!');
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
                bottom: 20,
                left: 26.0,
                right: 26.0,
              ),
              child: GestureDetector(
                child: FooterButton(
                    buttonColor: bone80,
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
