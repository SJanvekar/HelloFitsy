import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:balance/constants.dart';
import 'package:balance/example.dart';
import 'package:balance/screen/login/components/categorySelection.dart';
import 'package:balance/screen/login/login.dart';
import 'package:balance/screen/login/components/profilePictureUpload.dart';
import 'package:balance/screen/login/loginSharedWidgets/userTextInput.dart';
import 'package:balance/screen/login/components/personalInfo.dart';
import 'package:balance/sharedWidgets/loginFooterButton.dart';
import 'package:balance/sharedWidgets/pageDivider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/services.dart';

class SearchBarRO extends StatefulWidget {
  const SearchBarRO({Key? key}) : super(key: key);

  @override
  State<SearchBarRO> createState() => _SearchBarROState();
}

var _controller = TextEditingController();
var userInput;

class _SearchBarROState extends State<SearchBarRO> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 26.0, right: 26.0, bottom: 20),
      child: Container(
          width: 323,
          height: 40,
          decoration: BoxDecoration(
              color: bone60, borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: SvgPicture.asset(
                  'assets/icons/navigationBarIcon/Search.svg',
                  color: shark,
                  height: 18,
                  width: 18,
                ),
              ),
              Text(
                'Search',
                style: TextStyle(
                    color: shark,
                    fontFamily: 'SFDisplay',
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ],
          )),
    );
  }
}
