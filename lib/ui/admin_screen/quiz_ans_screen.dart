import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ithub_quiz/ui/admin_screen/dialog_util.dart';
import 'package:ithub_quiz/utils/app_logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ithub_quiz/ui/admin_screen/model/snapShotData.dart';

class QuizAnswerScreen extends StatefulWidget {
  const QuizAnswerScreen({Key? key}) : super(key: key);

  @override
  State<QuizAnswerScreen> createState() => _QuizAnswerScreenState();
}

class _QuizAnswerScreenState extends State<QuizAnswerScreen>
    with SingleTickerProviderStateMixin {
  List<String?> groupValues = [];
  late dynamic argument;
  final PageController _pageController = PageController();

  late AnimationController _answerAnimationController;
  late Animation<double> answerOpacityAnimation;
  var finalBool = false;

  late Timer _timer;
  int _timerDuration = 10;
  dynamic questionAndAnswer;
  List<int> selectedAnswer = [];

  @override
  void initState() {
    super.initState();
    _answerAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    answerOpacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _answerAnimationController, curve: Curves.easeIn));
    _retreveDataFromFirestore();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _retreveDataFromFirestore() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      argument = ModalRoute.of(context)!.settings.arguments;
      if (argument is SnapShotDataQue) {
        FirebaseFirestore.instance
            .collection('languages')
            .doc(argument.id)
            .get()
            .then((snapshot) {
          if (snapshot.exists) {
            setState(() {
              questionAndAnswer = snapshot.data()!['questionAndAnswer'];
            });
          } else {
            setState(() {
              questionAndAnswer = null;
              // logger.e('Not exit snapshot');
            });
          }
        });
        _answerAnimationController.forward(from: 0.0);
      } else {
        logger.e('Error');
      }
    });
  }

  void _loadNextQuestion() {
    _timer.cancel();
    _timerDuration = 10;
    groupValues.clear();
    if (_pageController.page! < questionAndAnswer.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      _answerAnimationController.forward(from: 0.0);
    } else {
      setState(() {
        questionAndAnswer = null;
      });
    }

    startTimer();
  }

  void calculateResult() {
    int totalQuestions = questionAndAnswer.length;
    int countOfOnes = selectedAnswer.where((value) => value == 1).length;
    logger.e(selectedAnswer.toList());
    // Do something with the totalScore, such as displaying it or storing it.

    // if (selectedAnswer.length < totalQuestions) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text('Please answer all questions before submitting.'),
    //     ),
    //   );
    //   return;
    // }

    logger.e('Total Score: $countOfOnes');
    double result = (countOfOnes / totalQuestions) * 100;
    if (result < 0) {
      Future.delayed(const Duration(milliseconds: 4000), () {
        DialogUtils.createConfirmationDialog(
            context: context,
            title: 'Fail',
            width: MediaQuery.of(context).size.width / 1.2 * 2,
            dialogType: DialogType.warning,
            description: 'Quiz result is $result',
            showCancelButton: false,
            onOkPressed: () {
              Modular.to.pop();
            }).show();
      });
    } else if (result >= 40 && result < 80) {
      Future.delayed(const Duration(milliseconds: 4000), () {
        DialogUtils.createConfirmationDialog(
            context: context,
            title: 'Pass',
            width: MediaQuery.of(context).size.width / 1.2 * 2,
            dialogType: DialogType.success,
            description: 'Quiz result is $result',
            showCancelButton: false,
            onOkPressed: () {
              Modular.to.pop();
            }).show();
      });
    } else {
      Future.delayed(const Duration(milliseconds: 4000), () {
        DialogUtils.createConfirmationDialog(
            context: context,
            title: 'Distinction',
            width: MediaQuery.of(context).size.width / 1.2 * 2,
            dialogType: DialogType.success,
            showCancelButton: false,
            description: 'Quiz result is $result',
            onOkPressed: () {
              Modular.to.pop();
            }).show();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Quiz')),
        body: questionAndAnswer != null && finalBool == false
            ? PageView.builder(
                scrollDirection: Axis.vertical,
                controller: _pageController,
                itemCount: questionAndAnswer.length,
                itemBuilder: (context, qusIndex) {
                  var question = questionAndAnswer?[qusIndex]
                      ['questionsAndAnswers']['question'];
                  var answers = questionAndAnswer?[qusIndex]
                      ['questionsAndAnswers']['answers'];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Time Reamaining: $_timerDuration seconds',
                          style: const TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'Q. $question',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: answers?.length ?? 0,
                          itemBuilder: (context, ansIndex) {
                            var answer = answers?[ansIndex]['answer'];

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    logger.e(
                                        "HEYYYY${answers?[ansIndex]['isChecked']}");
                                    var isCorrect =
                                        answers?[ansIndex]['isChecked'];
                                    if (qusIndex ==
                                        questionAndAnswer.length - 1) {
                                      Future.delayed(
                                          const Duration(milliseconds: 1000),
                                          () {
                                        if (isCorrect == false) {
                                          logger.e("iamWrongAnswer");
                                          EasyLoading.showError(
                                              "Incorrect Answer",
                                              duration: const Duration(
                                                  milliseconds: 3000),
                                              dismissOnTap: true);
                                          selectedAnswer.add(0);
                                          _timer.cancel();
                                        } else {
                                          EasyLoading.showSuccess(
                                              "Correct Answer",
                                              duration: const Duration(
                                                  milliseconds: 3000),
                                              dismissOnTap: true);
                                          selectedAnswer.add(1);
                                          _timer.cancel();
                                        }
                                        calculateResult();
                                      });
                                    } else {
                                      if (isCorrect == false) {
                                        logger.e("iamWrongAnswer");
                                        EasyLoading.showError(
                                            "Incorrect Answer",
                                            duration: const Duration(
                                                milliseconds: 3000),
                                            dismissOnTap: true);
                                        selectedAnswer.add(0);
                                      } else {
                                        EasyLoading.showSuccess(
                                            "Correct Answer",
                                            duration: const Duration(
                                                milliseconds: 3000),
                                            dismissOnTap: true);
                                        selectedAnswer.add(1);
                                      }

                                      _answerAnimationController.forward(
                                          from: 0.0);

                                      Future.delayed(
                                          const Duration(milliseconds: 3000),
                                          () {
                                        _loadNextQuestion();
                                      });
                                    }
                                  },
                                  child: Card(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: AnimatedBuilder(
                                          animation: _answerAnimationController,
                                          builder: (context, child) {
                                            return Opacity(
                                              opacity:
                                                  _answerAnimationController
                                                      .value,
                                              child: Text(
                                                '$answer',
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              )
            : const Center(child: Text("There is no data")));
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timerDuration > 0) {
          _timerDuration--;
        } else {
          timer.cancel();

          _loadNextQuestion();
        }
      });
    });
  }
}
