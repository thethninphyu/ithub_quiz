import 'package:flutter/material.dart';
import 'package:ithub_quiz/constants/colors.dart';
import 'package:ithub_quiz/ui/admin_screen/module/question_create/create_question_module.dart';
import 'package:ithub_quiz/ui/admin_screen/module/question_create/create_question_route.dart';
import 'package:ithub_quiz/utils/app_router.dart';

class QuestionCreateScreen extends StatefulWidget {
  const QuestionCreateScreen({super.key});

  @override
  State<QuestionCreateScreen> createState() => _AdminMenuScreenState();
}

class _AdminMenuScreenState extends State<QuestionCreateScreen> {
  List imgSrc = [
    "assets/flutter.png",
    "assets/js.png",
    "assets/kotlin.jpg",
    "assets/php.jpg"
  ];
  List title = ["Flutter", "Node Js", "Kotlin", "PhP"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Question Screen')),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: GridView.builder(
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (() {
                AppRouter.changeRoute<CreateQuestionModule>(CreateQuestionRoutes.question);
              }),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.primaryColor,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 1,
                          spreadRadius: 1),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        imgSrc[index],
                        width: 90,
                      ),
                      Text(
                        title[index],
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          itemCount: imgSrc.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 1.1, mainAxisSpacing: 25),
          shrinkWrap: true,
        ),
      ),
    );
  }
}
