import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:balance/constants.dart';
import 'package:balance/feModels/ClassModel.dart';
import 'package:balance/hello_fitsy_icons.dart';
import 'package:balance/screen/createClass/CreateClassStep1SelectType.dart';
import 'package:balance/screen/home/HomeCopy.dart';
import 'package:balance/screen/home/components/Search.dart';
import 'package:balance/screen/login/components/SignIn.dart';
import 'package:balance/screen/login/login.dart';
import 'package:balance/screen/profile/components/CreateClassSchedule.dart';
import 'package:balance/screen/profile/components/MyProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'FirebaseOptions.dart';

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
        //Login(); -> UserProfile();

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

  String userType = "";
  String userName = "";
  String userFirstName = "";
  String userLastName = "";
  String userBio = "";
  String userFullName = "";
  String profileImageUrl = "";
  String userInterests = "";

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
    userName = sharedPrefs.getString('userName') ?? '';
    userFirstName = sharedPrefs.getString('firstName') ?? '';
    userLastName = sharedPrefs.getString('lastName') ?? '';
    userBio = sharedPrefs.getString('userBio') ?? '';
    userType = sharedPrefs.getString('userType') ?? '';
    userFullName = '${userFirstName}' + ' ' + '${userLastName}';
    userInterests = sharedPrefs.getString('categories') ?? '';

    print(userInterests);
    getSet2UserDetails();

    if (userType == 'Trainer') {
      _widgetOptions[2] = CreateClassSelectType(
          isTypeSelected: false, classTemplate: classTemplate);
    }
    _widgetOptions.add(PersonalProfile(
      profileImageUrl: profileImageUrl,
      userFirstName: userFirstName,
      userFullName: userFullName,
      userLastName: userLastName,
      userName: userName,
      userType: userType,
      userBio: userBio,
      userInterests: userInterests,
    ));

    setState(() {});
  }

  void getSet2UserDetails() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    profileImageUrl = sharedPrefs.getString('profileImageURL') ?? '';
  }

  List<Widget> _widgetOptions = <Widget>[
    HomeTest(),
    Search(),
    ScheduleCalendar(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
              if (userType == 'Trainer')
                //Add Class
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.add_box_rounded,
                      color: jetBlack80,
                      size: 20,
                    ),
                    activeIcon: Icon(
                      Icons.add_box_rounded,
                      color: strawberry,
                      size: 20,
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
