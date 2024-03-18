import 'dart:io';
import 'package:balance/Constants.dart';
import 'package:balance/feModels/AuthModel.dart';
import 'package:balance/fitsy_icons_set1_icons.dart';
import 'package:balance/screen/login/components/CategorySelection.dart';
import 'package:balance/screen/login/components/TrainerOrTrainee.dart';
import 'package:balance/screen/login/components/personalInfo.dart';
import 'package:balance/sharedWidgets/FooterButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../feModels/UserModel.dart';

class ShareYourLocation extends StatefulWidget {
  ShareYourLocation(
      {Key? key, required this.authTemplate, required this.userTemplate})
      : super(key: key);

  final Auth authTemplate;
  final User userTemplate;

  @override
  State<ShareYourLocation> createState() => _ShareYourLocationState();
}

//Request Location
void getLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
}

class _ShareYourLocationState extends State<ShareYourLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: snow,
      appBar: AppBar(
        toolbarHeight: 50,
        centerTitle: false,
        elevation: 0,
        backgroundColor: snow,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 0),
          child: Row(
            children: [
              GestureDetector(
                child: Row(
                  children: [
                    Icon(
                      FitsyIconsSet1.arrowleft,
                      color: jetBlack60,
                      size: 15,
                    ),
                    const Text(
                      "Back",
                      style: logInPageNavigationButtons,
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).pop(CupertinoPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => TrainerOrTrainee()));
                },
              ),
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 15.0,
            ),
            child: Wrap(children: [
              pageTitle(),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: pageText(),
              ),
            ]),
          ),
          Image.asset(
            'assets/images/MapToronto.jpg',
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 15.0,
              bottom: 10.0,
            ),
            child: GestureDetector(
                child: FooterButton(
                    buttonColor: jetBlack,
                    textColor: snow,
                    buttonText: 'Share my location'),
                onTap: () async {
                  getLocation();
                }),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 45.0, left: 15.0, right: 15.0),
        child: GestureDetector(
          child: Hero(
            tag: 'Bottom',
            child: FooterButton(
                buttonColor: strawberry,
                textColor: snow,
                buttonText: 'Continue'),
          ),
          onTap: () => {
            Navigator.of(context).push(CupertinoPageRoute(
                builder: (context) => PersonalInfo(
                    authTemplate: authTemplate, userTemplate: userTemplate)))
          },
        ),
      ),
    );
  }
}

//Page title
Widget pageTitle() {
  return Container(
      decoration: BoxDecoration(color: snow),
      child: const Text(
        'Share your location',
        style: logInPageTitleH1,
      ));
}

//PageText
Widget pageText() {
  return const Text(
    'Help us, help you. Share your location with us so we can recommend classes near you',
    style: logInPageBodyText,
  );
}
