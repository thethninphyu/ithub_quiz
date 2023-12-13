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
  String? _groupValues;

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
                  'Error occurred in retrieving data from Firestore');
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
                                                    ),
                                                    activeColor: Colors.green,
                                                    value: '$index$answerIndex',
                                                    groupValue: _groupValues,
                                                    onChanged: (selectedValue) {
                                                      // logger.e(
                                                      //     'Group Value is  $selectedValue');

                                                      setState(() {
                                                        _groupValues =
                                                            selectedValue;

                                                        bool isChecked =
                                                            questionAndAnswer[index]
                                                                            [
                                                                            'questionsAndAnswers']
                                                                        [
                                                                        'answers']
                                                                    [
                                                                    answerIndex]
                                                                ['isChecked'];

                                                        logger.e(
                                                            'Correct Answers is $isChecked');
                                                      });
                                                    },
                                                    tileColor: _groupValues != null &&
                                                            questionAndAnswer[index]
                                                                        ['questionsAndAnswers'][
                                                                    'answers'] !=
                                                                null &&
                                                            answerIndex <
                                                                questionAndAnswer[index]['questionsAndAnswers']['answers']
                                                                    .length &&
                                                            _groupValues ==
                                                                '$index$answerIndex' &&
                                                            questionAndAnswer[index]
                                                                            ['questionsAndAnswers']
                                                                        ['answers']
                                                                    [answerIndex]
                                                                ['isChecked']
                                                        ? Colors.green
                                                        : (_groupValues == '$index$answerIndex' &&
                                                                questionAndAnswer[index]['questionsAndAnswers']['answers'][answerIndex]['isChecked'] !=
                                                                    null &&
                                                                !questionAndAnswer[index]
                                                                            ['questionsAndAnswers']
                                                                        ['answers'][answerIndex]
                                                                    ['isChecked'])
                                                            ? Colors.red[900]
                                                            : null,
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
                          onPressed: () {},
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
