import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learnara/screen/course_screen.dart';
import 'package:learnara/features/home/presentation/view/bottom_view/dashboard_view.dart';
import 'package:learnara/screen/profile.dart';
import 'package:learnara/screen/progress_screen.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectIndex = 0;
  List<Widget> lstBottomScreen = [
    const DashboardView(),
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
              icon: const Icon(Icons.home_filled),
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
          backgroundColor: Colors.white,
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