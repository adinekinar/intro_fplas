import 'package:flutter/material.dart';
import 'package:intro_fplas/Pages/learnpage.dart';
import 'package:intro_fplas/Pages/progresspage.dart';
import 'package:intro_fplas/Pages/settingpage.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    Learnpage(),
    Progresspage(),
    Settingpage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
           'Flutter PLAS',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
        ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: MotionTabBar(
        labels: const ["Learn", "Progress", "Settings"],
        icons: const [Icons.school_rounded, Icons.donut_large_rounded, Icons.settings],
        initialSelectedTab: "Learn",
        tabIconColor: Colors.blueGrey[900],
        tabSelectedColor: Colors.blueAccent[100],
        textStyle: const TextStyle(color: Colors.white),
        tabIconSize: 28.0,
        tabBarColor: Colors.blueAccent,
        onTabItemSelected: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}