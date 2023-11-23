import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ithub_quiz/ui/admin_screen/module/question_create/validation/answer_row_widget.dart';
import 'package:ithub_quiz/ui/admin_screen/module/question_create/validation/common.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  TextEditingController question = TextEditingController();
  final _formKey = GlobalKey<FormState>();

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QuizQuestionCreationForm'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Question:"),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                      controller: question,
                      validator: FormValidator.validation,
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Create Question',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      )),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text('Answers:'),
                  const SizedBox(
                    height: 16,
                  ),
                  const AnswerRow(),
                  const AnswerRow(),
                  const AnswerRow(),
                  const AnswerRow(),
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
                                  maskType: EasyLoadingMaskType.black);
                            }
                          },
                          child: const Text('Upload')),
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
