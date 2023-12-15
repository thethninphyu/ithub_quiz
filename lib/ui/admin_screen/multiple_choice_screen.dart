import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ithub_quiz/ui/admin_screen/model/language_type.dart';
import 'package:ithub_quiz/utils/app_logger.dart';

class MultipleChoiceScreen extends StatefulWidget {
  const MultipleChoiceScreen({Key? key}) : super(key: key);

  @override
  State<MultipleChoiceScreen> createState() => _MultipleChoiceScreenState();
}

class _MultipleChoiceScreenState extends State<MultipleChoiceScreen> {
  List<String?> _groupValues = [];
  List<int?> _selectedAsnwer = [];
  int count = 0;

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;

    if (arguments is Languages) {
      final Languages languages = arguments;

      return Scaffold(
        appBar: AppBar(title: Text('Multiple Choice - ${languages.langType}')),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('languages')
              .doc(languages.id)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text(
                'Error occurred in retrieving data from Firestore',
              );
            } else if (snapshot.hasData && snapshot.data!.exists) {
              final doc =
                  snapshot.data as DocumentSnapshot<Map<String, dynamic>>;

              if (doc.data()!.containsKey('questionAndAnswer')) {
                final questionAndAnswer = doc['questionAndAnswer'];

                return Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            for (var index = 0;
                                index < questionAndAnswer.length;
                                index++)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    title: Row(
                                      children: [
                                        const Text(
                                          'Q. ',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            questionAndAnswer[index]
                                                        ['questionsAndAnswers']
                                                    ['question']
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (questionAndAnswer[index]
                                          ['questionsAndAnswers']['answers'] !=
                                      null)
                                    Column(
                                      children: [
                                        for (var answerIndex = 0;
                                            answerIndex <
                                                questionAndAnswer[index][
                                                            'questionsAndAnswers']
                                                        ['answers']
                                                    .length;
                                            answerIndex++)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, bottom: 5),
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
                                                        '$index$answerIndex'),
                                                    title: Text(
                                                      questionAndAnswer[index][
                                                                      'questionsAndAnswers']
                                                                  ['answers'][
                                                              answerIndex]['answer']
                                                          .toString(),
                                                      style: TextStyle(
                                                        color: _groupValues
                                                                        .length >
                                                                    index &&
                                                                _groupValues[
                                                                        index] ==
                                                                    '$index$answerIndex'
                                                            ? Colors.blue
                                                            : Colors.black,
                                                      ),
                                                    ),
                                                    activeColor: _groupValues
                                                                    .length >
                                                                index &&
                                                            _groupValues[
                                                                    index] ==
                                                                '$index$answerIndex'
                                                        ? Colors.blue
                                                        : Colors.grey,
                                                    value: '$index$answerIndex',
                                                    groupValue: _groupValues
                                                                .length >
                                                            index
                                                        ? _groupValues[index]
                                                        : null,
                                                    onChanged: (selectedValue) {
                                                      setState(() {
                                                        bool isChecked =
                                                            questionAndAnswer[index]
                                                                            [
                                                                            'questionsAndAnswers']
                                                                        [
                                                                        'answers']
                                                                    [
                                                                    answerIndex]
                                                                ['isChecked'];

                                                        if (_groupValues
                                                                .length >
                                                            index) {
                                                          _groupValues[index] =
                                                              selectedValue!;

                                                         if(isChecked){
                                                         
                                                            _selectedAsnwer[
                                                                answerIndex] = 1;
                                                          } else {
                                                            _selectedAsnwer[
                                                                answerIndex] = 0;
                                                          }

                                                          logger.e(
                                                              'Updated index $_selectedAsnwer');
                                                        } else {
                                                          _groupValues.add(
                                                              selectedValue!);

                                                          if (isChecked) {
                                                            _selectedAsnwer
                                                                .add(1);
                                                          } else {
                                                            count = 0;
                                                            _selectedAsnwer
                                                                .add(count);
                                                          }

                                                          logger.e(
                                                              "Selected Answer list is $_selectedAsnwer");
                                                        }
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
                                      height: 1, color: Colors.black12),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          child: const Text('Submit'),
                          onPressed: () {
                            int totalQuestions = questionAndAnswer.length;
                            int countOfOnes = _selectedAsnwer
                                .where((value) => value == 1)
                                .length;

                            logger.e('length of One $countOfOnes');
                            double result =
                                (countOfOnes / totalQuestions) * 100;
                            if (result > 40) {
                              logger.e("Total result is $result");
                            } else {
                              logger.e("Total result is $result");
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Text(
                    'No Data for ${languages.langType}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                );
              }
            } else {
              return const Center(child: Text('Document does not exist'));
            }
          },
        ),
      );
    } else {
      return const Scaffold();
    }
  }
}
