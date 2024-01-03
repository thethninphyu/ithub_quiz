class Answer {
  final bool isChecked;
  final String answer;

  Answer(this.isChecked, this.answer);

  Map<String, dynamic> toJson() => {'isChecked': isChecked, 'answer': answer};
}

class AnswerList {
  final Answer answer;

  AnswerList(this.answer);

  Map<String, dynamic> toJson() => {'answer': answer.toJson()};
}
