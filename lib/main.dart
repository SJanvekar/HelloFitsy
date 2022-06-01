import 'package:balance/constants.dart';
import 'package:balance/screen/home/components/classCardOpen.dart';
import 'package:balance/screen/home/home.dart';
import 'package:balance/screen/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

void main() {
  runApp(const Balance());
}

class Balance extends StatelessWidget {
  const Balance({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitsy',
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Home(),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            border: Border(
                top: BorderSide(
          color: shark40,
          width: 1,
        ))),
        height: 100,
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: snow,
          selectedItemColor: strawberry,
          unselectedItemColor: shark40,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/Home.svg',
                  width: 25,
                  height: 26.5,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/Explore.svg',
                  width: 25,
                  height: 25,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/User.svg',
                  width: 30,
                  height: 25,
                ),
                label: ''),
          ],
        ),
      ),
    );
  }
}
