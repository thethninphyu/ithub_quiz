import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
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

  late Timer _timer;
  int _timerDuration = 10;
  dynamic questionAndAnswer;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Quiz')),
        body: questionAndAnswer != null
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
                                InkWell(
                                  onTap: () {
                                    if (qusIndex ==
                                        questionAndAnswer.length - 1) {
                                      showDialog(
                                        context: context,
                                        builder: ((context) {
                                          return Dialog(
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                gradient: LinearGradient(
                                                  colors: [
                                                    const Color(0xFFE64978),
                                                    const Color(0xFFed8c41)
                                                        .withOpacity(0.5),
                                                    Colors.white
                                                        .withOpacity(0.1),
                                                    Colors.white,
                                                  ],
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                      );
                                    } else {
                                      _pageController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.easeInOut,
                                      );
                                    }
                                  },
                                  child: TextButton(
                                    onPressed: () {
                                      var isCorrect =
                                          answers?[ansIndex]['isChecked'];

                                      if (isCorrect == false) {
                                        DialogUtils.createConfirmationDialog(
                                          context: context,
                                          title: 'Incorrect Answer',
                                          dialogType: DialogType.warning,
                                          description:
                                              'Sorry, your answer is incorrect.',
                                          onOkPressed: () {},
                                          width: double.infinity,
                                        ).show();
                                      }

                                      _answerAnimationController.forward(
                                          from: 0.0);

                                      _loadNextQuestion();
                                    },
                                    child: Card(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: AnimatedBuilder(
                                            animation:
                                                _answerAnimationController,
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
            : const Center(
                child: Text('No more question'),
              ));
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
