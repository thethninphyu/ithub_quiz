import 'package:flutter/material.dart';
import 'package:ithub_quiz/ui/admin_screen/module/question_create/validation/validation.dart';

class AnswerRow extends StatefulWidget {
  final int index;
  final ValueChanged<int> onDelete;
  final Function(bool) isChecked;
  final TextEditingController answerController;

  const AnswerRow(
      {Key? key,
      required this.index,
      required this.onDelete,
      required this.isChecked,
      required this.answerController})
      : super(key: key);

  @override
  State<AnswerRow> createState() => _AnswerRowState();
}

class _AnswerRowState extends State<AnswerRow> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: SizedBox(
            child: Checkbox(
              value: isChecked,
              onChanged: (value) {
                setState(() {
                  isChecked = value!;
                  widget.isChecked(isChecked);
                });
              },
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: TextFormField(
            controller: widget.answerController,
            validator: FormValidator.validateName,
            maxLines: 3,
            minLines: 1,
            decoration: const InputDecoration(
              hintText: 'Ans',
            ),
          ),
        ),
        Flexible(
          child: IconButton(
            icon: const Icon(Icons.remove_circle),
            onPressed: () {
              widget.onDelete(widget.index);
            },
          ),
        ),
      ],
    );
  }
}
