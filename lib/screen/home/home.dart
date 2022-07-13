import 'package:balance/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: snow,
        appBar: AppBar(
          toolbarHeight: 80,
          centerTitle: false,
          elevation: 0,
          backgroundColor: snow,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          title: Padding(
            padding: const EdgeInsets.only(left: 26.0, top: 40, bottom: 10),
            child: Text('Home',
                style: TextStyle(
                    color: jetBlack,
                    fontFamily: 'SFDisplay',
                    fontSize: 34,
                    fontWeight: FontWeight.w600)),
          ),
          bottom: PreferredSize(
              child: Container(
                color: shark40,
                height: 1,
              ),
              preferredSize: Size.fromHeight(1)),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 26.0, top: 40, bottom: 8),
              child: SvgPicture.asset(
                'assets/icons/chatIcon.svg',
              ),
            )
          ],
        ),
        body: tabBar());
  }
}

//TabBar
Widget tabBar() {
  return DefaultTabController(
    length: 2,
    child: Scaffold(
      backgroundColor: snow,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 10,
        backgroundColor: snow,
        bottom: const TabBar(
          indicatorColor: jetBlack80,
          indicatorWeight: 2,
          labelPadding: EdgeInsets.zero,
          padding: EdgeInsets.symmetric(horizontal: 20),
          indicatorPadding: EdgeInsets.only(left: 20, right: 20),
          labelColor: jetBlack,
          labelStyle: TextStyle(
              fontFamily: 'SFDisplay',
              fontSize: 15,
              fontWeight: FontWeight.w600),
          unselectedLabelColor: shark,
          unselectedLabelStyle: TextStyle(
              fontFamily: 'SFDisplay',
              fontSize: 15,
              fontWeight: FontWeight.w500),
          tabs: [
            Tab(
              // child: Padding(
              //   padding: const EdgeInsets.only(
              //     left: 86.0,
              //     right: 91,
              //   ),
              //   child: Text('Feed'),
              // ),
              text: 'Feed',
            ),
            Tab(
              text: 'Upcoming Classes',
            ),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          Center(
            child: Text(
              'No Posts To View',
              style: homeFeedTitle,
            ),
          ),
          Center(
            child: Text(
              'No Classes To Attend',
              style: homeFeedTitle,
            ),
          )
        ],
      ),
    ),
  );
}
