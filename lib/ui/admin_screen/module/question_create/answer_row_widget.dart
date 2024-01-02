import 'package:flutter/material.dart';
import 'package:ithub_quiz/ui/admin_screen/model/answer.dart';
import 'package:ithub_quiz/utils/app_logger.dart';

class AnswerRow extends StatefulWidget {
  final int index;
  final ValueChanged<int> onDelete;
  final Function(int) isChecked;
  final Function(List<Answer>) answerDataList;
  final Function(TextEditingController) onControllerChanged;
  const AnswerRow({
    Key? key,
    required this.index,
    required this.onDelete,
    required this.isChecked,
    required this.answerDataList,
    required this.onControllerChanged,
  }) : super(key: key);

  @override
  State<AnswerRow> createState() => _AnswerRowState();
}

class _AnswerRowState extends State<AnswerRow> {
  int selectedOption = 0;
  List<Answer> temporaryList = [];
  AnswerList thisisForClass = AnswerList(Answer(false, ""));
  TextEditingController textFieldController = TextEditingController();

  void _addAnswerRow(int isChecked, String answer) {
    bool answerCheck = false;
    logger.e(Answer(answerCheck, answer).toJson());
    temporaryList.add(Answer(answerCheck, answer));

    logger.e('Tempory radio value is  $isChecked and text is $answer');
    isChecked == 1 ? answerCheck = true : answerCheck = false;
    widget.answerDataList(temporaryList);
    final List<Map<String, dynamic>> tempListJson =
        temporaryList.map((e) => e.toJson()).toList();

    tempListJson.forEach((json) {
      logger.e(json);
    });
  }

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
              selectedOption = selectedValue!;
              _addAnswerRow(selectedOption, textFieldController.text);
              widget.isChecked(selectedOption);
              logger.e('slected value is $selectedValue');
            });

            logger.e(widget.index);
            logger.e('selected option $selectedOption');
          },
        ),
        const SizedBox(width: 5),
        Expanded(
          flex: 3,
          child: TextFormField(
            maxLines: 1,
            minLines: 1,
            controller: textFieldController,
            decoration: const InputDecoration(
              labelText: 'Enter some text',
              border: OutlineInputBorder(),
            ),
            textInputAction: TextInputAction.done,
            onChanged: ((value) {}),
            onFieldSubmitted: (value) {
              if (textFieldController.text.isNotEmpty) {
                widget.onControllerChanged(textFieldController);
                _addAnswerRow(selectedOption, textFieldController.text);
              }
            },
          ),
        ),
      ],
    );
  }
}
