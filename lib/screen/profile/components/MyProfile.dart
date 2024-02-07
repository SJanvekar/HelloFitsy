// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:balance/Constants.dart';
import 'package:balance/Requests/ClassRequests.dart';
import 'package:balance/Requests/UserRequests.dart';
import 'package:balance/feModels/Categories.dart';
import 'package:balance/screen/home/components/ProfileClassCard.dart';
import 'package:balance/screen/login/components/SignIn.dart';
import 'package:balance/sharedWidgets/LoginFooterButton.dart';
import 'package:balance/sharedWidgets/SpinnerPage.dart';
import 'package:balance/sharedWidgets/bodyButton.dart';
import 'package:balance/sharedWidgets/categories/categorySmall.dart';
import 'package:balance/sharedWidgets/classes/classItemCondensed1.dart';
import 'package:balance/sharedWidgets/noticeDisclaimer.dart';
import 'package:balance/sharedWidgets/pageDivider.dart';
import 'package:balance/sharedWidgets/reviewCardPersonalProfile.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliver_tools/sliver_tools.dart';
import '../../../feModels/ClassModel.dart';
import '../../../feModels/UserModel.dart';
import '../../../sharedWidgets/fitsySharedLogic/StripeLogic.dart';

class PersonalProfile extends StatefulWidget {
  PersonalProfile({
    Key? key,
    required this.userInstance,
    required this.isFromSearch,
  }) : super(key: key);

  User userInstance;
  bool isFromSearch;

  @override
  State<PersonalProfile> createState() => _PersonalProfileState();
}

//Class list
List<Class> trainerClasses = [];
//List for trainerID (UserID)
List<String> trainerIDList = [];
List<Category> interests = categoriesList;
List<Category> myInterestsFinal = Interests;
List<Class> savedClassesList = classList;
List decodedCategories = [];

//HARD CODED - MUST CHANGE

class _PersonalProfileState extends State<PersonalProfile>
    with SingleTickerProviderStateMixin {
  Color titleColor = Colors.transparent;
  Color _textColor = Colors.transparent;
  Color iconCircleColor = snow;
  Color iconColor = jetBlack;
  late ScrollController _scrollController;
  Brightness statusBarTheme = Brightness.dark;
  bool isFollowing = false;
  bool isClickable = true;
  late AnimationController controller;
  late Animation<Offset> offset;
  String trainerImageURL = '';
  String trainerUsername = '';
  String trainerFirstName = '';
  String trainerLastName = '';

  void getClassTrainerInfo() async {
    UserRequests()
        //HARD CODED - MUST CHANGE sharedPrefs to actual classTrainerID
        .getClassTrainerInfo(widget.userInstance.userID)
        .then((val) async {
      if (val.data['success']) {
        trainerImageURL = val.data['ProfileImageURL'] ?? '';
        trainerUsername = val.data['Username'] ?? '';
        trainerFirstName = val.data['FirstName'] ?? '';
        trainerLastName = val.data['LastName'] ?? '';
      } else {
        //Remove print statement in production
        print('error getting class liked: ${val.data['result']}');
      }
      setState(() {});
    });
  }

  //Class Functions
  void getClasses(List<String> trainerID) async {
    ClassRequests().getClass(trainerID).then((val) async {
      //get logged in user's following list
      if (val.data['success']) {
        print('successful get class feed');
        (val.data['classArray'] as List<dynamic>).forEach((element) {
          trainerClasses.add(Class.fromJson(element));
        });
      } else {
        print('error get class feed: ${val.data['msg']}');
      }
      setState(() {});
    });
  }

//----------
  @override
  void initState() {
    super.initState();
    getSet2UserDetails();
    checkInterests();
    trainerClasses.clear();
    trainerIDList.clear();
    trainerIDList.add(widget.userInstance.userID);
    // Gets the classes for trainer
    getClasses(trainerIDList);
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          _textColor = _isSliverAppBarExpanded ? jetBlack : Colors.transparent;
          iconCircleColor = _isSliverAppBarExpanded ? snow : snow;
          iconColor = _isSliverAppBarExpanded ? snow : jetBlack;
          isClickable = _isSliverAppBarExpanded ? false : true;
          statusBarTheme =
              _isSliverAppBarExpanded ? Brightness.light : Brightness.dark;
        });
      });
    //Animation controllers
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    offset = Tween<Offset>(begin: Offset(0.0, 10.0), end: Offset.zero).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.fastEaseInToSlowEaseOut,
      ),
    );

    Future.delayed(Duration(milliseconds: 1000), () {
      setState(() {
        controller.forward();
      });
    });
  }

  @override
  void didUpdateWidget(PersonalProfile oldWidget) {
    super.didUpdateWidget(oldWidget);
    // This method is called whenever the widget is updated with a new instance.

    // You can use this method to perform actions when the widget is updated.
    print("Widget updated");
    getSet2UserDetails();
  }

  @override
  void dispose() {
    // Dispose of the Ticker and the AnimationController
    controller.dispose();
    super.dispose();
  }

  void getSet2UserDetails() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final user =
        User.fromJson(jsonDecode(sharedPrefs.getString('loggedUser') ?? ''));
    widget.userInstance.userName = user.userName;
    widget.userInstance.firstName = user.firstName;
    widget.userInstance.lastName = user.lastName;
    widget.userInstance.userBio = user.userBio ?? '';
    widget.userInstance.profileImageURL = user.profileImageURL;
    print(widget.userInstance.profileImageURL);

    setState(() {
      print('Got user details');
    });
  }

//----------
  void checkInterests() {
    myInterestsFinal.clear();

    for (var i = 0; i < interests.length; i++) {
      if (widget.userInstance.categories.contains(interests[i].categoryName)) {
        myInterestsFinal.add(interests[i]);
      }
    }
  }

//---------- logout function
  void logout(context) {
    Navigator.of(context).push(PageTransition(
      duration: Duration(milliseconds: 100),
      fullscreenDialog: true,
      child: SpinnerPage(),
      type: PageTransitionType.bottomToTop,
    ));
    Future.delayed(Duration(milliseconds: 1000), () async {
      //Load Shared Prefs
      final sharedPrefs = await SharedPreferences.getInstance();

      //Clear Shared Prefs
      sharedPrefs.clear();

      //Navigate to the sign in page
      await Navigator.of(context).push(PageTransition(
          fullscreenDialog: true,
          child: SignIn(),
          type: PageTransitionType.fade,
          duration: Duration.zero));
    });
  }

//---------- Log out warning dialog
  contentBox(context) {
    return Container(
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: jetBlack20, offset: Offset(0, 5), blurRadius: 10),
          ]),
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 5.0),
              child: Text(
                'Are you sure you want to log out?',
                style: bodyTextFontBold80,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                      child: BodyButton(
                          buttonColor: shark60,
                          textColor: jetBlack,
                          buttonText: 'Cancel'),
                      onTap: () => {
                            HapticFeedback.selectionClick(),
                            Navigator.of(context).pop(),
                          }),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: GestureDetector(
                      child: BodyButton(
                          buttonColor: strawberry,
                          textColor: snow,
                          buttonText: 'Log out'),
                      //Log out function
                      onTap: () => {
                            logout(context),
                          }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

//----------
  bool get _isSliverAppBarExpanded {
    return _scrollController.hasClients &&
        _scrollController.offset >
            (MediaQuery.of(context).size.height * 0.381 - kToolbarHeight);
  }

  //Class Type and Title
  Widget userTitleCard() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.userInstance.firstName +
                    ' ' +
                    widget.userInstance.lastName,
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'SFDisplay',
                    fontWeight: FontWeight.w600,
                    color: snow,
                    // ignore: prefer_const_literals_to_create_immutables
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(0, 0),
                        blurRadius: 8.0,
                        color: jetBlack80,
                      ),
                    ]),
                maxLines: 1,
              ),
            ],
          ),
          Text(
            '@' + widget.userInstance.userName,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: snow,
                fontFamily: 'SFDisplay',
                // ignore: prefer_const_literals_to_create_immutables
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(0, 0),
                    blurRadius: 8.0,
                    color: jetBlack80,
                  ),
                ]),
            maxLines: 1,
          ),
          if (widget.userInstance.userType == UserType.Trainer)
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Row(
                children: [
                  // Followers TextSpan denoting the number of followers a user has
                  RichText(
                      text: TextSpan(children: <TextSpan>[
                    TextSpan(
                      text:
                          // Following Count,
                          //HARD CODED - MUST CHANGE
                          '200',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: snow,
                          fontFamily: 'SFDisplay',
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(0, 0),
                              blurRadius: 8.0,
                              color: jetBlack80,
                            ),
                          ]),
                    ),
                    TextSpan(
                      text:
                          // Following Count,
                          ' Followers',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: snow,
                          fontFamily: 'SFDisplay',
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(0, 0),
                              blurRadius: 8.0,
                              color: jetBlack80,
                            ),
                          ]),
                    ),
                  ])),
                ],
              ),
            ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    var top = 0.0;
    var max = 0.0;
    var mobilePadding = MediaQuery.of(context).padding;
    var mobilePaddingPlusToolBar = mobilePadding.top + 55;

    //Hides the top status bar for iOS & Android
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    //Shows the top status bar for iOS & Android
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);

    return Scaffold(
      backgroundColor: snow,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 0,
        elevation: 0,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarBrightness: statusBarTheme),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          CustomScrollView(
              shrinkWrap: false,
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  leadingWidth: 58,
                  automaticallyImplyLeading: false,
                  backgroundColor: snow,
                  elevation: 0,
                  toolbarHeight: 55,
                  stretch: true,
                  floating: false,
                  pinned: true,
                  expandedHeight: MediaQuery.of(context).size.height * 0.38,
                  flexibleSpace: FlexibleSpaceBar(
                    stretchModes: const [StretchMode.zoomBackground],
                    background: Stack(
                      children: [
                        if (widget.userInstance.profileImageURL != null)
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                    widget.userInstance.profileImageURL ?? '',
                                  ),
                                  fit: BoxFit.cover),
                            ),
                          )
                        else
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/profilePictureDefault.png'),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                snow.withOpacity(0.0),
                                jetBlack.withOpacity(0.15),
                                jetBlack.withOpacity(0.35),
                              ],
                                  // ignore: prefer_const_literals_to_create_immutables
                                  stops: [
                                0.0,
                                0.6,
                                1.0
                              ])),
                        ),
                      ],
                    ),
                    titlePadding: EdgeInsets.zero,
                    title: Padding(
                      padding: const EdgeInsets.only(
                        left: 15.0,
                        right: 15.0,
                      ),
                      child: LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          max = 382.76 - mobilePaddingPlusToolBar;
                          top = constraints.biggest.height -
                              mobilePaddingPlusToolBar;

                          if (top > max) {
                            max = top;
                          }
                          if (top == mobilePaddingPlusToolBar) {
                            top = 0.0;
                          }

                          top = top / max;

                          return Opacity(
                            opacity: top,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  userTitleCard(),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    expandedTitleScale: 1,
                    centerTitle: false,
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 26.0, top: 11.5, bottom: 11.5),
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 2,
                            sigmaY: 2,
                          ),
                          child: GestureDetector(
                              child: Container(
                                height: 30,
                                width: 80,
                                decoration: BoxDecoration(
                                    color: iconCircleColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                    child: Text(
                                  'Settings',
                                  style: TextStyle(
                                    color: iconColor,
                                    fontFamily: 'SFDisplay',
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                              ),
                              //Open edit profile modal sheet
                              onTap: () {
                                if (isClickable) {
                                  //Set the status bar theme to light (Black Header);
                                  setState(() {
                                    statusBarTheme = Brightness.light;
                                  });

                                  //FirstName
                                  final TextEditingController
                                      _firstNameController =
                                      new TextEditingController();
                                  _firstNameController.text =
                                      widget.userInstance.firstName;

                                  final TextEditingController
                                      _lastNameController =
                                      new TextEditingController();
                                  _lastNameController.text =
                                      widget.userInstance.lastName;

                                  final TextEditingController
                                      _userNameController =
                                      new TextEditingController();
                                  _userNameController.text =
                                      widget.userInstance.userName;

                                  final TextEditingController _bioController =
                                      new TextEditingController();
                                  _bioController.text =
                                      widget.userInstance.userBio!;

                                  //Cupertino Modal Pop-up - Profile Edit
                                  showCupertinoModalPopup(
                                      semanticsDismissible: true,
                                      barrierColor: jetBlack60,
                                      context: context,
                                      builder: (BuildContext builder) {
                                        File? newProfileImage;
                                        String? newProfileImageURL;
                                        String? newFirstName;
                                        String? newLastName;
                                        String? newUserName;
                                        String? newBio;

                                        return StatefulBuilder(
                                          builder: (
                                            BuildContext context,
                                            StateSetter setEditProfileState,
                                          ) {
                                            //Modal widgets + functions

                                            //Pick Image Function
                                            Future pickImage(
                                                ImageSource source) async {
                                              try {
                                                var image = await ImagePicker()
                                                    .pickImage(
                                                        source: ImageSource
                                                            .gallery);
                                                if (image == null) {
                                                  image = XFile(
                                                      'assets/images/profilePictureDefault.png');
                                                  return;
                                                }

                                                setEditProfileState(() {
                                                  if (image != null) {
                                                    newProfileImage =
                                                        File(image.path);
                                                  }
                                                });
                                              } on PlatformException catch (e) {
                                                print(
                                                    'Failed to pick image $e');
                                              }
                                            }

                                            Future uploadImage() async {
                                              if (newProfileImage == null)
                                                return;

                                              try {
                                                //Storage Reference
                                                final firebaseStorage =
                                                    FirebaseStorage.instance
                                                        .ref();

                                                //Create a reference to image
                                                // print(profilePictureImage!.path);
                                                final profilePictureRef =
                                                    firebaseStorage.child(
                                                        newProfileImage!.path);

                                                //Upload file. FILE MUST EXIST
                                                await profilePictureRef
                                                    .putFile(newProfileImage!);

                                                final imageURL =
                                                    await profilePictureRef
                                                        .getDownloadURL();

                                                newProfileImageURL = imageURL;
                                                // print(newProfileImageURL);
                                                print('Uploaded Image');
                                              } catch (e) {
                                                print("Error: $e");
                                              }
                                            }

                                            Future<void> _safeSetString(
                                                SharedPreferences prefs,
                                                String key,
                                                String value) async {
                                              try {
                                                await prefs.setString(
                                                    key, value);
                                              } catch (e) {
                                                print(
                                                    'Error setting SharedPreferences: $e');
                                                // Handle any exception that might occur during SharedPreferences set operation
                                                // For instance, consider fallback mechanisms or alternative approaches
                                              }
                                            }

                                            //Textfield widgets
                                            //Edit First Name
                                            Widget editFirstName() {
                                              return Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'First Name',
                                                    style: logInPageBodyText,
                                                  ),
                                                  TextField(
                                                    controller:
                                                        _firstNameController,
                                                    maxLengthEnforcement:
                                                        MaxLengthEnforcement
                                                            .none,
                                                    autocorrect: true,
                                                    cursorColor: ocean,
                                                    maxLines: null,
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    textInputAction:
                                                        TextInputAction.done,
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontFamily: 'SFDisplay',
                                                        color: jetBlack,
                                                        fontSize: 16.5,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                    ),
                                                    onChanged: (val) {
                                                      newFirstName = val;
                                                    },
                                                  ),
                                                  PageDivider(
                                                      leftPadding: 0,
                                                      rightPadding: 0)
                                                ],
                                              );
                                            }

                                            //Edit Last Name
                                            Widget editLastName() {
                                              return Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Last Name',
                                                    style: logInPageBodyText,
                                                  ),
                                                  TextField(
                                                    controller:
                                                        _lastNameController,
                                                    maxLengthEnforcement:
                                                        MaxLengthEnforcement
                                                            .none,
                                                    autocorrect: true,
                                                    cursorColor: ocean,
                                                    maxLines: null,
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    textInputAction:
                                                        TextInputAction.done,
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontFamily: 'SFDisplay',
                                                        color: jetBlack,
                                                        fontSize: 16.5,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                    ),
                                                    onChanged: (val) {
                                                      newLastName = val;
                                                    },
                                                  ),
                                                  PageDivider(
                                                      leftPadding: 0,
                                                      rightPadding: 0)
                                                ],
                                              );
                                            }

                                            //Edit UserName
                                            Widget editUserName() {
                                              return Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Username',
                                                    style: logInPageBodyText,
                                                  ),
                                                  TextField(
                                                    controller:
                                                        _userNameController,
                                                    maxLengthEnforcement:
                                                        MaxLengthEnforcement
                                                            .none,
                                                    autocorrect: true,
                                                    cursorColor: ocean,
                                                    maxLines: null,
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    textInputAction:
                                                        TextInputAction.done,
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontFamily: 'SFDisplay',
                                                        color: jetBlack,
                                                        fontSize: 16.5,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                    ),
                                                    onChanged: (val) {
                                                      newUserName = val;
                                                    },
                                                  ),
                                                  PageDivider(
                                                      leftPadding: 0,
                                                      rightPadding: 0)
                                                ],
                                              );
                                            }

                                            //Edit Bio
                                            Widget editBio() {
                                              return Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Bio',
                                                    style: logInPageBodyText,
                                                  ),
                                                  TextField(
                                                    controller: _bioController,
                                                    maxLengthEnforcement:
                                                        MaxLengthEnforcement
                                                            .none,
                                                    autocorrect: true,
                                                    cursorColor: ocean,
                                                    maxLines: null,
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    textInputAction:
                                                        TextInputAction.newline,
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontFamily: 'SFDisplay',
                                                        color: jetBlack,
                                                        fontSize: 16.5,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                    ),
                                                    onChanged: (val) {
                                                      newBio = val;
                                                    },
                                                  ),
                                                  PageDivider(
                                                      leftPadding: 0,
                                                      rightPadding: 0)
                                                ],
                                              );
                                            }

                                            return GestureDetector(
                                              child: Scaffold(
                                                backgroundColor: snow,
                                                appBar: AppBar(
                                                  toolbarHeight: 80,
                                                  centerTitle: false,
                                                  elevation: 0,
                                                  backgroundColor: snow,
                                                  automaticallyImplyLeading:
                                                      false,
                                                  title: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      TextButton(
                                                        style:
                                                            textButtonStyleNoSplash,
                                                        onPressed: () {
                                                          statusBarTheme =
                                                              Brightness.dark;
                                                          Navigator.of(context)
                                                              .pop();
                                                          setState(() {});
                                                        },
                                                        child: Text("Cancel",
                                                            style:
                                                                logInPageNavigationButtons),
                                                      ),
                                                      Text(
                                                        'Edit Profile',
                                                        style: sectionTitles,
                                                      ),
                                                      TextButton(
                                                        style:
                                                            textButtonStyleNoSplash,
                                                        onPressed: () {
                                                          //TODO: Wrap next async in then statement, see if that fixes async concurrency issue
                                                          statusBarTheme =
                                                              Brightness.dark;
                                                          Future.delayed(
                                                              const Duration(
                                                                  milliseconds:
                                                                      500), () {
                                                            uploadImage()
                                                                .then((value) {
                                                              // This block will be executed when the Future is completed successfully
                                                              UserRequests()
                                                                  .updateUserInformation(
                                                                newProfileImageURL ??
                                                                    widget
                                                                        .userInstance
                                                                        .profileImageURL,
                                                                widget
                                                                    .userInstance
                                                                    .userID,
                                                                newFirstName ??
                                                                    widget
                                                                        .userInstance
                                                                        .firstName,
                                                                newLastName ??
                                                                    widget
                                                                        .userInstance
                                                                        .lastName,
                                                                newUserName ??
                                                                    widget
                                                                        .userInstance
                                                                        .userName,
                                                                newBio ??
                                                                    widget
                                                                        .userInstance
                                                                        .userBio,
                                                              )
                                                                  .then(
                                                                      (val) async {
                                                                try {
                                                                  if (val.data[
                                                                      'success']) {
                                                                    final sharedPrefs =
                                                                        await SharedPreferences
                                                                            .getInstance();
                                                                    User user = User.fromJson(jsonDecode(
                                                                        sharedPrefs.getString('loggedUser') ??
                                                                            ''));
                                                                    user.userName = newUserName ??
                                                                        widget
                                                                            .userInstance
                                                                            .userName;
                                                                    user.firstName = newFirstName ??
                                                                        widget
                                                                            .userInstance
                                                                            .firstName;
                                                                    user.lastName = newLastName ??
                                                                        widget
                                                                            .userInstance
                                                                            .lastName;
                                                                    user.userBio = newBio ??
                                                                        widget
                                                                            .userInstance
                                                                            .userBio;
                                                                    user.profileImageURL = newProfileImageURL ??
                                                                        widget
                                                                            .userInstance
                                                                            .profileImageURL;
                                                                    await _safeSetString(
                                                                        sharedPrefs,
                                                                        'loggedUser',
                                                                        jsonEncode(
                                                                            user.toJson()));
                                                                    getSet2UserDetails();
                                                                    await Future.delayed(
                                                                        Duration(
                                                                            milliseconds:
                                                                                550),
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                      setState(
                                                                          () {
                                                                        print(
                                                                            'State set');
                                                                      });
                                                                    });
                                                                  } else {
                                                                    if (val.data[
                                                                            'errorCode'] ==
                                                                        duplicateKeycode) {
                                                                      print(
                                                                          'Unable to edit info, duplicate username');
                                                                    }
                                                                  }
                                                                  print(
                                                                      'After fetchData completed');
                                                                } catch (e) {
                                                                  print(
                                                                      'Error in updateUserInformation: $e');
                                                                  // Handle any exception that might occur during the updateUserInformation process
                                                                }
                                                              }).catchError(
                                                                      (error) {
                                                                print(
                                                                    'Error in updateUserInformation: $error');
                                                                // Handle errors during updateUserInformation process
                                                              });
                                                            }).catchError(
                                                                    (error) {
                                                              print(
                                                                  'Error in uploadImage: $error');
                                                              // Handle errors during uploadImage process
                                                            });
                                                          });
                                                        },

                                                        // Function to safely set string in SharedPreferences with error handling
                                                        child: Text("Done",
                                                            style:
                                                                doneTextButton),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                body: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 15.0,
                                                    right: 15.0,
                                                  ),
                                                  child: Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                            .copyWith()
                                                            .size
                                                            .height,
                                                    decoration: BoxDecoration(
                                                      color: snow,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: CustomScrollView(
                                                      slivers: [
                                                        MultiSliver(children: [
                                                          Center(
                                                              child: Stack(
                                                            children: [
                                                              if (newProfileImage !=
                                                                  null)
                                                                ClipOval(
                                                                    child: Image
                                                                        .file(
                                                                  newProfileImage!,
                                                                  width: 150,
                                                                  height: 150,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ))
                                                              else if (widget
                                                                          .userInstance
                                                                          .profileImageURL !=
                                                                      null &&
                                                                  newProfileImage ==
                                                                      null)
                                                                ClipOval(
                                                                    child:
                                                                        Image(
                                                                  image: NetworkImage(widget
                                                                      .userInstance
                                                                      .profileImageURL!),
                                                                  width: 180,
                                                                  height: 180,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ))
                                                              else
                                                                ClipOval(
                                                                    child: Image
                                                                        .asset(
                                                                  'assets/images/profilePictureDefault.png',
                                                                  width: 180,
                                                                  height: 180,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ))
                                                            ],
                                                          )),
                                                          Padding(
                                                            padding: EdgeInsets.only(
                                                                top: 15.0,
                                                                left: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.2,
                                                                right: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.2),
                                                            child:
                                                                GestureDetector(
                                                              child: BodyButton(
                                                                buttonColor:
                                                                    strawberry,
                                                                textColor: snow,
                                                                buttonText:
                                                                    'Upload new picture',
                                                              ),
                                                              onTap: () {
                                                                pickImage(
                                                                    ImageSource
                                                                        .gallery);
                                                              },
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 40.0),
                                                            child:
                                                                editFirstName(),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 25.0),
                                                            child:
                                                                editLastName(),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 25.0),
                                                            child:
                                                                editUserName(),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 25.0,
                                                                    bottom:
                                                                        25.0),
                                                            child: editBio(),
                                                          ),
                                                          GestureDetector(
                                                              child: FooterButton(
                                                                  buttonColor:
                                                                      snow,
                                                                  textColor:
                                                                      strawberry,
                                                                  buttonText:
                                                                      'Log out'),
                                                              onTap: () {
                                                                HapticFeedback
                                                                    .selectionClick();

                                                                //Show log out dialog
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return Dialog(
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(15),
                                                                        ),
                                                                        elevation:
                                                                            0,
                                                                        backgroundColor:
                                                                            Colors.transparent,
                                                                        child: contentBox(
                                                                            context),
                                                                      );
                                                                    });
                                                              }),
                                                          SizedBox(height: 80)
                                                        ])
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              onTap: () {
                                                FocusScopeNode currentFocus =
                                                    FocusScope.of(context);

                                                if (!currentFocus
                                                    .hasPrimaryFocus) {
                                                  currentFocus.unfocus();
                                                }
                                              },
                                            );
                                          },
                                        );
                                      });
                                }
                                ;
                              }),
                        ),
                      ),
                    ),
                  ],
                  title: Text(
                      widget.userInstance.firstName +
                          ' ' +
                          widget.userInstance.lastName,
                      style: TextStyle(
                          color: _textColor,
                          fontFamily: 'SFDisplay',
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0)),
                ),

                MultiSliver(children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 15.0,
                      left: 15.0,
                      right: 15.0,
                    ),
                    child: Text(
                      'About me',
                      style: sectionTitles,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                      right: 15.0,
                    ),
                    child: Text(
                      'Toronto, Ontario, Canada',
                      style: TextStyle(
                          color: jetBlack,
                          fontFamily: 'SFDisplay',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, left: 15.0, right: 20.0),
                    child: Text(widget.userInstance.userBio!,
                        style: profileBodyTextFont),
                  ),
                ]),

                //Your Interests
                MultiSliver(children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 25.0, left: 15.0, right: 15.0, bottom: 15.0),
                    child: Text(
                      "Your Interests",
                      style: sectionTitles,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Center(
                      child: SizedBox(
                        height: 90,
                        child: ListView.builder(
                          primary: false,
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(left: 10, right: 10),
                          itemCount: myInterestsFinal.length,
                          itemBuilder: (context, index) {
                            final likedInterests = myInterestsFinal[index];
                            return CategorySmall(
                              categoryImage: likedInterests.categoryImage,
                              categoryName: likedInterests.categoryName,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ]),
                //Trainer Classes (If Trainer)
                if (widget.userInstance.userType == UserType.Trainer)
                  //Trainer Classes //HARD CODED - MUST CHANGE
                  MultiSliver(children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 25.0, left: 15.0, right: 15.0, bottom: 15.0),
                      child: Text(
                        "Your Classes",
                        style: sectionTitles,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 340,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(
                            left: 15.0,
                            right: 15.0,
                          ),
                          itemCount: trainerClasses.length,
                          itemBuilder: (context, index) {
                            final trainerClassInfo = trainerClasses[index];
                            return ProfileClassCard(
                              classItem: trainerClassInfo,
                              userInstance: widget.userInstance,
                            );
                          },
                        ),
                      ),
                    ),
                  ]),

                //Saved Classes
                MultiSliver(children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 25.0, left: 15.0, right: 15.0, bottom: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Saved Classes",
                          style: sectionTitles,
                        ),
                        GestureDetector(
                          child: Text(
                            'See All',
                            style: TextStyle(
                              color: ocean,
                              fontFamily: 'SFDisplay',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //If the user has no liked classes
                  if (savedClassesList.isEmpty)
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 20.0, bottom: 20.0),
                      child: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: SvgPicture.asset(
                              'assets/icons/generalIcons/favouriteFill.svg',
                              color: shark,
                              height: 28,
                            ),
                          ),
                          Text(
                            'No saved classes yet',
                            textAlign: TextAlign.center,
                            style: emptyListDisclaimerText,
                          ),
                        ],
                      ),
                    )

                  //If the user has liked classes ~ display the list
                  else
                    SliverToBoxAdapter(
                      child: ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.only(left: 26, right: 26),
                        itemCount: savedClassesList.length < 3
                            ? savedClassesList.length
                            : 3,
                        itemBuilder: (context, index) {
                          final savedClasses = savedClassesList[index];
                          return ClassItemCondensed1(
                            classImageUrl: savedClasses.classImageUrl,
                            buttonBookOrRebookText: 'Book',
                            classTitle: savedClasses.className,
                            classTrainer: trainerFirstName,
                            classTrainerImageUrl: trainerImageURL,
                          );
                        },
                      ),
                    ),
                ]),
                MultiSliver(children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 25.0, left: 15.0, right: 15.0, bottom: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Class History",
                          style: sectionTitles,
                        ),
                        GestureDetector(
                          child: Text(
                            'See All',
                            style: TextStyle(
                              color: ocean,
                              fontFamily: 'SFDisplay',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  //If the user has no liked classes
                  if (savedClassesList.isEmpty)
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 20.0, bottom: 20.0),
                      child: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: SvgPicture.asset(
                              'assets/icons/generalIcons/listIcon.svg',
                              color: shark,
                              height: 35,
                            ),
                          ),
                          Text(
                            'No classes taken yet',
                            textAlign: TextAlign.center,
                            style: emptyListDisclaimerText,
                          ),
                        ],
                      ),
                    )

                  //If the user has liked classes ~ display the list
                  else
                    SliverToBoxAdapter(
                      child: ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.only(left: 26, right: 26),
                        itemCount: savedClassesList.length < 3
                            ? savedClassesList.length
                            : 3,
                        itemBuilder: (context, index) {
                          if (savedClassesList.isEmpty) {
                            return Container();
                          } else {
                            final savedClasses = savedClassesList[index];
                            return ClassItemCondensed1(
                              classImageUrl: savedClasses.classImageUrl,
                              buttonBookOrRebookText: 'Book',
                              classTitle: savedClasses.className,
                              classTrainer: trainerFirstName,
                              classTrainerImageUrl: trainerImageURL,
                            );
                          }
                        },
                      ),
                    ),
                ]),
                // ignore: prefer_const_literals_to_create_immutables
                MultiSliver(children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 25.0, left: 15.0, right: 15.0, bottom: 15.0),
                    child: Text(
                      "Posted Reviews",
                      style: sectionTitles,
                    ),
                  ),

                  //HARD CODED - MUST CHANGE
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                      right: 15.0,
                    ),
                    child: ReviewCard(),
                  ),
                  SizedBox(
                    height: 80,
                  )
                ]),
              ]),
          if (widget.userInstance.userType == UserType.Trainer &&
              widget.userInstance.stripeAccountID == null)
            Positioned(
              bottom: 15,
              child: SlideTransition(
                position: offset,
                child: GestureDetector(
                  child: NoticeDisclaimer(
                    textBoxSize: 230,
                    disclaimerTitle: 'Start getting paid',
                    disclaimerText:
                        'Create a Stripe account to start getting paid for your sessions',
                    buttonText: 'Start',
                  ),
                  onTap: () {
                    HapticFeedback.selectionClick();
                    StripeLogic().stripeSetUp(widget.userInstance);
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
