import 'package:flutter/material.dart';

class MultipleChoiceContentModel {
  Widget questionCardContent;
  List<String> answerOptions;
  String correctAnswer;
  List<String> shuffledAnswerOptions;
  String hint;

  MultipleChoiceContentModel({
    required this.questionCardContent,
    required this.answerOptions,
    required this.hint,
  })  : correctAnswer = answerOptions.first,
        shuffledAnswerOptions = List.from(answerOptions)..shuffle();
}
