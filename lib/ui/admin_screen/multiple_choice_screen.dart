import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ithub_quiz/ui/admin_screen/dialog_util.dart';
import 'package:ithub_quiz/ui/admin_screen/model/language_type.dart';

class MultipleChoiceScreen extends StatefulWidget {
  const MultipleChoiceScreen({Key? key}) : super(key: key);

  @override
  State<MultipleChoiceScreen> createState() => _MultipleChoiceScreenState();
}

class _MultipleChoiceScreenState extends State<MultipleChoiceScreen> {
  List<String?> groupValues = [];
  List<int?> selectedAsnwer = [];

  late dynamic questionAndAnswer = [];

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
                questionAndAnswer = doc['questionAndAnswer'];

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
                                                        color: groupValues
                                                                        .length >
                                                                    index &&
                                                                groupValues[
                                                                        index] ==
                                                                    '$index$answerIndex'
                                                            ? Colors.blue
                                                            : Colors.black,
                                                      ),
                                                    ),
                                                    activeColor: groupValues
                                                                    .length >
                                                                index &&
                                                            groupValues[
                                                                    index] ==
                                                                '$index$answerIndex'
                                                        ? Colors.blue
                                                        : Colors.grey,
                                                    value: '$index$answerIndex',
                                                    groupValue: groupValues
                                                                .length >
                                                            index
                                                        ? groupValues[index]
                                                        : null,
                                                    onChanged: (selectedValue) {
                                                      setState(() {
                                                        // logger.e(
                                                        //     'Value change $selectedValue');
                                                        bool isChecked =
                                                            questionAndAnswer[index]
                                                                            [
                                                                            'questionsAndAnswers']
                                                                        [
                                                                        'answers']
                                                                    [
                                                                    answerIndex]
                                                                ['isChecked'];

                                                        if (groupValues
                                                                .length >
                                                            index) {
                                                          groupValues[index] =
                                                              selectedValue!;

                                                          if (isChecked) {
                                                            selectedAsnwer[
                                                                index] = 1;
                                                          } else {
                                                            selectedAsnwer[
                                                                index] = 0;
                                                          }
                                                        } else {
                                                          groupValues.add(
                                                              selectedValue!);

                                                          if (isChecked) {
                                                           selectedAsnwer
                                                                .add(1);
                                                          } else {
                                                            selectedAsnwer
                                                                .add(0);
                                                          }
                                                        }

                                                        // logger.e(
                                                        //     "Selected Answer list is $_selectedAsnwer");
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
                            calculateResult();
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
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      );
    } else {
      return const Scaffold();
    }
  }

  void calculateResult() {
    int totalQuestions = questionAndAnswer.length;
    int countOfOnes = selectedAsnwer.where((value) => value == 1).length;

    if (selectedAsnwer.length < totalQuestions) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please answer all questions before submitting.'),
        ),
      );
      return;
    }

    double result = (countOfOnes / totalQuestions) * 100;
    if (result < 40) {
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
    } else if (result >= 40 && result < 80) {
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
    } else {
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
    }
  }
}
