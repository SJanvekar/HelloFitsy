import 'dart:async';
import 'dart:convert';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:balance/Constants.dart';
import 'package:balance/Requests/NotificationRequests.dart';
import 'package:balance/feModels/ClassModel.dart';
import 'package:balance/feModels/NotificationModel.dart';
import 'package:balance/hello_fitsy_icons.dart';
import 'package:balance/screen/createClass/CreateClassStep1SelectType.dart';
import 'package:balance/screen/home/Home.dart';
import 'package:balance/screen/home/components/Search.dart';
import 'package:balance/screen/home/components/SetUpTrainerStripeAccount.dart';
import 'package:balance/screen/login/components/PersonalInfo.dart';
import 'package:balance/screen/login/components/SignIn.dart';
import 'package:balance/screen/login/login.dart';
import 'package:balance/screen/schedule/CreateClassSchedule.dart';
import 'package:balance/screen/profile/components/MyProfile.dart';
import 'package:balance/sharedWidgets/fitsySharedLogic/StripeLogic.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'FirebaseOptions.dart';
import 'feModels/UserModel.dart';
import 'package:go_router/go_router.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final StreamController<NotificationModel> didReceiveLocalNotificationStream =
    StreamController<NotificationModel>.broadcast();

final StreamController<String?> selectNotificationStream =
    StreamController<String?>.broadcast();

String? selectedNotificationPayload;

/// A notification action which triggers a App navigation event
const String navigationActionId = 'id_1';

/// Defines a iOS/MacOS notification category for text input actions.
const String darwinNotificationCategoryText = 'textCategory';

/// Defines a iOS/MacOS notification category for plain actions.
const String darwinNotificationCategoryPlain = 'plainCategory';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print(
        'notification action tapped with input: ${notificationResponse.input}');
  }
}

void main() async {
  // needed if you intend to initialize in the `main` function
  WidgetsFlutterBinding.ensureInitialized();

  final List<DarwinNotificationCategory> darwinNotificationCategories =
      <DarwinNotificationCategory>[
    DarwinNotificationCategory(
      darwinNotificationCategoryText,
      actions: <DarwinNotificationAction>[
        DarwinNotificationAction.text(
          'text_1',
          'Action 1',
          buttonTitle: 'Send',
          placeholder: 'Placeholder',
        ),
      ],
    ),
    DarwinNotificationCategory(
      darwinNotificationCategoryPlain,
      actions: <DarwinNotificationAction>[
        DarwinNotificationAction.plain('id_1', 'Action 1'),
        DarwinNotificationAction.plain(
          'id_2',
          'Action 2 (destructive)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.destructive,
          },
        ),
        DarwinNotificationAction.plain(
          navigationActionId,
          'Action 3 (foreground)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.foreground,
          },
        ),
        DarwinNotificationAction.plain(
          'id_4',
          'Action 4 (auth required)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.authenticationRequired,
          },
        ),
      ],
      options: <DarwinNotificationCategoryOption>{
        DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
      },
    )
  ];

  /// Note: permissions aren't requested here just to demonstrate that can be
  /// done later
  final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
    onDidReceiveLocalNotification:
        (int id, String? title, String? body, String? payload) async {
      didReceiveLocalNotificationStream.add(
        NotificationModel(
            title: title,
            body: body,
            sentAt: DateTime.now(),
            receivedAt: DateTime.now()),
      );
    },
    notificationCategories: darwinNotificationCategories,
  );

  final InitializationSettings initializationSettings = InitializationSettings(
    iOS: initializationSettingsDarwin,
    // macOS: initializationSettingsDarwin,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse:
        (NotificationResponse notificationResponse) {
      switch (notificationResponse.notificationResponseType) {
        case NotificationResponseType.selectedNotification:
          selectNotificationStream.add(notificationResponse.payload);
          break;
        case NotificationResponseType.selectedNotificationAction:
          if (notificationResponse.actionId == navigationActionId) {
            selectNotificationStream.add(notificationResponse.payload);
          }
          break;
      }
    },
    onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
  );

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

// void onDidReceiveNotificationResponse(
//     NotificationResponse notificationResponse) async {
//   final String? payload = notificationResponse.payload;
//   if (notificationResponse.payload != null) {
//     debugPrint('notification payload: $payload');
//   }
//   await Navigator.push(
//     context,
//     MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),
//   );
// }

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

    //Request notification permissions
    _requestPermissions();
    //Navigate to specified page after bottom nav bar loads
    _configureSelectNotificationSubject();

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

    setState(() {
      print('main set state 2');
    });
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

  Future<void> _requestPermissions() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  void _configureSelectNotificationSubject() {
    selectNotificationStream.stream.listen((String? payload) async {
      await Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (BuildContext context) => PersonalInfo(),
      ));
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
                                    classTemplate: classTemplate,
                                    isEditMode: false,
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
