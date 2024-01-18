import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ithub_quiz/ui/admin_screen/model/language_type.dart';
import 'package:ithub_quiz/ui/admin_screen/model/snapShotData.dart';

import 'package:ithub_quiz/utils/app_logger.dart';

class QuizAnswerScreen extends StatefulWidget {
  const QuizAnswerScreen({Key? key}) : super(key: key);

  @override
  State<QuizAnswerScreen> createState() => _QuizAnswerScreenState();
}

class _QuizAnswerScreenState extends State<QuizAnswerScreen> {
  List<String?> groupValues = [];
  late dynamic argument;

  late Timer _timer;
  int _timerDuration = 30;
  dynamic questionAndAnswer;

  @override
  void initState() {
    super.initState();

    _retreveDataFromFirestore();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  int _currentQuestionIndex = 0;

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

              // logger.e('Que and Ans $questionAndAnswer');
              logger.e(questionAndAnswer?[0]['questionsAndAnswers']['answers']
                  .length);
              // logger.e('${snapshot.data()?['questionAndAnswer']}');
            });
            //  startTimer();
          } else {
            setState(() {
              questionAndAnswer = null;
              logger.e('Not exit snapshot');
            });
          }
        });
      } else {
        logger.e('Error');
      }
    });
  }

  void _loadNextQuestion() {
    _timer.cancel();
    _timerDuration = 30;
    groupValues.clear();
    FirebaseFirestore.instance
        .collection('languages')
        .doc()
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        setState(() {
          questionAndAnswer = snapshot.data()!['questionAndAnswer'];
          // logger.e('que $questionAndAnswer');
        });
        startTimer();
      } else {
        setState(() {
          questionAndAnswer = null;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz')),
      body: questionAndAnswer != null
          ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Time Remaining: $_timerDuration seconds',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: questionAndAnswer.length,
                      itemBuilder: (context, index) {
                        return Text(
                          'Q. ${questionAndAnswer?[index]['questionsAndAnswers']['question']}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }),
                )

                // ListTile(
                //   title: Text(
                //     'Ans. ${questionAndAnswer?[0]['questionsAndAnswers']['answers'][0]['answer']}',
                //     style: const TextStyle(
                //       fontSize: 18,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
              ],
            )
          : const Center(
              child: Text('No more questions.'),
            ),
    );
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timerDuration > 0) {
          _timerDuration--;
        } else {
          timer.cancel();
          _currentQuestionIndex++;
          _loadNextQuestion();
        }
      });
    });
  }
}
