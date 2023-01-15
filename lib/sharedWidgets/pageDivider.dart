import 'package:balance/constants.dart';
import 'package:flutter/cupertino.dart';

class PageDivider extends StatelessWidget {
  const PageDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Center(
        child: Container(
          height: 0.66,
          decoration: BoxDecoration(
              color: shark40, borderRadius: BorderRadius.circular(100)),
        ),
      ),
    );
  }
}
