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

class SearchBar extends StatefulWidget {
  SearchBar({Key? key, required this.isAutoFocusTrue}) : super(key: key);
  bool isAutoFocusTrue;
  @override
  State<SearchBar> createState() => _SearchBarState();
}

var _controller = TextEditingController();

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
          padding: EdgeInsets.only(left: 26, right: 26, bottom: 10),
          child: SizedBox(
            width: 323,
            height: 50,
            child: TextField(
              onChanged: (String text) {
                setState(() {});
              },
              controller: _controller,
              autofocus: widget.isAutoFocusTrue,
              style: const TextStyle(
                  fontFamily: 'SFDisplay',
                  fontSize: 15.5,
                  fontWeight: FontWeight.w600,
                  color: jetBlack80),
              cursorColor: ocean,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 11, bottom: 11),
                fillColor: bone60,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Search classes',
                hintStyle: const TextStyle(
                    color: jetBlack40,
                    fontSize: 15.5,
                    fontFamily: 'SFDisplay',
                    fontWeight: FontWeight.w600),
                prefixIcon: Container(
                  width: 1,
                  height: 16,
                  padding: const EdgeInsets.only(
                      left: 22, top: 11, bottom: 11, right: 10),
                  child: SvgPicture.asset(
                      'assets/icons/navigationBarIcon/Search.svg'),
                ),
                suffixIcon: _controller.text.length > 0
                    ? GestureDetector(
                        child: Container(
                            width: 50,
                            height: 30,
                            padding: const EdgeInsets.only(
                                left: 10, top: 11, bottom: 11, right: 22),
                            child: SvgPicture.asset(
                              'assets/icons/removeIcon20.svg',
                              height: 18,
                              width: 18,
                            )),
                        onTap: () {
                          HapticFeedback.mediumImpact();
                          _controller.clear();
                          setState(() {});
                        })
                    : null,
              ),
            ),
          )),
    );
  }
}
