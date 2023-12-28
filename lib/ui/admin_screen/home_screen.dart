import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ithub_quiz/constants/colors.dart';
import 'package:ithub_quiz/ui/admin_screen/model/language_type.dart';
import 'package:ithub_quiz/ui/admin_screen/module/choice-module.dart';
import 'package:ithub_quiz/ui/admin_screen/module/choice_route.dart';
import 'package:ithub_quiz/ui/admin_screen/module/question_create/create_question_module.dart';
import 'package:ithub_quiz/ui/admin_screen/module/question_create/create_question_route.dart';
import 'package:ithub_quiz/ui/auth/auth_firestorage.dart';
import 'package:ithub_quiz/utils/app_router.dart';
import 'package:ithub_quiz/utils/share_util.dart';

class HomeScreen extends StatefulWidget {
  final String status;
  const HomeScreen({Key? key, required this.status}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var width, height;
  String userRole = '';
  List<String> imagePaths = ['flutter.png', 'js.png', 'kotlin.jpg'];

  @override
  void initState() {
    retrieveUserRole();

    super.initState();
  }

  Future<void> retrieveUserRole() async {
    final role = await StoreUserData().getRole();
    setState(() {
      userRole = role ?? '';
    });
  }

  Widget getDashboardWidget() {
    if (widget.status == "home") {
      return Container(
        decoration: const BoxDecoration(color: AppColors.secondaryColor),
        height: height * 0.25,
        width: width,
        child: const Padding(
          padding: EdgeInsets.only(top: 50, left: 15, right: 15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
      );
    } else {
      return const SizedBox();
    }
  }

  PreferredSizeWidget? getAppBar() {
    if (widget.status == 'createQuestion') {
      return AppBar(
        title: const Text(
          'Create Question Screen',
        ),
        automaticallyImplyLeading: false,
      );
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(

        appBar: getAppBar(),
        body: Container(
            color: widget.status == "home"? AppColors.secondaryColor : AppColors.primaryColor ,
            child: Column(
              children: [
                getDashboardWidget(),
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
                                        if (widget.status == "home") {
                                          userRole == 'Admin'
                                              ? AppRouter.changeRoute<
                                                      ChoiceFormModule>(
                                                  ChoiceRoute.multiChoice,
                                                  context: context,
                                                  args: Languages(
                                                      id: documentId,
                                                      langType:
                                                          data['lang-type']))
                                              : AppRouter.changeRoute<
                                                      ChoiceFormModule>(
                                                  ChoiceRoute.quizAns,
                                                  context: context,
                                                  args: Languages(
                                                      id: documentId,
                                                      langType:
                                                          data['lang-type']));
                                        } else {
                                          AppRouter.changeRoute<
                                                  CreateQuestionModule>(
                                              CreateQuestionRoutes.question,
                                              context: context,
                                              args: Languages(
                                                  id: documentId,
                                                  langType: data['lang-type']));
                                        }
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  data['lang-type'] ?? '',
                                                  style: const TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                FutureBuilder(
                                                    future: AuthFireStorage()
                                                        .getImages(imagePaths),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .waiting) {
                                                        return const CircularProgressIndicator();
                                                      } else if (snapshot
                                                          .hasError) {
                                                        return Text(
                                                            'Error loading image :${snapshot.error}');
                                                      } else {
                                                        List<String?>?
                                                            imageUrl =
                                                            snapshot.data;

                                                        return Image.network(
                                                          imageUrl![index]!,
                                                          fit: BoxFit.contain,
                                                          height: 80,
                                                        );
                                                      }
                                                    })
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
