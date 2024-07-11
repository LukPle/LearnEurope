import 'package:learn_europe/models/quiz_history_model.dart';
import 'package:learn_europe/models/quiz_model.dart';
import 'enums/category_enum.dart';

class QuizSelectionContentModel {
  Category category;
  QuizModel quizModel;
  QuizHistoryModel? quizHistoryModel;

  QuizSelectionContentModel({
    required this.category,
    required this.quizModel,
    required this.quizHistoryModel,
  });
}
