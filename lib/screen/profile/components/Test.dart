import 'dart:math';

import 'package:balance/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Test extends StatefulWidget {
  @override
  _CustomSliverAppbarState createState() => _CustomSliverAppbarState();
}

class _CustomSliverAppbarState extends State<Test>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              toolbarHeight: 65,
              flexibleSpace: FlexibleSpaceBar(
                background:
                    Image.asset('assets/images/theBOY.JPG', fit: BoxFit.cover),
                centerTitle: true,
                title: Text('Salman Janvekar',
                    style: TextStyle(
                        color: snow,
                        fontFamily: 'SFDisplay',
                        fontWeight: FontWeight.w600,
                        fontSize: 22.0)),
              ),
              elevation: 0,
              stretch: true,
              floating: false,
              pinned: true,
              expandedHeight: MediaQuery.of(context).size.height * 0.45,
              backgroundColor: snow,
              bottom: TabBar(
                  indicatorColor: Colors.black,
                  labelPadding: const EdgeInsets.only(
                    bottom: 16,
                  ),
                  controller: _tabController,
                  tabs: [
                    Text(
                      "TAB A",
                      style: TextStyle(color: strawberry),
                    ),
                    Text("TAB B", style: TextStyle(color: strawberry)),
                  ]),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            TabA(),
            const Center(
              child: Text(
                'Display Tab 2',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class TabA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.separated(
        separatorBuilder: (context, child) => Divider(
          height: 1,
        ),
        padding: EdgeInsets.all(0.0),
        itemCount: 30,
        itemBuilder: (context, i) {
          return Container(
            height: 100,
            width: double.infinity,
            color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
          );
        },
      ),
    );
  }
}
