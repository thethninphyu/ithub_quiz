import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:ithub_quiz/Admin/admin_page_screen.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized(); // Ensure that binding is initialized

  runApp(const ItHubQuizApp());
}

class ItHubQuizApp extends StatelessWidget {
  
  // Correct the constructor
  const ItHubQuizApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
        debugShowCheckedModeBanner: false,
       getPages: [
          GetPage(name: "/AdminPageScreen", page: () => const AdminPageScreen()),
        ],
        initialRoute: "/AdminPageScreen",
        defaultTransition: Transition.fadeIn, // You can customize the transition if needed
      );
    
  }
  
  
  
}

