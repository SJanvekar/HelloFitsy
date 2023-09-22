import 'dart:async';
import 'dart:convert';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:balance/constants.dart';
import 'package:balance/feModels/Categories.dart';
import 'package:balance/feModels/ClassModel.dart';
import 'package:balance/hello_fitsy_icons.dart';
import 'package:balance/screen/createClass/CreateClassStep1SelectType.dart';
import 'package:balance/screen/home/HomeCopy.dart';
import 'package:balance/screen/home/components/Search.dart';
import 'package:balance/screen/login/components/SignIn.dart';
import 'package:balance/screen/login/login.dart';
import 'package:balance/screen/profile/components/CreateClassSchedule.dart';
import 'package:balance/screen/profile/components/MyProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'FirebaseOptions.dart';
import 'feModels/UserModel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const FITSY());
}

class FITSY extends StatelessWidget {
  const FITSY({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        color: snow,
        debugShowCheckedModeBanner: false,
        title: 'Fitsy',
        theme: ThemeData(
          textTheme: Theme.of(context).textTheme.apply(),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        //Place comment on what the changes were if changed for testing purposes
        //Example:
        //SignIn(); -> RatingPopup();

        home: SignIn());
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  User userInstance = User(
    isActive: true,
    userType: UserType.Trainee,
    profileImageURL: '',
    firstName: '',
    lastName: '',
    userName: '',
  );

  @override
  void initState() {
    super.initState();
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    //   SystemUiOverlay.top,
    // ]);
    getUserDetails();
  }

  //----------

  void getUserDetails() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    userInstance.userID = sharedPrefs.getString('userID') ?? '';
    userInstance.userName = sharedPrefs.getString('userName') ?? '';
    userInstance.firstName = sharedPrefs.getString('firstName') ?? '';
    userInstance.lastName = sharedPrefs.getString('lastName') ?? '';
    userInstance.userBio = sharedPrefs.getString('userBio') ?? '';
    userInstance.categories =
        json.decode(sharedPrefs.getString('categories') ?? '').cast<String>();
    String userType = sharedPrefs.getString('userType') ?? '';
    userInstance.profileImageURL =
        sharedPrefs.getString('profileImageURL') ?? '';

    // Trainer/Trainee assigning
    if (userType == 'Trainee') {
      userInstance.userType = UserType.Trainee;
    } else {
      userInstance.userType = UserType.Trainer;
    }

    // Add Create Class if user is a trainer
    if (userInstance.userType == UserType.Trainer) {
      _widgetOptions[2] = CreateClassSelectType(
          isTypeSelected: false, classTemplate: classTemplate);
      _widgetOptions.add(ScheduleCalendar());
    }

    //Add Personal Profile to list of navigation widgets
    _widgetOptions.add(PersonalProfile(
      userInstance: userInstance,
    ));

    setState(() {});
  }

  List<Widget> _widgetOptions = <Widget>[
    HomeTest(),
    Search(),
    ScheduleCalendar(),
  ];

  void _onItemTapped(int index) {
    if (index == 2 && userInstance.userType == UserType.Trainer) {
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: Container(
          height: 88,
          decoration: const BoxDecoration(
            color: snow,
          ),
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: snow,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: <BottomNavigationBarItem>[
              //Home
              BottomNavigationBarItem(
                  icon: Icon(
                    HelloFitsy.home,
                    color: jetBlack80,
                    size: 20,
                  ),
                  activeIcon: Icon(
                    HelloFitsy.home,
                    color: strawberry,
                    size: 20,
                  ),
                  label: ''),

              //Search
              BottomNavigationBarItem(
                  icon: Icon(
                    HelloFitsy.search,
                    color: jetBlack80,
                    size: 20,
                  ),
                  activeIcon: Icon(
                    HelloFitsy.search,
                    color: strawberry,
                    size: 20,
                  ),
                  label: ''),
              if (userInstance.userType == UserType.Trainer)
                //Add Class
                BottomNavigationBarItem(
                    icon: GestureDetector(
                      child: Icon(
                        Icons.add_box_rounded,
                        color: jetBlack80,
                        size: 23,
                      ),

                      //OnTap Open a bottom modal sheet for trianers to add classes
                      onTap: () {
                        HapticFeedback.selectionClick();
                        Timer(Duration(milliseconds: 100), () {
                          showCupertinoModalPopup(
                            context: context,
                            useRootNavigator: true,
                            semanticsDismissible: true,
                            barrierDismissible: true,
                            barrierColor: jetBlack60,
                            builder: (context) {
                              return Container(
                                color: Colors.transparent,
                                height:
                                    MediaQuery.of(context).size.height * 0.75,
                                child: CreateClassSelectType(
                                    isTypeSelected: false,
                                    classTemplate: classTemplate),
                              );
                            },
                          );
                        });
                      },
                    ),
                    activeIcon: Icon(
                      Icons.add_box_rounded,
                      color: strawberry,
                      size: 23,
                    ),
                    label: ''),

              //Schedule
              BottomNavigationBarItem(
                  icon: Icon(
                    HelloFitsy.calendar,
                    color: jetBlack80,
                    size: 20,
                  ),
                  activeIcon: Icon(
                    HelloFitsy.calendar,
                    color: strawberry,
                    size: 20,
                  ),
                  label: ''),

              //Profile
              BottomNavigationBarItem(
                  icon: Icon(
                    HelloFitsy.user,
                    color: jetBlack80,
                    size: 20,
                  ),
                  activeIcon: Icon(
                    HelloFitsy.user,
                    color: strawberry,
                    size: 20,
                  ),
                  label: ''),
            ],
          ),
        ),
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Hero(
              transitionOnUserGestures: true,
              tag: 'typeface',
              child: Image.asset(
                'assets/images/Typeface.png',
                height: 146,
                width: 195,
                color: snow,
              )),
        ],
      ),
      nextScreen: Login(),
      backgroundColor: strawberry,
    );
  }
}
