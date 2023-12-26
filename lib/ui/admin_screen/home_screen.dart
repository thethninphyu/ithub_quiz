import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ithub_quiz/constants/colors.dart';
import 'package:ithub_quiz/ui/admin_screen/model/language_type.dart';
import 'package:ithub_quiz/ui/admin_screen/module/choice-module.dart';
import 'package:ithub_quiz/ui/admin_screen/module/choice_route.dart';
import 'package:ithub_quiz/utils/app_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var width, height;

  List imgSrc = [
    "assets/flutter.png",
    "assets/js.png",
    "assets/kotlin.jpg",
    "assets/php.jpg"
  ];
  List title = ["Flutter", "Node Js", "Kotlin", "PhP"];

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
            color: AppColors.secondaryColor,
            child: Column(
              children: [
                Container(
                  decoration:
                      const BoxDecoration(color: AppColors.secondaryColor),
                  height: height * 0.25,
                  width: width,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 50, left: 15, right: 15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
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
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: Container(
                    width: width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('languages')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            if (!snapshot.hasData) {
                              return const Text(
                                  'Error occur in retrieving data');
                            } else {
                              return const CircularProgressIndicator();
                            }
                          }

                          if (snapshot.hasData) {
                            final doc = snapshot.data!.docs;

                            return SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(children: [
                                GridView.builder(
                                  itemBuilder: (context, index) {
                                    final data = doc[index].data();
                                    String documentId = doc[index].id;

                                    return InkWell(
                                      onTap: () {
                                        AppRouter.changeRoute<ChoiceFormModule>(
                                            ChoiceRoute.multiChoice,
                                            context: context,
                                            args: Languages(
                                                id: documentId,
                                                langType: data['lang-type']));
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 20),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 0.6, color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: AppColors.primaryColor,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  offset: const Offset(0, 7),
                                                  blurRadius: 0.3,
                                                  spreadRadius: -2)
                                            ]),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  data['lang-type'] ?? '',
                                                  style: const TextStyle(
                                                      color: Colors.amber,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ]),
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: doc.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 1.1,
                                          mainAxisSpacing: 25),
                                  shrinkWrap: true,
                                )
                              ]),
                            );
                          }
                          return const Center(
                              child: CircularProgressIndicator());
                        }),
                  ),
                ),
              ],
            )));
  }
}
