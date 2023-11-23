import 'package:flutter/material.dart';
import 'package:ithub_quiz/ui/admin_screen/module/question_create/validation/common.dart';

class AnswerRow extends StatefulWidget {
  const AnswerRow({super.key});

  @override
  State<AnswerRow> createState() => _AnswerRowState();
}

class _AnswerRowState extends State<AnswerRow> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            flex: 1,
            child: SizedBox(
              child: Checkbox(
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              ),
            )),
        Expanded(
            flex: 3,
            child: TextFormField(
              validator: FormValidator.validation,
              maxLines: 3,
              minLines: 1,
              decoration: const InputDecoration(
                hintText: 'Ans',
              ),
            ))
      ],
    );
  }
}
