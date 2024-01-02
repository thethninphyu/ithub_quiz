import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuizAnswerScreen extends StatefulWidget {
  const QuizAnswerScreen({Key? key}) : super(key: key);

  @override
  State<QuizAnswerScreen> createState() => _QuizAnswerScreenState();
}

class _QuizAnswerScreenState extends State<QuizAnswerScreen> {
  List<String?> groupValues = [];


  late Timer _timer;
  int _timerDuration = 30;
  late dynamic questionAndAnswer;

  @override
  void initState() {
    super.initState();
     startTimer();
    _loadNextQuestion();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  int _currentQuestionIndex = 0;

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
          questionAndAnswer = snapshot.data()!['questionsAndAnswers'];
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
// final arguments = ModalRoute.of(context)!.settings.arguments;


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
                ListTile(
                  title: Text(
                    'Q. ${questionAndAnswer['question']}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (questionAndAnswer.containsKey('answers') &&
                    questionAndAnswer['answers'] is List<dynamic>)
                  Column(
                    children: [
                      for (var answerIndex = 0;
                          answerIndex < questionAndAnswer['answers'].length;
                          answerIndex++)
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            bottom: 5,
                          ),
                          child: Row(
                            children: [
                              Text(
                                '${answerIndex + 1}. ',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: RadioListTile(
                                  key: Key(
                                      '$answerIndex$_currentQuestionIndex'),
                                  title: Text(
                                    questionAndAnswer['answers'][answerIndex]
                                            ['answer']
                                        .toString(),
                                    style: TextStyle(
                                      color: groupValues.length > 0 &&
                                              groupValues[0] ==
                                                  '$answerIndex$_currentQuestionIndex'
                                          ? Colors.blue
                                          : Colors.black,
                                    ),
                                  ),
                                  activeColor: groupValues.length > 0 &&
                                          groupValues[0] ==
                                              '$answerIndex$_currentQuestionIndex'
                                      ? Colors.blue
                                      : Colors.grey,
                                  value:
                                      '$answerIndex$_currentQuestionIndex',
                                  groupValue: groupValues.length > 0
                                      ? groupValues[0]
                                      : null,
                                  onChanged: (selectedValue) {
                                    setState(() {
                                      groupValues = [selectedValue!];
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                const Divider(
                  height: 1,
                  color: Colors.black12,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      child: const Text('Next Question'),
                      onPressed: () {
                        _timer.cancel();
                        _timerDuration = 30;
                        _currentQuestionIndex++;
                        _loadNextQuestion();
                      },
                    ),
                  ),
                ),
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
