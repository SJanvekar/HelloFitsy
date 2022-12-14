import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:balance/constants.dart';
import 'package:balance/screen/explore/components/exploreHome.dart';
import 'package:balance/screen/home/home%20copy.dart';
import 'package:balance/screen/home/home.dart';
import 'package:balance/screen/login/login.dart';
import 'package:balance/screen/profile/components/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

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
      home: Login(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomeTest(),
    HomeTest(),
    UserProfile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.top,
    ]);
    // getSet1UserDetails();
    // getSet2UserDetails();
  }

  // void getSet1UserDetails() async {
  //   final sharedPrefs = await SharedPreferences.getInstance();
  //   var userNameNullCheck = sharedPrefs.getString('userName');
  //   var userFirstNameNullCheck = sharedPrefs.getString('firstName');
  //   var userLastNameNullCheck = sharedPrefs.getString('lastName');
  //   if (userNameNullCheck != null) {
  //     userName = sharedPrefs.getString('userName')!;
  //   }
  //   if (userFirstNameNullCheck != null && userLastNameNullCheck != null) {
  //     userFirstName = sharedPrefs.getString('firstName')! +
  //         sharedPrefs.getString('lastName')!;
  //   }
  // }

  // void getSet2UserDetails() async {
  //   final sharedPrefs = await SharedPreferences.getInstance();
  //   var profilePictureNullCheck = sharedPrefs.getString('profileImageURL');
  //   if (profilePictureNullCheck != null) {
  //     profileImageUrl = sharedPrefs.getString('profileImageURL')!;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: Container(
          height: 90,
          decoration: const BoxDecoration(
              color: snow,
              border: Border(top: BorderSide(color: shark40, width: 0.33))),
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: snow,
            // showSelectedLabels: false,
            // showUnselectedLabels: false,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/generalIcons/home.svg',
                    height: 22,
                    color: jetBlack,
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/icons/generalIcons/home.svg',
                    height: 22,
                    color: strawberry,
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/generalIcons/chat.svg',
                    height: 22,
                    color: jetBlack,
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/icons/generalIcons/chat.svg',
                    height: 22,
                    color: strawberry,
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/generalIcons/user.svg',
                    height: 22,
                    color: jetBlack,
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/icons/generalIcons/user.svg',
                    height: 22,
                    color: strawberry,
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
