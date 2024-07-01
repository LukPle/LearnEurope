import 'enums/difficulties_enum.dart';

class QuizModel {
  String id;
  String title;
  QuizDifficulty difficulty;
  List<String> questions;
  int pointsPerQuestion;
  int hintPointsMinus;

  QuizModel({
    required this.id,
    required this.title,
    required this.difficulty,
    required this.questions,
    required this.pointsPerQuestion,
    required this.hintPointsMinus,
  });

  factory QuizModel.fromMap(String id, Map<String, dynamic> data) {
    return QuizModel(
      id: id,
      title: data['title'] as String,
      difficulty: _getQuizDifficulty(data['difficulty'] as String),
      questions: List<String>.from(data['questions']),
      pointsPerQuestion: data['points_per_question'] as int,
      hintPointsMinus: data['hint_minus'] as int,
    );
  }

  static QuizDifficulty _getQuizDifficulty(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return QuizDifficulty.beginner;
      case 'hard':
        return QuizDifficulty.expert;
      default:
        return QuizDifficulty.beginner;
    }
  }
}
