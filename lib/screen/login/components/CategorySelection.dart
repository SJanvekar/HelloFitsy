import 'package:balance/Authentication/authService.dart';
import 'package:balance/constants.dart';
import 'package:balance/feModels/AuthModel.dart';
import 'package:balance/screen/home/HomeCopy.dart';
import 'package:balance/screen/login/components/CategorySelect_bloc.dart';
import 'package:balance/screen/login/components/SetUpTrainerStripeAccount.dart';
import 'package:balance/screen/login/components/personalInfo.dart';
import 'package:balance/sharedWidgets/searchBarWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../feModels/Categories.dart';
import '../../../sharedWidgets/loginFooterButton.dart';
import '../../../feModels/UserModel.dart';

class CategorySelection extends StatefulWidget {
  const CategorySelection(
      {Key? key, required this.authTemplate, required this.userTemplate})
      : super(key: key);

  final Auth authTemplate;
  final User userTemplate;

  @override
  State<CategorySelection> createState() => _CategorySelectionState();
}

List<Category> allCategories = categoriesList;

class _CategorySelectionState extends State<CategorySelection> {
  //variables
  List<String> selectedCategories = [];
  int i = allCategories.length;
  final categorySelectBloc = CategorySelectBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: snow,
      appBar: AppBar(
        toolbarHeight: 50,
        centerTitle: false,
        elevation: 0,
        backgroundColor: snow,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 0,
              ),
              child: TextButton(
                onPressed: () {
                  print("Back to Personal Info");
                  Navigator.of(context).pop(CupertinoPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => PersonalInfo()));
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 0,
                      ),
                      child: TextButton(
                        onPressed: () {
                          print("Back");
                          Navigator.of(context).pop(CupertinoPageRoute(
                              fullscreenDialog: true,
                              builder: (context) => PersonalInfo()));
                        },
                        child: Text("Back", style: logInPageNavigationButtons),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: CustomScrollView(slivers: [
        MultiSliver(children: [
          pageTitle(),
          pageText(),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final category = allCategories[index];
                return Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: GestureDetector(
                    child: Stack(
                      children: [
                        ClipOval(
                          child: Container(
                            decoration: BoxDecoration(
                                color: snow,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage(category.categoryImage))),
                            child: Center(
                              child: Text(
                                category.categoryName,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: snow,
                                    fontFamily: 'SFDisplay',
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                        category.categoryLiked
                            ? Container(
                                decoration: BoxDecoration(
                                  color: jetBlack80,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                    child: SvgPicture.asset(
                                  'assets/icons/generalIcons/circleClassSelected.svg',
                                  height: 50,
                                  width: 50,
                                )),
                              )
                            : Container(),
                      ],
                    ),
                    onTap: () {
                      category.categoryLiked = !(category.categoryLiked);
                      HapticFeedback.selectionClick();
                      setState(() {});
                      // categorySelectBloc.categoryLikedSink
                      //     .add(category.categoryLiked);
                    },
                  ),
                );
              },
              childCount: allCategories.length,
            ),
          )
        ])
      ]),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
            bottom: 55.0, top: 10.0, left: 26.0, right: 26.0),
        child: GestureDetector(
          child: FooterButton(
              buttonColor: strawberry, textColor: snow, buttonText: 'Continue'),
          onTap: () => {
            selectedCategories.clear(),
            for (i = 0; i < allCategories.length; i++)
              {
                if (allCategories[i].categoryLiked == true)
                  {selectedCategories.add(allCategories[i].categoryName)}
                else
                  {selectedCategories.remove(allCategories[i].categoryName)}
              },
            userTemplate.categories = selectedCategories,
            if (userTemplate.userType == UserType.Trainee)
              {
                sendUserModel(),
              }
            else
              {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SetUpTrainerStripeAccount(
                        authTemplate: authTemplate,
                        userTemplate: userTemplate)))
              }
          },
        ),
      ),
    );
  }

  void sendUserModel() {
    userTemplate.likedClasses = <String>[];
    userTemplate.classHistory = <String>[];
    userTemplate.followers = <String>[];
    userTemplate.following = <String>[];

    //Auth Service Call
    AuthService().signUp(authTemplate, userTemplate).then((val) {
      if (val.data['success']) {
        print('Successful user add');
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomeTest()));
      } else {
        print("Sign up error: ${val.data}");
      }
    });
  }
}

//Page title
Widget pageTitle() {
  return Center(
    child: Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
          decoration: BoxDecoration(color: snow),
          child: Text(
            'What are your interests?',
            style: logInPageTitle,
          )),
    ),
  );
}

//PageText
Widget pageText() {
  return Padding(
    padding: const EdgeInsets.only(top: 5, bottom: 15, left: 69, right: 69),
    child: RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: logInPageBodyText,
        children: const [
          TextSpan(
              text: 'Personalize your explore feed with the sports you love',
              style: TextStyle(
                fontFamily: 'SFDisplay',
                color: shark,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ))
        ],
      ),
    ),
  );
}

//Persistent Header Searchbar

//Persistent Header Private Class
class _SearchBarSliverDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrjetBlackOffset, bool overlapsContent) {
    // TODO: implement build
    return FitsySearchBar(
      isAutoFocusTrue: false,
      searchBarWidth: 323,
      searchHintText: 'Search Categories',
      callback: null,
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 100;

  @override
  // TODO: implement minExtent
  double get minExtent => 10;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return false;
  }
}
