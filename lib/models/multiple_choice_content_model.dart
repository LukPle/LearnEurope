import 'package:flutter/material.dart';
import 'package:learn_europe/models/enums/category_enum.dart';
import 'package:learn_europe/models/enums/difficulties_enum.dart';

class MultipleChoiceContentModel {
  Category quizCategory;
  String quizId;
  QuizDifficulty quizDifficulty;
  Widget questionCardContent;
  List<String> answerOptions;
  String correctAnswer;
  List<String> shuffledAnswerOptions;
  int pointsPerQuestion;
  String hint;
  int hintMinus;
  String explanation;

  MultipleChoiceContentModel({
    required this.quizCategory,
    required this.quizId,
    required this.quizDifficulty,
    required this.questionCardContent,
    required this.answerOptions,
    required this.pointsPerQuestion,
    required this.hint,
    required this.hintMinus,
    required this.explanation,
  })  : correctAnswer = answerOptions.first,
        shuffledAnswerOptions = List.from(answerOptions)..shuffle();
}
