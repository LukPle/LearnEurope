import 'package:learn_europe/models/enums/category_enum.dart';
import 'package:learn_europe/models/enums/difficulties_enum.dart';

class ResultContentModel {
  Category quizCategory;
  String quizId;
  QuizDifficulty quizDifficulty;
  int numbQuestions;
  int earnedScore;
  int availableScore;
  int hintMinus;

  ResultContentModel({
    required this.quizCategory,
    required this.quizId,
    required this.quizDifficulty,
    required this.numbQuestions,
    required this.earnedScore,
    required this.availableScore,
    required this.hintMinus,
  });
}
