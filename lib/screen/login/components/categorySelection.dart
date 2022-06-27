import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:balance/constants.dart';
import 'package:balance/example.dart';
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

class CategorySelection extends StatefulWidget {
  const CategorySelection({Key? key}) : super(key: key);

  @override
  State<CategorySelection> createState() => _CategorySelectionState();
}

class _CategorySelectionState extends State<CategorySelection> {
  //variables

  void _ButtonOnPressed() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: snow,
        appBar: AppBar(
          toolbarHeight: 80,
          centerTitle: false,
          elevation: 0,
          backgroundColor: snow,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 0,
                ),
                child: TextButton(
                  onPressed: () {
                    print("Back to Personal Info");
                    Navigator.of(context).pop(CupertinoPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => PersonalInfo()));
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 0,
                        ),
                        child: TextButton(
                          onPressed: () {
                            print("Back");
                            Navigator.of(context).pop(CupertinoPageRoute(
                                fullscreenDialog: true,
                                builder: (context) => PersonalInfo()));
                          },
                          child:
                              Text("Back", style: logInPageNavigationButtons),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate([
              searchBar(),
            ]))
          ],
        ));
  }
}

//Page title
Widget pageTitle() {
  return Center(
    child: Container(
        padding: EdgeInsets.only(top: 25),
        decoration: BoxDecoration(color: snow),
        child: Text(
          'What are you interested in?',
          style: logInPageTitle,
        )),
  );
}

//PageText
Widget pageText() {
  return Padding(
    padding: const EdgeInsets.only(top: 5),
    child: RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: logInPageBodyText,
        children: const [
          TextSpan(
              text: 'Personalize your explore feed with the sports you love',
              style: TextStyle(
                fontFamily: 'SFDisplay',
                color: shark,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ))
        ],
      ),
    ),
  );
}

//Username
Widget searchBar() {
  return Padding(
    padding: EdgeInsets.only(left: 26, right: 26),
    child: SizedBox(
      width: 323,
      height: 50,
      child: TextField(
        style: const TextStyle(
            fontFamily: 'SFDisplay',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: jetBlack80),
        cursorColor: ocean,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 11, bottom: 11),
            fillColor: bone60,
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none),
            hintText: 'Search Interests',
            hintStyle: const TextStyle(color: jetBlack20, fontSize: 18),
            prefixIcon: Container(
              width: 18,
              height: 18,
              padding: const EdgeInsets.only(
                  left: 20, top: 11, bottom: 11, right: 5),
              child: SvgPicture.asset('assets/icons/SearchIcon20.svg'),
            )),
      ),
    ),
  );
}

Widget searchBarTest() {
  return Container(
    width: 323,
    height: 50,
    decoration: BoxDecoration(
      color: bone60,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text('Fuck your alignment')],
    )),
  );
}
