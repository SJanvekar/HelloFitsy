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
                        child: Text("Back", style: logInPageNavigationButtons),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: CustomScrollView(slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          backgroundColor: snow,
          toolbarHeight: 200,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              pageTitle(),
              pageText(),
              AnimSearchBar(
                width: 323,
                textController:
                    TextEditingController(text: 'Search Categories'),
                onSuffixTap: () {
                  setState(() {
                    TextEditingController(text: 'Search Categories').clear();
                  });
                },
              ),
            ],
          ),
          actions: [],
        ),
        SliverList(
          delegate: SliverChildListDelegate([pageText()]),
        ),
      ]),
      bottomNavigationBar: Container(
          color: snow,
          height: 160,
          child: Column(
            children: [
              AnimSearchBar(
                width: 323,
                textController:
                    TextEditingController(text: 'Search Categories'),
                onSuffixTap: () {
                  setState(() {
                    TextEditingController(text: 'Search Categories').clear();
                  });
                },
              )
            ],
          )),
    );
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
    padding: EdgeInsets.only(top: 23.0),
    child: Container(
      width: 323,
      height: 50,
      decoration: BoxDecoration(
        color: bone60,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // SvgPicture.asset(
          //   'assets/icons/UserIcon.svg',
          //   height: 22.5,
          //   width: 18.0,
          //   color: shark,
          // ),
          Center(
            child: IntrinsicWidth(
              child: TextField(
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,
                autocorrect: true,
                style: const TextStyle(
                    overflow: TextOverflow.fade,
                    fontFamily: 'SFDisplay',
                    color: jetBlack80,
                    fontSize: 17,
                    fontWeight: FontWeight.w700),
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: SvgPicture.asset(
                      'assets/icons/searchIcon.svg',
                      height: 22.5,
                      width: 18.0,
                      color: shark60,
                    ),
                  ),
                  border: InputBorder.none,
                  hintText: 'Search Interests',
                  hintStyle: const TextStyle(
                    fontFamily: 'SFDisplay',
                    color: shark60,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onChanged: (val) {
                  userName = val;
                },
              ),
            ),
          ),
        ],
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
