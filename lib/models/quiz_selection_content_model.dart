import 'package:learn_europe/models/quiz_history_model.dart';
import 'package:learn_europe/models/quiz_model.dart';

class QuizSelectionContentModel {
  QuizModel quizModel;
  QuizHistoryModel? quizHistoryModel;

  QuizSelectionContentModel({
    required this.quizModel,
    required this.quizHistoryModel,
  });
}
