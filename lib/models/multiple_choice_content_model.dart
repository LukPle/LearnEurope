import 'package:flutter/material.dart';

class MultipleChoiceContentModel {
  Widget questionCardContent;
  List<String> answerOptions;
  String hint;

  MultipleChoiceContentModel({
    required this.questionCardContent,
    required this.answerOptions,
    required this.hint,
  });
}
