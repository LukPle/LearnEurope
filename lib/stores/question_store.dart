import 'package:mobx/mobx.dart';

part 'question_store.g.dart';

class QuestionStore = _QuestionStore with _$QuestionStore;

abstract class _QuestionStore with Store {
  @observable
  int numbQuestion = 0;

  @observable
  bool isAnswered = false;

  @action
  void nextQuestion() {
    numbQuestion++;
  }

  @action
  void setAnswered() {
    isAnswered = true;
  }

  @action
  void setUnanswered() {
    isAnswered = false;
  }
}
