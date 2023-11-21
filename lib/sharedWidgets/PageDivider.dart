import 'package:balance/constants.dart';
import 'package:flutter/cupertino.dart';

class PageDivider extends StatelessWidget {
  PageDivider({Key? key, required this.leftPadding, required this.rightPadding})
      : super(key: key);
  double leftPadding;
  double rightPadding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: leftPadding, right: rightPadding),
      child: Center(
        child: Container(
          height: 1,
          decoration: BoxDecoration(
            color: shark40,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
    );
  }
}
