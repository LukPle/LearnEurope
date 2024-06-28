import 'package:flutter/material.dart';

class MultipleChoiceContentModel {
  Widget questionCardContent;
  List<String> answerOptions;
  String correctAnswer;
  List<String> shuffledAnswerOptions;
  int pointsPerQuestion;
  String hint;
  int hintMinus;

  MultipleChoiceContentModel({
    required this.questionCardContent,
    required this.answerOptions,
    required this.pointsPerQuestion,
    required this.hint,
    required this.hintMinus,
  })  : correctAnswer = answerOptions.first,
        shuffledAnswerOptions = List.from(answerOptions)..shuffle();
}
