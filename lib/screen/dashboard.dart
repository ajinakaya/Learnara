import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learnara/screen/course_screen.dart';
import 'package:learnara/screen/home_screen.dart';
import 'package:learnara/screen/profile.dart';
import 'package:learnara/screen/progress_screen.dart';

class Dashbaord extends StatefulWidget {
  const Dashbaord({super.key});

  @override
  State<Dashbaord> createState() => _DashbaordState();
}

class _DashbaordState extends State<Dashbaord> {
  int _selectIndex = 0;
  List<Widget> lstBottomScreen = [
    const HomeScreen(),
    const CourseScreen(),
    const ProgressScreen(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: lstBottomScreen[_selectIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10.0,
              spreadRadius: 1.0,
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.menu_book_outlined),
              label: 'Learn',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.bar_chart),
              label: 'Progress',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,

          onTap: (index) {
            setState(() {
              _selectIndex = index;
            });
          },

        ),
      ),
    );
  }
}