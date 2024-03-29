import 'dart:async';
import 'dart:convert';
import 'package:balance/Constants.dart';
import 'package:balance/Requests/NotificationRequests.dart';
import 'package:balance/feModels/AuthModel.dart';
import 'package:balance/feModels/ClassModel.dart';
import 'package:balance/fitsy_icons_set1_icons.dart';
import 'package:balance/screen/createClass/CreateClassStep1SelectType.dart';
import 'package:balance/screen/home/Home.dart';
import 'package:balance/screen/home/components/Search.dart';
import 'package:balance/screen/home/components/SetUpTrainerStripeAccount.dart';
import 'package:balance/screen/login/StartPage.dart';
import 'package:balance/screen/login/components/PersonalInfo.dart';
import 'package:balance/screen/schedule/CreateClassSchedule.dart';
import 'package:balance/screen/profile/components/MyProfile.dart';
import 'package:balance/sharedWidgets/fitsySharedLogic/StripeLogic.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'FirebaseOptions.dart';
import 'feModels/UserModel.dart';
import 'package:go_router/go_router.dart';

void main() async {
  // needed if you intend to initialize in the `main` function
  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey = publishableStripeKey;
  Stripe.merchantIdentifier = 'Fitsy';
  await dotenv.load(fileName: ".env");
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
        useMaterial3: false,
      ),
      //Place comment on what the changes were if changed for testing purposes
      //Example:
      //SignIn(); -> RatingPopup();

      home: StartPage(),
    );
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

    //Add Home
    _widgetOptions.add(Home(
      userInstance: userInstance,
    ));

    //Add Search
    _widgetOptions.add(Search(
      userInstance: userInstance,
    ));

    NotificationRequests.initialize();

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
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print(fcmToken);
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

    print("Showing notification");
    await NotificationRequests.instance.addTestNotification(
        _configureDidReceiveLocalNotificationSubject,
        _configureSelectNotificationSubject);

    // You may set the permission requests to "provisional" which allows the user to choose what type
// of notifications they would like to receive once the user receives a notification.
    // final notificationSettings =
    //     await FirebaseMessaging.instance.requestPermission(provisional: true);

// For apple platforms, ensure the APNS token is available before making any FCM plugin API calls
    final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
    if (apnsToken != null) {
      // APNS token is available, make FCM plugin API requests...
      NotificationRequests.instance.addTestPushNotification(apnsToken);
    }

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

  //TEMP TAKE THIS OUT...///
  Auth authTemplate = Auth(
    userEmail: '',
    userPhone: '',
    password: '',
  );

  User userTemplate = User(
    isActive: true,
    userType: UserType.Trainee,
    profileImageURL: '',
    firstName: '',
    lastName: '',
    userName: '',
  );

  Future<void> _configureSelectNotificationSubject() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PersonalInfo(
                authTemplate: authTemplate,
                userTemplate: userTemplate,
              )),
    );
  }

  Future<void> _configureDidReceiveLocalNotificationSubject() async {
    print("Triggering test notificaiton");
    await showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text("Test Title Text"),
        content: const Text("Test Context Text"),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              await Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => PersonalInfo(
                    authTemplate: authTemplate,
                    userTemplate: userTemplate,
                  ),
                ),
              );
            },
            child: const Text('Ok'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: Container(
          height: 92,
          decoration: const BoxDecoration(
            color: snow,
          ),
          child: Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
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
                      FitsyIconsSet1.home,
                      color: jetBlack80,
                      size: 20,
                    ),
                    activeIcon: Icon(
                      FitsyIconsSet1.home,
                      color: strawberry,
                      size: 20,
                    ),
                    label: ''),

                //Search
                BottomNavigationBarItem(
                    icon: Icon(
                      FitsyIconsSet1.search,
                      color: jetBlack80,
                      size: 20,
                    ),
                    activeIcon: Icon(
                      FitsyIconsSet1.search,
                      color: strawberry,
                      size: 20,
                    ),
                    label: ''),
                if (userInstance.userType == UserType.Trainer)
                  //Add Class
                  BottomNavigationBarItem(
                      icon: GestureDetector(
                        child: Icon(
                          CupertinoIcons.add_circled_solid,
                          color: jetBlack80,
                          size: 24,
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
                                return Wrap(children: [
                                  CreateClassSelectType(
                                    isEditMode: false,
                                    isTypeSelected: false,
                                    classTemplate: classTemplate,
                                  ),
                                ]);
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
                      FitsyIconsSet1.calendar,
                      color: jetBlack80,
                      size: 20,
                    ),
                    activeIcon: Icon(
                      FitsyIconsSet1.calendar,
                      color: strawberry,
                      size: 20,
                    ),
                    label: ''),

                //Profile
                BottomNavigationBarItem(
                    icon: Icon(
                      FitsyIconsSet1.user,
                      color: jetBlack80,
                      size: 20,
                    ),
                    activeIcon: Icon(
                      FitsyIconsSet1.user,
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
