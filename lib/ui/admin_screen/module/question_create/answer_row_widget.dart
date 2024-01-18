import 'package:flutter/material.dart';
import 'package:ithub_quiz/ui/admin_screen/model/answer.dart';
import 'package:ithub_quiz/utils/app_logger.dart';

class AnswerRow extends StatefulWidget {
  final int index;
  final ValueChanged<int> onDelete;
  final Function(int) isChecked;
  final Function(Answer) answerDataList;
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
  int? selectedOption;
  bool answerCheck = false;
  List<Answer> temporaryList = [];
  AnswerList thisisForClass = AnswerList(Answer(false, ""));
  TextEditingController textFieldController = TextEditingController();

  // void _addAnswerRow(int isChecked, String answer) {
  //   logger.e(answer);

  //   isChecked == 1 ? answerCheck = true : answerCheck = false;

  //   logger.e('Tempory radio value is  $isChecked and text is $answer');

  //   widget.answerDataList(Answer(answerCheck, answer).toJson());

  //   logger.e(temporaryList.toList().toString());
  // }

  void _updateAnswerDataList(int index, int isChecked) {
    isChecked == 1 ? answerCheck = true : answerCheck = false;
    setState(() {
      if (index < temporaryList.length) {
        var text = temporaryList[index].answer;
        temporaryList[index] = Answer(answerCheck, text);
      }
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
              logger.e('slected value is ${widget.index}');
              _updateAnswerDataList(widget.index, selectedValue);
              widget.isChecked(selectedOption!);
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
                logger.e("Add Some Role");
                widget.onControllerChanged(textFieldController);
                //_addAnswerRow(0, textFieldController.text);
              }
            },
          ),
        ),
      ],
    );
  }
}
