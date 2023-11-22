import 'package:flutter/material.dart';
import 'package:ithub_quiz/ui/admin_screen/home_screen.dart';
import 'package:ithub_quiz/ui/admin_screen/module/question_create/question_create_screen.dart';

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
  ];
  List title = ["Flutter", "Node Js", "Kotlin", "PhP"];
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

  @override
  void initState() {
    _pageController = PageController(initialPage: _currentIndex);

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
