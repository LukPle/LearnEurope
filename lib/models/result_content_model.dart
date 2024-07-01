import 'package:learn_europe/models/enums/category_enum.dart';

class ResultContentModel {
  Category quizCategory;
  String quizId;
  int numbQuestions;
  int earnedScore;
  int availableScore;

  ResultContentModel({
    required this.quizCategory,
    required this.quizId,
    required this.numbQuestions,
    required this.earnedScore,
    required this.availableScore,
  });
}
