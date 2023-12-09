import 'dart:async';
import 'dart:convert';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:balance/Constants.dart';
import 'package:balance/feModels/ClassModel.dart';
import 'package:balance/hello_fitsy_icons.dart';
import 'package:balance/screen/createClass/CreateClassStep1SelectType.dart';
import 'package:balance/screen/home/Home.dart';
import 'package:balance/screen/home/components/Search.dart';
import 'package:balance/screen/home/components/SetUpTrainerStripeAccount.dart';
import 'package:balance/screen/login/components/SignIn.dart';
import 'package:balance/screen/login/login.dart';
import 'package:balance/screen/schedule/CreateClassSchedule.dart';
import 'package:balance/screen/profile/components/MyProfile.dart';
import 'package:balance/sharedWidgets/fitsySharedLogic/StripeLogic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'FirebaseOptions.dart';
import 'feModels/UserModel.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = publishableStripeKey;
  Stripe.merchantIdentifier = 'Fitsy';

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp.router(
    debugShowCheckedModeBanner: false,
    debugShowMaterialGrid: false,
    routerConfig: router,
  ));
}

/// This handles '/'.
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) => FITSY(),
      routes: [
        GoRoute(
          path: 'Home',
          builder: (_, __) => MainPage(),
        ),
      ],
    ),
  ],
);

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

//Permissions Enum
enum PermissionGroup {
  /// Android: Fine and Coarse Location
  /// iOS: CoreLocation - Always
  locationAlways,

  /// Android: Fine and Coarse Location
  /// iOS: CoreLocation - WhenInUse
  locationWhenInUse
}

void checkPermissions() async {
  // Check if permission is already granted
  PermissionStatus permissionStatus = await Permission.location.request();

  // Handle the permission status accordingly
  if (permissionStatus.isGranted) {
    // Permission already granted
    print('Location permission granted');
  } else if (permissionStatus.isDenied) {
    // Permission denied
    print('Location permission denied');
  } else if (permissionStatus.isPermanentlyDenied) {
    // Permission permanently denied

    print('Location permission permanently denied');
    // Open app settings to allow users to grant permission manually
    openAppSettings();
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  //Class Template Declaration
  Class classTemplate = Class(
    classID: '',
    className: '',
    classDescription: '',
    classType: ClassType.Solo,
    classLocationName: '',
    classLatitude: 0,
    classLongitude: 0,
    classOverallRating: 0,
    classReviewsAmount: 0,
    classPrice: 0,
    classTrainerID: '',
    classTimes: [],
    updatedClassTimes: [],
    cancelledClassTimes: [],
    classCategories: [],
    classUserRequirements: '',
    classWhatToExpect: '',
    classImageUrl: '',
  );

  // User template decleration
  User userInstance = User(
    isActive: true,
    userType: UserType.Trainee,
    profileImageURL: '',
    firstName: '',
    lastName: '',
    userName: '',
  );

  //Animation variables
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    //   SystemUiOverlay.top,
    // ]);

    //Add Home
    _widgetOptions.add(Home(
      userInstance: userInstance,
    ));

    //Add Search
    _widgetOptions.add(Search(
      userInstance: userInstance,
    ));

    //Animation Controller Set Up
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );
    scaleAnimation = CurvedAnimation(
        parent: controller,
        curve: Interval(0.5, 1.0, curve: Curves.elasticOut));

    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
    getUserDetails();
    setState(() {});
  }

  //----------

  //Get User Information
  void getUserDetails() async {
    // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    // _firebaseMessaging.requestPermission();
    // Future<String?> futureRegistrationToken = _firebaseMessaging.getToken();
    // String? registrationToken = await futureRegistrationToken;

    // print(futureRegistrationToken);
    // NotificationRequests()
    //     .addTestNotification(registrationToken ?? '')
    //     .then((val) {
    //   if (val.data['success']) {
    //     print("Test Notification success: ${val.data['msg']}");
    //   } else {
    //     print("Test Notification failed: ${val.data['msg']}");
    //   }
    // });

    // final fcmToken = await FirebaseMessaging.instance.getToken();
    // print(fcmToken);
    final sharedPrefs = await SharedPreferences.getInstance();
    User user =
        User.fromJson(jsonDecode(sharedPrefs.getString('loggedUser') ?? ''));
    userInstance.userID = user.userID;
    userInstance.userName = user.userName;
    userInstance.firstName = user.firstName;
    userInstance.lastName = user.lastName;
    userInstance.userBio = user.userBio ?? '';
    userInstance.stripeAccountID = user.stripeAccountID;
    userInstance.stripeCustomerID = user.stripeCustomerID;
    userInstance.userType = user.userType;
    userInstance.categories = user.categories;
    userInstance.profileImageURL = user.profileImageURL;

    //Call function checkStripeAccountID -- This will check if the Stripe account has been set up yet
    checkStripeAccountID();

    //---------Dynamically fill the widget options on MainPage--------------------//

    // Add Create Class if user is a trainer
    if (userInstance.userType == UserType.Trainer) {
      //Add Create Class
      _widgetOptions.add(CreateClassSelectType(
        isEditMode: false,
        isTypeSelected: false,
        classTemplate: classTemplate,
      ));

      //Add Schedule Calendar
      _widgetOptions.add(ScheduleCalendar(
        userInstance: userInstance,
      ));
    } else {
      //Add Schedule Calendar
      _widgetOptions.add(ScheduleCalendar(
        userInstance: userInstance,
      ));
    }

    //Add Personal Profile to list of navigation widgets
    _widgetOptions.add(PersonalProfile(
      userInstance: userInstance,
      isFromSearch: false,
    ));

    //Request Permissions
    checkPermissions();

    setState(() {});
  }

  //Function - Show Alert Dialog
  void showAlert(BuildContext context) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => Center(
              child: Material(
                color: Colors.transparent,
                child: ScaleTransition(
                  scale: scaleAnimation,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width - 80,
                    decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0))),
                    child: Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: SetUpTrainerStripeAccount(
                        userInstance: userInstance,
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }

  //Check if there is a stripe ID associated with the Trainer account
  void checkStripeAccountID() {
    if (userInstance.userType == UserType.Trainer &&
        userInstance.stripeAccountID == null) {
      Future.delayed(Duration(milliseconds: 0), () => showAlert(context));
    }

    //Else if the account is not empty for the trainer retrieve if details are submitted
    else if (userInstance.userType == UserType.Trainer &&
        userInstance.stripeAccountID != null) {
      StripeLogic().stripeDetailsSubmitted(userInstance);
    }
  }

  //Dynamically filled via
  List<Widget> _widgetOptions = <Widget>[];

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
          child: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
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
                              barrierColor: jetBlack60,
                              builder: (BuildContext context) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pop(); // Close the modal if tapped outside the content
                                  },
                                  child: Wrap(
                                    children: [
                                      CupertinoPopupSurface(
                                        isSurfacePainted: true,
                                        child: CreateClassSelectType(
                                          isTypeSelected: false,
                                          classTemplate: classTemplate,
                                          isEditMode: false,
                                        ),
                                      ),
                                    ],
                                  ),
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
