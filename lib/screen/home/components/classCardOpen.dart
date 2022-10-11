// ignore_for_file: file_names, prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:balance/constants.dart';
import 'package:balance/sharedWidgets/categories/categorySmall.dart';
import 'package:balance/sharedWidgets/loginFooterButton.dart';
import 'package:balance/sharedWidgets/pageDivider.dart';
import 'package:balance/sharedWidgets/reviewCard.dart';
import 'package:balance/sharedWidgets/userProfileComponentDark.dart';
import 'package:balance/sharedWidgets/userProfileComponentLight.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../sharedWidgets/classMoreActions.dart';

final oCcy = new NumberFormat("#,##0", "en_US");

class ClassCardOpen extends StatefulWidget {
  ClassCardOpen({
    Key? key,
    required this.classTrainer,
    required this.userName,
    required this.className,
    required this.classType,
    required this.classLocation,
    required this.classPrice,
    required this.classLiked,
    required this.classImage,
    required this.trainerImageUrl,
    required this.classRating,
    required this.classReviews,
    required this.classDescription,
  }) : super(key: key);

  String classTrainer;
  String userName;
  String className;
  String classType;
  String classLocation;
  double classPrice;
  bool classLiked;
  String classImage;
  String trainerImageUrl;
  double classRating;
  int classReviews;
  String classDescription;

  @override
  State<ClassCardOpen> createState() => _ClassCardOpenState();
}

class _ClassCardOpenState extends State<ClassCardOpen> {
  @override
  Widget build(BuildContext context) {
    //Hides the top status bar for iOS & Android
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    // //Shows the top status bar for iOS & Android
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    //     overlays: SystemUiOverlay.values);

    return Scaffold(
      backgroundColor: snow,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 0,
        elevation: 0,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
      ),
      body: CustomScrollView(slivers: [
        //App Bar
        SliverAppBar(
          toolbarHeight: 45,
          flexibleSpace: FlexibleSpaceBar(
            background: Hero(
              tag: widget.className,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                            widget.classImage,
                          ),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          jetBlack.withOpacity(0.0),
                          jetBlack80,
                        ],
                            stops: [
                          0.0,
                          1.0
                        ])),
                  ),
                  Positioned(
                      bottom: 25,
                      left: 26.0,
                      child: UserProfileComponentDark(
                        imageURL: widget.trainerImageUrl,
                        profileImageRadius: 25,
                        userFullName: widget.classTrainer,
                        userFullNameFontSize: 15,
                        userName: widget.userName,
                        userNameFontSize: 13,
                      )),
                  Positioned(
                      bottom: 30,
                      right: 10,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: GestureDetector(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SvgPicture.asset(
                                  'assets/icons/generalIcons/ellipses.svg',
                                  color: bone),
                              Container(
                                height: 40,
                                width: 60,
                                color: Colors.transparent,
                              ),
                            ],
                          ),
                          onTap: () => {
                            showModalBottomSheet(
                                isDismissible: true,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (BuildContext context) {
                                  return classMoreActions(
                                    userFullName: widget.classTrainer,
                                  );
                                })
                          },
                        ),
                      ))
                ],
              ),
            ),
            stretchModes: const [StretchMode.zoomBackground],
          ),
          elevation: 0,
          stretch: true,
          floating: false,
          pinned: true,
          automaticallyImplyLeading: false,
          expandedHeight: MediaQuery.of(context).size.height * 0.4,
          backgroundColor: snow,
          leading: Padding(
            padding: const EdgeInsets.only(
              left: 26,
            ),
            child: GestureDetector(
              //Check this
              child: SvgPicture.asset(
                'assets/icons/generalIcons/classExit.svg',
                width: 30,
                height: 30,
              ),
              onTap: () => {Navigator.of(context).pop()},
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                child: SvgPicture.asset(
                  widget.classLiked
                      ? 'assets/icons/generalIcons/favouriteClassLiked.svg'
                      : 'assets/icons/generalIcons/favouriteClassOutline.svg',
                  height: 32,
                  width: 32,
                ),
                onTap: () {
                  setState(() {
                    widget.classLiked = !widget.classLiked;
                    HapticFeedback.mediumImpact();
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 26.0),
              child: GestureDetector(
                child: SvgPicture.asset(
                  'assets/icons/generalIcons/classShare.svg',
                  height: 32,
                  width: 32,
                ),
                onTap: () => print('Share Button Pressed'),
              ),
            ),
          ],
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 26.0, right: 26.0),
            child: classTitle(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2, left: 26.0, right: 26.0),
            child: classSubHeader(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 26.0, right: 26.0),
            child: classPriceWidget(),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20, left: 26.0, right: 26.0),
          ),
          PageDivider(),
          Padding(
            padding:
                EdgeInsets.only(top: 20, bottom: 20, left: 26.0, right: 26.0),
            child: classDesc(),
          ),
          PageDivider(),
          Padding(
            padding: const EdgeInsets.only(
                top: 20.0, bottom: 20.0, left: 26.0, right: 26.0),
            child: classCategories(),
          ),
          PageDivider(),
          Padding(
              padding: EdgeInsets.only(
                  top: 20.0, bottom: 20.0, left: 26.0, right: 26.0),
              child: classReviewsWidget())
        ])),
      ]),
      //Bottom Navigation Bar
      bottomNavigationBar: Container(
          height: 110,
          decoration: BoxDecoration(
              border: Border(
            top: BorderSide(color: bone, width: 1),
          )),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 14,
              bottom: 46,
            ),
            child: LoginFooterButton(
              buttonColor: strawberry,
              buttonText: 'Inquire',
              textColor: snow,
            ),
          )),
    );
  }

  //Price Container
  Widget classPriceWidget() {
    return Container(
        color: snow,
        child: Row(
          children: [
            Text(
              '\$${oCcy.format(widget.classPrice.round())}',
              style: TextStyle(
                color: strawberry,
                fontSize: 26,
                fontFamily: 'SFDisplay',
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 1.0),
              child: Text(' /session',
                  style: TextStyle(
                      color: shark,
                      fontFamily: 'SFDisplay',
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
            )
          ],
        ));
  }

//Class Type and Title
  Widget classTitle() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.classType,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: jetBlack40,
                fontFamily: 'SFDisplay'),
            maxLines: 1,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: AutoSizeText(
                          widget.className,
                          minFontSize: 20,
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'SFDisplay',
                            fontWeight: FontWeight.w600,
                            color: jetBlack,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ]),
              ),
            ],
          )
        ]);
  }

//Class Location
  Widget classSubHeader() {
    return Container(
      color: snow,
      child: Row(
        children: [
          Text(
            widget.classLocation,
            style: TextStyle(
                color: jetBlack,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                fontFamily: 'SFDisplay'),
          ),
          Padding(
              padding: EdgeInsets.only(
                left: 5,
                right: 5,
              ),
              child: ClipOval(
                child: Container(
                  color: jetBlack,
                  height: 4,
                  width: 4,
                ),
              )),
          trainerRating(),
        ],
      ),
    );
  }

//Class Trainer Rating
  Widget trainerRating() {
    return Row(
      children: [
        //Star Icon
        SvgPicture.asset(
          'assets/icons/generalIcons/star.svg',
          height: 12,
          width: 12,
          color: sunflower,
        ),

        //Rating (Numeric)
        Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Container(
            height: 20,
            width: 30,
            decoration: BoxDecoration(
              color: jetBlack80,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Center(
              child: Text(
                '${widget.classRating}',
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: snow,
                    fontFamily: 'SFDisplay'),
              ),
            ),
          ),
        ),

        //Trainer Ratings Count
        Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Text(
            '(${widget.classReviews} Reviews)',
            style: TextStyle(
                color: jetBlack,
                fontSize: 14,
                fontFamily: 'SFDisplay',
                fontWeight: FontWeight.w500,
                letterSpacing: 0),
          ),
        )
      ],
    );
  }

//Class Desc
  Widget classDesc() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.classDescription,
          style: TextStyle(
              fontFamily: 'SFDisplay',
              color: jetBlack80,
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

//Class Categories
  Widget classCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Text('Related Categories',
              style: TextStyle(
                  fontFamily: 'SFDisplay',
                  color: jetBlack,
                  fontSize: 16,
                  fontWeight: FontWeight.w600)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: CategorySmall(),
        ),
      ],
    );
  }

//Class Reviews
  Widget classReviewsWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Reviews',
                  style: TextStyle(
                      fontFamily: 'SFDisplay',
                      color: jetBlack,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Text('View all',
                      style: TextStyle(
                          fontFamily: 'SFDisplay',
                          color: shark,
                          fontSize: 15,
                          fontWeight: FontWeight.w600)),
                ),
                onTap: () => print('View all Reviews Button Pressed'),
              )
            ],
          ),
        ),
        ReviewCard(),
      ],
    );
  }
}

//Persistent Header Private Class
class _TitleSliverDelegate extends SliverPersistentHeaderDelegate {
  final String _classType;
  final String _classTitle;

  _TitleSliverDelegate(this._classType, this._classTitle);

  @override
  Widget build(
      BuildContext context, double shrjetBlackOffset, bool overlapsContent) {
    // TODO: implement build
    return Container(
        decoration: BoxDecoration(
          color: snow,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 15,
                right: 0,
                left: 20,
                bottom: 2,
              ),
              child: Text(
                _classType,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: jetBlack40,
                    letterSpacing: -0.75),
                maxLines: 1,
              ),
            ),
            Padding(
                padding: EdgeInsets.only(
                  left: 20,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 52,
                    minHeight: 26,
                    maxWidth: 335,
                    minWidth: 335,
                  ),
                  child: AutoSizeText(
                    _classTitle,
                    minFontSize: 18,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: jetBlack,
                        letterSpacing: -0.75),
                    maxLines: 2,
                  ),
                )),
          ],
        ));
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 100;

  @override
  // TODO: implement minExtent
  double get minExtent => 74;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return false;
  }
}
//Class Date

// Widget classDate() {
//   return Padding(
//     padding: const EdgeInsets.only(left: 20.0),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         RichText(
//           text: TextSpan(children: [
//             //Month
//             TextSpan(
//                 text: 'May ',
//                 style: TextStyle(
//                   fontFamily: 'SFDisplay',
//                   fontSize: 20,
//                   fontWeight: FontWeight.w700,
//                   color: jetBlack,
//                 )),
//             //Date
//             TextSpan(
//                 text: '22nd',
//                 style: TextStyle(
//                   fontFamily: 'SFDisplay',
//                   fontSize: 20,
//                   fontWeight: FontWeight.w600,
//                   color: jetBlack,
//                 ))
//           ]),
//         ),
//         Text(
//           '2022',
//           style: TextStyle(
//             fontFamily: 'SFDisplay',
//             fontSize: 24,
//             fontWeight: FontWeight.w200,
//             color: jetBlack,
//           ),
//         )
//       ],
//     ),
//   );
// }


