import 'package:balance/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

const double _kSearchHeight = 50.0;
const double _kHeaderHeight = 300.0;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: snow,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              delegate: DelegateWithSearchBar(),
              pinned: true,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  for (int i = 0; i < 4; i++)
                    Padding(
                      padding: const EdgeInsets.all(26.0),
                      child: Container(
                        height: 200,
                        child: Text('test'),
                        color: snow,
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DelegateWithSearchBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final showSearchBar = shrinkOffset > _kHeaderHeight - _kSearchHeight;

    return Stack(
      children: <Widget>[
        AnimatedOpacity(
          opacity: !showSearchBar ? 1 : 0,
          duration: Duration(milliseconds: 150),
          child: LayoutBuilder(builder: (context, constraints) {
            return Container(
              decoration: BoxDecoration(color: snow),
              height: constraints.maxHeight,
              child: SafeArea(
                child: Container(
                    padding: EdgeInsets.only(left: 20, bottom: 10),
                    alignment: Alignment.bottomLeft,
                    child: Stack(
                      clipBehavior: Clip.none,
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          'assets/images/theBOY.JPG',
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          child: userTitleCard(),
                        ),
                      ],
                    )),
              ),
            );
          }),
        ),
        AnimatedOpacity(
          opacity: showSearchBar ? 1 : 0,
          duration: Duration(milliseconds: 150),
          curve: Curves.easeIn,
          child: Container(
              height: _kSearchHeight,
              color: snow,
              alignment: Alignment.center,
              child: Text(
                'Sample Text',
                style: TextStyle(
                    color: jetBlack,
                    fontSize: 20,
                    fontFamily: 'SFDisplay',
                    fontWeight: FontWeight.w600),
              )),
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate _) => true;

  @override
  double get maxExtent => _kHeaderHeight;

  @override
  double get minExtent => _kSearchHeight;
}

//Class Type and Title
Widget userTitleCard() {
  return Padding(
    padding: const EdgeInsets.only(
      left: 26.0,
    ),
    child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 2.0,
              right: 20.0,
            ),
            child: Text(
              'Salman Janvekar',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'SFDisplay',
                fontWeight: FontWeight.w600,
                color: snow,
              ),
              maxLines: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 2.0),
                  child: SvgPicture.asset(
                    'assets/icons/navigationBarIcon/User.svg',
                    color: snow,
                    height: 10,
                  ),
                ),
                Text(
                  'salman',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: snow,
                      fontFamily: 'SFDisplay'),
                  maxLines: 1,
                ),
              ],
            ),
          ),
          trainerSubHeader(),
        ]),
  );
}

//Class Location
Widget trainerSubHeader() {
  return Row(
    children: [
      Text(
        'Toronto, Ontario',
        style: TextStyle(
            color: snow,
            fontSize: 15,
            fontWeight: FontWeight.w600,
            fontFamily: 'SFDisplay'),
      ),
      Padding(
          padding: EdgeInsets.only(
            left: 5,
            right: 5,
          ),
          child: SvgPicture.asset('assets/icons/CircleDivider.svg',
              height: 4, width: 4, color: bone)),
      trainerRating(),
    ],
  );
}

//Class Trainer Rating
Widget trainerRating() {
  return Row(
    children: [
      //Star Icon
      SvgPicture.asset(
        'assets/icons/StarRating.svg',
        height: 15,
        width: 15,
      ),

      //Rating (Numeric)
      Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: Container(
          height: 20,
          width: 30,
          decoration: BoxDecoration(
              color: jetBlack, borderRadius: BorderRadius.circular(20.0)),
          child: Center(
            child: Text(
              ' 4.5 ',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
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
          '(479 Reviews)',
          style: TextStyle(
              color: shark,
              fontSize: 14,
              fontFamily: 'SFDisplay',
              fontWeight: FontWeight.w600,
              letterSpacing: 0),
        ),
      )
    ],
  );
}
