import 'package:learn_europe/models/quiz_list_filter_enum.dart';
import 'package:mobx/mobx.dart';

part 'quiz_selection_filter_store.g.dart';

class QuizSelectionFilterStore = _QuizSelectionFilterStore with _$QuizSelectionFilterStore;

abstract class _QuizSelectionFilterStore with Store {
  @observable
  QuizListFilter quizListFilter = QuizListFilter.all;

  @action
  void setQuizListFilter(QuizListFilter quizListFilter) {
    this.quizListFilter = quizListFilter;
  }
}
