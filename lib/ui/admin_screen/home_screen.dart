import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  var width, height;

  List imgSrc = [
    "assets/flutter.png",
    "assets/js.png",
    "assets/kotlin.jpg",
    "assets/php.jpg"
  ];
  List title = [
    "Flutter","Node Js","Kotlin","PhP"
  ];

  List<BottomNavigationBarItem> navMenu = [
    BottomNavigationBarItem(
        icon: Icon(Icons.home), backgroundColor: Colors.blue, label: 'Home'),
    BottomNavigationBarItem(
        icon: Icon(Icons.menu), backgroundColor: Colors.blue, label: 'Menu'),
    BottomNavigationBarItem(
        icon: Icon(Icons.account_circle),
        backgroundColor: Colors.blue,
        label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: navMenu,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        elevation: 16,
        showUnselectedLabels: true,
      ),
      body: Container(
        color: AppColors.secondaryColor,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: AppColors.secondaryColor),
              height: height * 0.25,
              width: width,
              child: Padding(
                padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dashboard',
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                            letterSpacing: 1),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text('Last Update : 7 day Set 2023',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                              letterSpacing: 1)),
                    ]),
              ),
            ),
            Expanded(
              child: Container(
                width: width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: GridView.builder(
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {},
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 1,
                                    spreadRadius: 1)
                              ]),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 15,bottom: 15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                  Image.asset(imgSrc[index],
                                  width : 100),
                                  Text(title[index],style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                                ]),
                              ),
                        ),
                     );
                    },
                    itemCount: imgSrc.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.1,
                        mainAxisSpacing: 25),
                    shrinkWrap: true,
                  ),
                ),
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}
