import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ithub_quiz/ui/admin_screen/model/answer.dart';
import 'package:ithub_quiz/ui/admin_screen/model/language_type.dart';
import 'package:ithub_quiz/ui/admin_screen/module/question_create/answer_row_widget.dart';
import 'package:ithub_quiz/ui/admin_screen/module/question_create/validation/validation.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  TextEditingController question = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<AnswerRow> answerRows = [];
  List<Answer> answerDataList = [];
  TextEditingController answerController = TextEditingController();

  void _removeAnswerRow(int index) {
    setState(() {
      answerRows.removeAt(index);
    });
  }

  void _addAnswerRow() {
    setState(() {
      int newIndex = answerRows.length;
      bool isLocalChecked = false;

      AnswerRow newAnswerRow = AnswerRow(
        index: newIndex,
        onDelete: _removeAnswerRow,
        onAnswerChanged: (isChecked, newAnswer) {
          _updateAnswerDataList(newIndex, newAnswer, isChecked);
        },
      );

      answerDataList
          .add(Answer(isLocalChecked, answerController.text.toString()));

      answerRows.add(newAnswerRow);
    });
  }

  void _updateAnswerDataList(int index, String newText, bool isChecked) {
    setState(() {
      if (index < answerDataList.length) {
        answerDataList[index] = Answer(isChecked, newText);
      }
    });
  }

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
                            if (answerDataList.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('Please add at least one answer.'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            } else {
                              EasyLoading.show(
                                status: 'Loading...',
                                maskType: EasyLoadingMaskType.black,
                              );
                              // Build the question document
                              Map<String, dynamic> questionData = {
                                'question': question.text,
                                'answers': answerDataList
                                    .map((answer) => answer.toJson())
                                    .toList(),
                              };
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
                                  .then((_) => {
                                        EasyLoading.dismiss(),
                                        Navigator.pop(context)
                                      })
                                  .catchError((error) => {
                                        EasyLoading.dismiss(),
                                      });
                            }
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
