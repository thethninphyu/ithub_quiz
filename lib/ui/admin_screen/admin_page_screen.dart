import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ithub_quiz/ui/admin_screen/admin_profile_screen.dart';
import 'package:ithub_quiz/ui/admin_screen/home_screen.dart';
import 'package:ithub_quiz/ui/admin_screen/model/userData.dart';
import 'package:ithub_quiz/ui/admin_screen/module/question_create/question_create_screen.dart';
import 'package:ithub_quiz/utils/app_logger.dart';

class AdminPageScreen extends StatefulWidget {
  const AdminPageScreen({super.key});

  @override
  State<AdminPageScreen> createState() => _AdminPageScreenState();
}

class _AdminPageScreenState extends State<AdminPageScreen> {
  int _currentIndex = 0;
  late PageController _pageController;

  final screens = [
    const HomeScreen(),
    const QuestionCreateScreen(),
    const AdminProfileScreen()
  ];
  List title = ["Flutter", "Node Js", "Kotlin", "PhP"];

  //For admin view
  List<BottomNavigationBarItem> navMenu = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.home), backgroundColor: Colors.blue, label: 'Home'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.create),
        backgroundColor: Colors.blue,
        label: 'Create Question'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.account_circle),
        backgroundColor: Colors.blue,
        label: 'Profile'),
  ];

  //For User view

  List<BottomNavigationBarItem> navUserMenu = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.home), backgroundColor: Colors.blue, label: 'Home'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.account_circle),
        backgroundColor: Colors.blue,
        label: 'Profile'),
  ];
  @override
  void initState() {
    _pageController = PageController(initialPage: _currentIndex);
    retrieveUserRole();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    retrieveUserRole();
    super.dispose();
  }

  Future<List<UserData>> retrieveUserRole() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('users').get();

    List<UserData> userDataList = snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data();
      return UserData(
        email: data['email'] ?? '',
        role: data['role'] ?? '',
        name: '',
      );
    }).toList();

    logger.e('User Data List ${userDataList[0].role}');

    return userDataList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: navMenu,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut);
          });
        },
        elevation: 16,
        showUnselectedLabels: true,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: screens,
      ),
    );
  }
}
