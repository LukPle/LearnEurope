import 'package:mobx/mobx.dart';

part 'question_store.g.dart';

class QuestionStore = _QuestionStore with _$QuestionStore;

abstract class _QuestionStore with Store {
  @observable
  int numbQuestion = 0;

  @action
  void nextQuestion() {
    numbQuestion++;
  }
}
