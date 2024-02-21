import 'package:balance/Main.dart';
import 'package:balance/constants.dart';
import 'package:balance/screen/login/components/personalInfo.dart';
import 'package:balance/sharedWidgets/loginFooterButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateClassDone extends StatefulWidget {
  const CreateClassDone({Key? key}) : super(key: key);

  @override
  State<CreateClassDone> createState() => _CreateClassDone();
}

class _CreateClassDone extends State<CreateClassDone> {
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
                  Navigator.of(context).pop(CupertinoPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => MainPage()));
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
                              builder: (context) => MainPage()));
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
      body: Column(
        children: [
          pageTitle(),
          Padding(
            padding: const EdgeInsets.only(bottom: 45.0),
            child: GestureDetector(
              child: FooterButton(
                  buttonColor: strawberry, textColor: snow, buttonText: 'Done'),
              onTap: () => {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CreateClassDone()))
              },
            ),
          ),
        ],
      ),
    );
  }
}

//Page title
Widget pageTitle() {
  return Expanded(
    child: Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 46, right: 46, top: 10.0),
        child: Container(
            decoration: BoxDecoration(color: snow),
            child: Text(
              'You\'re all set!',
              style: logInPageTitleH3,
              textAlign: TextAlign.center,
            )),
      ),
    ),
  );
}
