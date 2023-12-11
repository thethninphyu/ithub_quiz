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
  List<Answer> answerDataList = [];
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
        isChecked: checkFun,
        answerController: answerController,
      );
      answerRows.add(newAnswerRow);
    });
  }

  void sendListToFirebase(List<Answer> answerDataList) async {
    FirebaseFirestore.instance.collection('languages').doc(languages.id);
    CollectionReference myObjects =
        FirebaseFirestore.instance.collection('answers');

    // Convert each MyObject to a map and add it to the Firestore collection
    for (Answer answer in answerDataList) {
      await myObjects.add(answer.toJson());
    }
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
                  // Display existing AnswerRows
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: answerRows.length,
                    itemBuilder: (context, index) {
                      return AnswerRow(
                        index: index,
                        onDelete: _removeAnswerRow,
                        isChecked: checkFun,
                        answerController: answerController,
                      );
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
                          sendListToFirebase(answerDataList);
                          logger.e(isChecked);
                          logger.e(answerController.text);

                          answerDataList.add(Answer(
                              isChecked, answerController.text.toString()));
                          logger.e(answerDataList.map((e) => e.toJson()));
                          if (_formKey.currentState!.validate()) {
                            EasyLoading.show(
                              status: 'Loading...',
                              maskType: EasyLoadingMaskType.black,
                            );

                            // Build the question document
                            Map<String, dynamic> questionData = {
                              'question': question.text,
                              'answers': answerDataList,
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
                                .then((_) => EasyLoading.dismiss())
                                .catchError((error) => {
                                      EasyLoading.dismiss(),
                                      // AppStrings.logger.e(
                                      //     "Error uploading to firestore : $error"),
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
      // AppStrings.logger.e('Invalid arguments type');
      return const Scaffold();
    }
  }
}
