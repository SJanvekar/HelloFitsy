import 'package:balance/constants.dart';
import 'package:flutter/cupertino.dart';

class PageDivider extends StatelessWidget {
  const PageDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 1,
        width: 335,
        decoration:
            BoxDecoration(color: bone, borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
