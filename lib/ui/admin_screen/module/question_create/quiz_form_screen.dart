import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ithub_quiz/ui/admin_screen/model/answer.dart';
import 'package:ithub_quiz/ui/admin_screen/model/language_type.dart';
import 'package:ithub_quiz/ui/admin_screen/module/question_create/answer_row_widget.dart';
import 'package:ithub_quiz/ui/admin_screen/module/question_create/validation/validation.dart';
import 'package:ithub_quiz/utils/app_logger.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  TextEditingController question = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<AnswerRow> answerRows = [];
  List<Answer> answerList = [];

  TextEditingController answerController = TextEditingController();

  bool isChecked = false;

  checkFun(bool check) {
    isChecked = check;
  }

  void _removeAnswerRow(int index) {
    setState(() {
      answerRows.removeAt(index);
    });
  }

  void _addAnswerRow() {
    setState(() {
      int newIndex = answerRows.length;
      AnswerRow newAnswerRow = AnswerRow(
        index: newIndex,
        onDelete: _removeAnswerRow,
        isChecked: (check) {
          check == 1 ? isChecked = true : isChecked = false;
          // logger.e('isChecked :$value');
        },
        onControllerChanged: (controller) {
          logger.e(controller);
          //_updateAnswerDataList(newIndex, controller.text);
        },
        answerDataList: (answerDataList) {
          answerDataList.add(answerDataList);
          answerList = answerDataList;
        },
      );
      answerRows.add(newAnswerRow);
    });
  }

  // void _updateAnswerDataList(int index, String newText) {
  //   setState(() {
  //     if (index < answerList.length) {
  //       answerList[index] = Answer(isChecked, newText);
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;

    if (arguments is Languages) {
      final Languages languages = arguments;

      return Scaffold(
        appBar: AppBar(
          title: Text('Quiz Form - ${languages.langType}'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Question:"),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: question,
                    validator: FormValidator.validateName,
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Create Question',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text('Answers:'),
                  const SizedBox(
                    height: 16,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: answerRows.length,
                    itemBuilder: (context, index) {
                      return answerRows[index];
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton.icon(
                      onPressed: _addAnswerRow,
                      icon: const Icon(Icons.add),
                      label: const Text('Add More'),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            EasyLoading.show(
                              status: 'Loading...',
                              maskType: EasyLoadingMaskType.black,
                            );

                            // Build the question document
                            Map<String, dynamic> questionData = {
                              'question': question.text,
                              'answers': answerList
                                  .map((answer) => answer.toJson())
                                  .toList(),
                            };

                            // logger.e(
                            //     "Answer Data List ${answerDataList.map((answer) => answer.toJson()).toList()}");

                            FirebaseFirestore.instance
                                .collection('languages')
                                .doc(languages.id)
                                .update({
                                  'questionAndAnswer': FieldValue.arrayUnion([
                                    {
                                      'questionsAndAnswers': questionData,
                                    }
                                  ])
                                })
                                .then((_) => EasyLoading.dismiss())
                                .catchError((error) => {
                                      EasyLoading.dismiss(),
                                    });
                          }
                        },
                        child: const Text('Upload'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return const Scaffold();
    }
  }
}
