import 'package:flutter/material.dart';
import 'package:ithub_quiz/utils/app_logger.dart';

class AnswerRow extends StatefulWidget {
  final int index;
  final ValueChanged<int> onDelete;
  final Function(int) isChecked;
  final Function(TextEditingController) onControllerChanged;
  const AnswerRow({
    Key? key,
    required this.index,
    required this.onDelete,
    required this.isChecked,
    required this.onControllerChanged,
  }) : super(key: key);

  @override
  State<AnswerRow> createState() => _AnswerRowState();
}

class _AnswerRowState extends State<AnswerRow> {
  int? selectedOption;

  TextEditingController textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Radio(
          value: widget.index,
          groupValue: selectedOption,
          activeColor: Colors.blue,
          onChanged: (selectedValue) {
            setState(() {
              selectedOption = selectedValue;
            });
            widget.isChecked(selectedOption!);
            logger.e(widget.index);
            logger.e('selected option $selectedOption');
          },
        ),
        const SizedBox(width: 5),
        Expanded(
          flex: 3,
          child: TextFormField(
            maxLines: 3,
            minLines: 1,
            controller: textFieldController,
            decoration: const InputDecoration(
              labelText: 'Enter some text',
              border: OutlineInputBorder(),
            ),
            onChanged: ((value) {
              if (textFieldController.text.isNotEmpty) {
                widget.onControllerChanged(textFieldController);
              }
            }),
          ),
        ),
      ],
    );
  }
}
