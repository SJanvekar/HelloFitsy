import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:balance/constants.dart';
import 'package:balance/payments/paymentSheet.dart';
import 'package:balance/screen/home/home%20copy.dart';
import 'package:balance/screen/login/components/signIn.dart';
import 'package:balance/screen/login/login.dart';
import 'package:balance/screen/profile/components/myProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:page_transition/page_transition.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Stripe.publishableKey = stripePublishableKey;
  await dotenv.load(fileName: "assets/.env");
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

        home: Login()
        //Change the above to Login() to revert to full flow
        // Login()

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
    PersonalProfile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    //   SystemUiOverlay.top,
    // ]);
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
              border: Border(top: BorderSide(color: shark, width: 0.33))),
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
      curve: Curves.fastEaseInToSlowEaseOut,
      duration: 900,
      animationDuration: Duration(milliseconds: 600),
      pageTransitionType: PageTransitionType.fade,
      splashTransition: SplashTransition.fadeTransition,
      splash: Center(
        child: Hero(
          transitionOnUserGestures: true,
          tag: 'typeface',
          child: Container(
              height: 140,
              width: 190,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(
                  "assets/images/Typeface.png",
                ),
              ))),
        ),
      ),
      nextScreen: SignIn(),
      backgroundColor: snow,
    );
  }
}
