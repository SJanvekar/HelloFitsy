import 'dart:ui';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:balance/constants.dart';
import 'package:balance/screen/explore/components/exploreHome.dart';
import 'package:balance/screen/home/components/classCardOpen.dart';
import 'package:balance/screen/home/home.dart';
import 'package:balance/screen/login/login.dart';
import 'package:balance/screen/profile/components/profile.dart';
import 'package:balance/screen/profile/components/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FITSY());
}

class FITSY extends StatelessWidget {
  const FITSY({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitsy',
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      home: Home(),
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
  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    Explore(),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            color: snow,
            border: Border(top: BorderSide(color: shark40, width: 1.0))),
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
                  'assets/icons/navigationBarIcon/Home.svg',
                  height: 22,
                  color: jetBlack,
                ),
                activeIcon: SvgPicture.asset(
                  'assets/icons/navigationBarIcon/Home.svg',
                  height: 22,
                  color: strawberry,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/navigationBarIcon/Search.svg',
                  height: 22,
                  color: jetBlack,
                ),
                activeIcon: SvgPicture.asset(
                  'assets/icons/navigationBarIcon/Search.svg',
                  height: 22,
                  color: strawberry,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/navigationBarIcon/User.svg',
                  height: 22,
                  color: jetBlack,
                ),
                activeIcon: SvgPicture.asset(
                  'assets/icons/navigationBarIcon/User.svg',
                  height: 22,
                  color: strawberry,
                ),
                label: ''),
          ],
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
