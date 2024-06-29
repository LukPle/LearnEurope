import 'package:flutter/material.dart';

class MultipleChoiceContentModel {
  Widget questionCardContent;
  List<String> answerOptions;
  String correctAnswer;
  List<String> shuffledAnswerOptions;
  int pointsPerQuestion;
  String hint;
  int hintMinus;
  String explanation;

  MultipleChoiceContentModel({
    required this.questionCardContent,
    required this.answerOptions,
    required this.pointsPerQuestion,
    required this.hint,
    required this.hintMinus,
    required this.explanation,
  })  : correctAnswer = answerOptions.first,
        shuffledAnswerOptions = List.from(answerOptions)..shuffle();
}
