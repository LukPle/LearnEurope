import 'package:learn_europe/models/enums/category_enum.dart';
import 'package:learn_europe/models/enums/difficulties_enum.dart';

class DragAndDropContentModel {
  Category quizCategory;
  String quizId;
  QuizDifficulty quizDifficulty;
  String question;
  List<String> answerOptions;
  int numbCorrectAnswers;
  List<String> correctAnswerOptions;
  List<String> shuffledAnswerOptions;
  int pointsPerQuestion;
  String hint;
  int hintMinus;
  String explanation;

  DragAndDropContentModel({
    required this.quizCategory,
    required this.quizId,
    required this.quizDifficulty,
    required this.question,
    required this.answerOptions,
    required this.numbCorrectAnswers,
    required this.pointsPerQuestion,
    required this.hint,
    required this.hintMinus,
    required this.explanation,
  })  : correctAnswerOptions = answerOptions.take(numbCorrectAnswers).toList(),
        shuffledAnswerOptions = List.from(answerOptions)..shuffle();
}
