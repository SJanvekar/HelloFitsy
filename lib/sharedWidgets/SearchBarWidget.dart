import 'package:balance/Requests/UserRequests.dart';
import 'package:balance/constants.dart';
import 'package:balance/feModels/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class FitsySearchBar extends StatefulWidget {
  final Function(List<User>)? callback;
  FitsySearchBar({
    Key? key,
    required this.isAutoFocusTrue,
    required this.searchHintText,
    required this.callback,
    required this.controller,
  }) : super(key: key);
  bool isAutoFocusTrue;
  var controller;
  String searchHintText;

  @override
  State<FitsySearchBar> createState() => _FitsySearchBarState();
}

class _FitsySearchBarState extends State<FitsySearchBar> {
  late Timer onStoppedTyping = new Timer(duration, () => search('test'));
  static const duration = Duration(milliseconds: 800);
  List<User> searchResults = [];

  void search(String val) {
    searchResults.clear();
    if (val.isNotEmpty) {
      UserRequests().searchTrainers(val).then((val) async {
        if (val.data['success']) {
          print(val.data['searchResults']);
          List<dynamic> receivedJSON = val.data['searchResults'];
          receivedJSON.forEach((user) {
            searchResults.add(User.fromJson(user));
          });
          _updateSearchData();
        }
      });
    }
  }

  void _updateSearchData() {
    widget.callback!(searchResults);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width - 52;

    return Material(
      color: Colors.transparent,
      child: SizedBox(
        height: 45,
        width: width,
        child: TextField(
          onChanged: (val) {
            setState(() => onStoppedTyping.cancel());
            setState(
                () => onStoppedTyping = new Timer(duration, () => search(val)));
          },
          controller: widget.controller,
          autofocus: widget.isAutoFocusTrue,
          textInputAction: TextInputAction.search,
          style: const TextStyle(
              fontFamily: 'SFDisplay',
              fontSize: 15.5,
              fontWeight: FontWeight.w500,
              color: jetBlack),
          cursorColor: ocean,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 11, bottom: 11),
            fillColor: bone60,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            hintText: widget.searchHintText,
            hintStyle: const TextStyle(
                color: jetBlack40,
                fontSize: 15.5,
                fontFamily: 'SFRounded',
                fontWeight: FontWeight.w400),
            prefixIcon: Container(
              alignment: Alignment.center,
              width: 10,
              height: 18,
              padding: const EdgeInsets.only(
                  left: 20, top: 10, bottom: 10, right: 0),
              child: SvgPicture.asset(
                'assets/icons/generalIcons/search.svg',
                height: 14,
                width: 114,
                color: jetBlack60,
              ),
            ),
            suffixIcon: widget.controller.text.length > 0
                ? GestureDetector(
                    child: Container(
                        width: 50,
                        height: 30,
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          'assets/icons/generalIcons/exit.svg',
                          color: shark,
                          height: 12,
                        )),
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      widget.controller.clear();
                      setState(() {});
                    })
                : null,
          ),
        ),
      ),
    );
  }
}
