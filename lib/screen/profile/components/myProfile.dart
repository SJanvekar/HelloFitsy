// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'dart:ui';
import 'package:balance/constants.dart';
import 'package:balance/feModels/categories.dart';
import 'package:balance/sharedWidgets/bodyButton.dart';
import 'package:balance/sharedWidgets/categories/categorySmall.dart';
import 'package:balance/sharedWidgets/classes/classItemCondensed1.dart';
import 'package:balance/sharedWidgets/pageDivider.dart';
import 'package:balance/sharedWidgets/reviewCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliver_tools/sliver_tools.dart';
import '../../../feModels/classModel.dart';

class PersonalProfile extends StatefulWidget {
  PersonalProfile({
    Key? key,
  }) : super(key: key);

  @override
  State<PersonalProfile> createState() => _PersonalProfileState();
}

List<Category> interests = categoriesList;
List<Category> myInterestsFinal = myInterests;
List<Class> savedClassesList = classList;

class _PersonalProfileState extends State<PersonalProfile> {
  //User details:
  String? profileImageUrl;
  String userName = "";
  String userFullName = "";
  String userFirstName = "";
  String userLastName = "";

  Color titleColor = Colors.transparent;
  Color _textColor = Colors.transparent;
  Color iconCircleColor = shark60;
  Color iconColor = snow;
  late ScrollController _scrollController;
  Brightness statusBarTheme = Brightness.dark;
  bool isFollowing = false;

  var userInterests = ['Flexibility', 'Boxing', 'Tennis', 'Soccer'];

//----------
  @override
  void initState() {
    super.initState();
    getUserDetails();

    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          _textColor = _isSliverAppBarExpanded ? jetBlack : Colors.transparent;
          iconCircleColor = _isSliverAppBarExpanded ? snow : shark60;
          iconColor = _isSliverAppBarExpanded ? jetBlack : snow;
          statusBarTheme =
              _isSliverAppBarExpanded ? Brightness.light : Brightness.dark;
        });
      });
  }

//----------
  void getUserDetails() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    userName = sharedPrefs.getString('userName') ?? '';
    userFirstName = sharedPrefs.getString('firstName') ?? '';
    userLastName = sharedPrefs.getString('lastName') ?? '';
    userFullName = '${userFirstName}' + ' ' + '${userLastName}';
    getSet2UserDetails();
    checkInterests();

    setState(() {});
  }

  void getSet2UserDetails() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    profileImageUrl = sharedPrefs.getString('profileImageURL') ?? '';
  }

//----------
  void checkInterests() {
    for (var i = 0; i < interests.length; i++) {
      if (userInterests.contains(interests[i].categoryName)) {
        myInterestsFinal.add(interests[i]);
      }
    }
    ;
  }

//----------
  bool get _isSliverAppBarExpanded {
    return _scrollController.hasClients &&
        _scrollController.offset >
            (MediaQuery.of(context).size.height * 0.37 - kToolbarHeight);
  }

//----------
//Title Colour Function
  _followOnTap() {
    setState(() {
      isFollowing = !isFollowing;
      HapticFeedback.mediumImpact();
    });
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
                userFullName,
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
              // Padding(
              //   padding: const EdgeInsets.only(left: 10.0),
              //   child:
              // ),
            ],
          ),
          Text(
            '@' + userName,
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
          // trainerSubHeader(),
        ]);
  }

//Edit Profile button
  Widget editProfileButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 26.0, right: 26.0),
      child: Container(
        alignment: Alignment.center,
        height: 40,
        width: (MediaQuery.of(context).size.width - (26 * 2) - 32 - 8),
        decoration: BoxDecoration(
            color: shark40, borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: Text(
            'Edit profile',
            style: TextStyle(
                color: jetBlack,
                fontFamily: 'SFDisplay',
                fontSize: 14.0,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
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
      body: CustomScrollView(
          shrinkWrap: false,
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              leading: GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 26.0,
                    top: 11.5,
                    bottom: 11.5,
                  ),
                  child: ClipOval(
                      child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 1,
                      sigmaY: 1,
                    ),
                    child: Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(color: iconCircleColor),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.5, bottom: 8.5),
                        child: SvgPicture.asset(
                          'assets/icons/generalIcons/arrowLeft.svg',
                          color: iconColor,
                          height: 13,
                          width: 6,
                        ),
                      ),
                    ),
                  )),
                ),
                onTap: () => {Navigator.of(context).pop()},
              ),
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
                    if (profileImageUrl != null)
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                profileImageUrl!,
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
                  padding: const EdgeInsets.only(left: 26.0, right: 26.0),
                  child: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      max = 382.76 - mobilePaddingPlusToolBar;
                      top =
                          constraints.biggest.height - mobilePaddingPlusToolBar;

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
                  child: ClipOval(
                      child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 1,
                      sigmaY: 1,
                    ),
                    child: Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(color: iconCircleColor),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: SvgPicture.asset(
                          'assets/icons/generalIcons/settings.svg',
                          color: iconColor,
                          height: 15,
                          width: 15,
                        ),
                      ),
                    ),
                  )),
                ),
              ],
              title: Text(userFullName,
                  style: TextStyle(
                      color: _textColor,
                      fontFamily: 'SFDisplay',
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0)),
            ),
            MultiSliver(children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: GestureDetector(
                  child: editProfileButton(),

                  //Open edit profile modal sheet
                  onTap: () {
                    //Set the status bar theme to light (Black Header);
                    setState(() {
                      statusBarTheme = Brightness.light;
                    });

                    //FirstName
                    final TextEditingController _firstNameController =
                        new TextEditingController();
                    _firstNameController.text = userFirstName;

                    final TextEditingController _lastNameController =
                        new TextEditingController();
                    _lastNameController.text = userLastName;

                    final TextEditingController _userNameController =
                        new TextEditingController();
                    _userNameController.text = userName;

                    final TextEditingController _bioController =
                        new TextEditingController();

                    //Cupertino Modal Pop-up - Profile Edit
                    showCupertinoModalPopup(
                        semanticsDismissible: true,
                        barrierColor: jetBlack60,
                        context: context,
                        builder: (BuildContext builder) {
                          File? newProfileImage;
                          String? newFirstName;
                          String? newLastName;
                          String? newUserName;
                          String? newBio;

                          return StatefulBuilder(
                            builder: (BuildContext context,
                                StateSetter setEditProfileState) {
                              //Modal widgets + functions

                              //Pick Image Function
                              Future pickImage(ImageSource source) async {
                                try {
                                  var image = await ImagePicker()
                                      .pickImage(source: ImageSource.gallery);
                                  print(image?.path);
                                  if (image == null) {
                                    image = XFile(
                                        'assets/images/profilePictureDefault.png');
                                    return;
                                  }

                                  setEditProfileState(() {
                                    if (image != null) {
                                      newProfileImage = File(image.path);
                                    }
                                  });
                                } on PlatformException catch (e) {
                                  print('Failed to pick image $e');
                                }
                              }

                              //Textfield widgets
                              //Edit First Name
                              Widget editFirstName() {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'First Name',
                                      style: logInPageBodyText,
                                    ),
                                    TextField(
                                      controller: _firstNameController,
                                      maxLengthEnforcement:
                                          MaxLengthEnforcement.none,
                                      autocorrect: true,
                                      cursorColor: ocean,
                                      maxLines: null,
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      textInputAction: TextInputAction.done,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          fontFamily: 'SFDisplay',
                                          color: jetBlack,
                                          fontSize: 16.5,
                                          fontWeight: FontWeight.w500),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                      onChanged: (val) {
                                        newFirstName = val;
                                      },
                                    ),
                                    PageDivider(leftPadding: 0, rightPadding: 0)
                                  ],
                                );
                              }

                              //Edit Last Name
                              Widget editLastName() {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Last Name',
                                      style: logInPageBodyText,
                                    ),
                                    TextField(
                                      controller: _lastNameController,
                                      maxLengthEnforcement:
                                          MaxLengthEnforcement.none,
                                      autocorrect: true,
                                      cursorColor: ocean,
                                      maxLines: null,
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      textInputAction: TextInputAction.done,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          fontFamily: 'SFDisplay',
                                          color: jetBlack,
                                          fontSize: 16.5,
                                          fontWeight: FontWeight.w500),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                      onChanged: (val) {
                                        newLastName = val;
                                      },
                                    ),
                                    PageDivider(leftPadding: 0, rightPadding: 0)
                                  ],
                                );
                              }

                              //Edit UserName
                              Widget editUserName() {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Username',
                                      style: logInPageBodyText,
                                    ),
                                    TextField(
                                      controller: _userNameController,
                                      maxLengthEnforcement:
                                          MaxLengthEnforcement.none,
                                      autocorrect: true,
                                      cursorColor: ocean,
                                      maxLines: null,
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      textInputAction: TextInputAction.done,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          fontFamily: 'SFDisplay',
                                          color: jetBlack,
                                          fontSize: 16.5,
                                          fontWeight: FontWeight.w500),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                      onChanged: (val) {
                                        newUserName = val;
                                      },
                                    ),
                                    PageDivider(leftPadding: 0, rightPadding: 0)
                                  ],
                                );
                              }

                              //Edit Bio
                              Widget editBio() {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Bio',
                                      style: logInPageBodyText,
                                    ),
                                    TextField(
                                      maxLengthEnforcement:
                                          MaxLengthEnforcement.none,
                                      autocorrect: true,
                                      cursorColor: ocean,
                                      maxLines: null,
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      textInputAction: TextInputAction.newline,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          fontFamily: 'SFDisplay',
                                          color: jetBlack,
                                          fontSize: 16.5,
                                          fontWeight: FontWeight.w500),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                      onChanged: (val) {
                                        newBio = val;
                                      },
                                    ),
                                    PageDivider(leftPadding: 0, rightPadding: 0)
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
                                    automaticallyImplyLeading: false,
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            print("Cancel");
                                            Navigator.of(context).pop();
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
                                          onPressed: () {
                                            newFirstName ??= userFirstName;
                                            newLastName ??= userLastName;
                                            newUserName ??= userName;
                                            print(newFirstName);
                                            print(newLastName);
                                            print(newUserName);
                                            print("Save");

                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Done",
                                              style: doneTextButton),
                                        ),
                                      ],
                                    ),
                                  ),
                                  body: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 26.0, right: 26.0),
                                    child: Container(
                                      height: MediaQuery.of(context)
                                          .copyWith()
                                          .size
                                          .height,
                                      decoration: BoxDecoration(
                                        color: snow,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: CustomScrollView(
                                        slivers: [
                                          MultiSliver(children: [
                                            Center(
                                                child: Stack(
                                              children: [
                                                if (newProfileImage != null)
                                                  ClipOval(
                                                      child: Image.file(
                                                    newProfileImage!,
                                                    width: 180,
                                                    height: 180,
                                                    fit: BoxFit.cover,
                                                  ))
                                                else if (profileImageUrl !=
                                                        null &&
                                                    newProfileImage == null)
                                                  ClipOval(
                                                      child: Image(
                                                    image: NetworkImage(
                                                        profileImageUrl!),
                                                    width: 180,
                                                    height: 180,
                                                    fit: BoxFit.cover,
                                                  ))
                                                else
                                                  ClipOval(
                                                      child: Image.asset(
                                                    'assets/images/profilePictureDefault.png',
                                                    width: 180,
                                                    height: 180,
                                                    fit: BoxFit.cover,
                                                  ))
                                              ],
                                            )),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 15.0,
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.2,
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.2),
                                              child: GestureDetector(
                                                child: BodyButton(
                                                  buttonColor: strawberry,
                                                  textColor: snow,
                                                  buttonText:
                                                      'Upload new picture',
                                                ),
                                                onTap: () {
                                                  pickImage(
                                                      ImageSource.gallery);
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 40.0),
                                              child: editFirstName(),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 25.0),
                                              child: editLastName(),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 25.0),
                                              child: editUserName(),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 25.0),
                                              child: editBio(),
                                            ),
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

                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                },
                              );
                            },
                          );
                        });
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 20.0, left: 26.0, right: 26.0),
                child: Text(
                  'About me',
                  style: sectionTitles,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 10.0, left: 26.0, right: 26.0),
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
                padding:
                    const EdgeInsets.only(top: 8.0, left: 26.0, right: 20.0),
                child: Text(
                    "I've been looking for a boxing trainer the last few weeks and really want to get started with the right trainer! My hobbies include tennis, soccer, golf, and general working out.",
                    style: profileBodyTextFont),
              ),
            ]),
            MultiSliver(children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 25.0, left: 26.0, right: 26.0, bottom: 15.0),
                child: Text(
                  "Your Interests",
                  style: sectionTitles,
                ),
              ),
              SliverToBoxAdapter(
                child: Center(
                  child: SizedBox(
                    height: 84,
                    child: ListView.builder(
                      primary: false,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(left: 13, right: 13),
                      itemCount: myInterestsFinal.length,
                      itemBuilder: (context, index) {
                        final _likedInterests = myInterestsFinal[index];
                        return CategorySmall(
                          categoryImage: _likedInterests.categoryImage,
                          categoryName: _likedInterests.categoryName,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ]),

            MultiSliver(children: [
              Padding(
                padding: EdgeInsets.only(
                    top: 25.0, left: 26.0, right: 26.0, bottom: 15.0),
                child: Text(
                  "Saved Classes",
                  style: sectionTitles,
                ),
              ),

              //If the user has no liked classes
              if (savedClassesList.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(
                      left: 26.0, right: 26.0, top: 20.0, bottom: 20.0),
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
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: BodyButton(
                            buttonColor: strawberry,
                            textColor: snow,
                            buttonText: 'Explore classes'),
                      )
                    ],
                  ),
                )

              //If the user has liked classes ~ display the list
              else
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 250,
                    child: ListView.builder(
                      primary: false,
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.only(left: 26, right: 26),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        final _savedClasses = savedClassesList[index];
                        return ClassItemCondensed1(
                          classImageUrl: _savedClasses.classImageUrl,
                          buttonBookOrRebookText: 'Book',
                          classTitle: _savedClasses.className,
                          classTrainer: _savedClasses.classTrainerFirstName,
                          classTrainerImageUrl: _savedClasses.trainerImageUrl,
                        );
                      },
                    ),
                  ),
                ),
            ]),
            MultiSliver(children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 25.0, left: 26.0, right: 26.0, bottom: 15.0),
                child: Text(
                  "Class History",
                  style: sectionTitles,
                ),
              ),
              //If the user has no liked classes
              if (savedClassesList.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(
                      left: 26.0, right: 26.0, top: 20.0, bottom: 20.0),
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
                  child: SizedBox(
                    height: 250,
                    child: ListView.builder(
                      primary: false,
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.only(left: 26, right: 26),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        if (savedClassesList.isEmpty) {
                          return Container();
                        } else {
                          final _savedClasses = savedClassesList[index];
                          return ClassItemCondensed1(
                            classImageUrl: _savedClasses.classImageUrl,
                            buttonBookOrRebookText: 'Book',
                            classTitle: _savedClasses.className,
                            classTrainer: _savedClasses.classTrainerFirstName,
                            classTrainerImageUrl: _savedClasses.trainerImageUrl,
                          );
                        }
                      },
                    ),
                  ),
                ),
            ]),
            // ignore: prefer_const_literals_to_create_immutables
            MultiSliver(children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 25.0, left: 26.0, right: 26.0, bottom: 15.0),
                child: Text(
                  "Posted Reviews",
                  style: sectionTitles,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 26.0, right: 26.0),
                child: ReviewCard(),
              ),
              SizedBox(
                height: 80,
              )
            ]),
          ]),
    );
  }
}
