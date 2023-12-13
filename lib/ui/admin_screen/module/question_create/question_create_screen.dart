import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ithub_quiz/constants/colors.dart';
import 'package:ithub_quiz/ui/admin_screen/model/language_type.dart';
import 'package:ithub_quiz/ui/admin_screen/module/question_create/create_question_module.dart';
import 'package:ithub_quiz/ui/admin_screen/module/question_create/create_question_route.dart';
import 'package:ithub_quiz/utils/app_router.dart';

class QuestionCreateScreen extends StatefulWidget {
  const QuestionCreateScreen({Key? key}) : super(key: key);

  @override
  State<QuestionCreateScreen> createState() => _AdminMenuScreenState();
}

class _AdminMenuScreenState extends State<QuestionCreateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(title: const Text('Create Question Screen',),automaticallyImplyLeading: false,),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('languages').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error occur in retrieving data');
          }

          if (snapshot.hasData) {
            final docs = snapshot.data!.docs;

            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  GridView.builder(
                    itemBuilder: (context, index) {
                      final data = docs[index].data();
                      String documentId = docs[index].id;

                      return InkWell(
                        onTap: () {
                          AppRouter.changeRoute<CreateQuestionModule>(
                              CreateQuestionRoutes.question,
                              context: context,
                              args: Languages(
                                  id: documentId, langType: data['lang-type']));
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 20),
                          decoration: BoxDecoration(
                            border: Border.all(width: 0.6, color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.primaryColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                offset: const Offset(0, 7),
                                blurRadius: 0.3,
                                spreadRadius: -2,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Center(
                                    child: Text(
                                  data['lang-type'] ?? '',
                                  style: const TextStyle(
                                      color: Colors.amber,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: docs.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.1,
                      mainAxisSpacing: 25,
                    ),
                    shrinkWrap: true,
                  ),
                ],
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
