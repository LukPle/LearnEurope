// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$QuestionStore on _QuestionStore, Store {
  late final _$numbQuestionAtom =
      Atom(name: '_QuestionStore.numbQuestion', context: context);

  @override
  int get numbQuestion {
    _$numbQuestionAtom.reportRead();
    return super.numbQuestion;
  }

  @override
  set numbQuestion(int value) {
    _$numbQuestionAtom.reportWrite(value, super.numbQuestion, () {
      super.numbQuestion = value;
    });
  }

  late final _$isAnsweredAtom =
      Atom(name: '_QuestionStore.isAnswered', context: context);

  @override
  bool get isAnswered {
    _$isAnsweredAtom.reportRead();
    return super.isAnswered;
  }

  @override
  set isAnswered(bool value) {
    _$isAnsweredAtom.reportWrite(value, super.isAnswered, () {
      super.isAnswered = value;
    });
  }

  late final _$_QuestionStoreActionController =
      ActionController(name: '_QuestionStore', context: context);

  @override
  void nextQuestion() {
    final _$actionInfo = _$_QuestionStoreActionController.startAction(
        name: '_QuestionStore.nextQuestion');
    try {
      return super.nextQuestion();
    } finally {
      _$_QuestionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAnswered() {
    final _$actionInfo = _$_QuestionStoreActionController.startAction(
        name: '_QuestionStore.setAnswered');
    try {
      return super.setAnswered();
    } finally {
      _$_QuestionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUnanswered() {
    final _$actionInfo = _$_QuestionStoreActionController.startAction(
        name: '_QuestionStore.setUnanswered');
    try {
      return super.setUnanswered();
    } finally {
      _$_QuestionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
numbQuestion: ${numbQuestion},
isAnswered: ${isAnswered}
    ''';
  }
}
