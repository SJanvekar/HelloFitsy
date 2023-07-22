import 'package:balance/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class moreClassInfo extends StatelessWidget {
  moreClassInfo({Key? key, required this.inputText}) : super(key: key);

  String inputText;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration:
            BoxDecoration(color: snow, borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.only(left: 26.0, right: 26.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 25,
                    bottom: 25,
                  ),
                  child: SvgPicture.asset(
                    'assets/icons/generalIcons/exit.svg',
                    height: 13,
                    color: jetBlack80,
                  ),
                ),
                onTap: () => {Navigator.of(context).pop()},
              ),
              Text(
                inputText,
                style: TextStyle(
                  fontFamily: 'SFDisplay',
                  color: jetBlack80,
                  fontSize: 14.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ));
  }
}
