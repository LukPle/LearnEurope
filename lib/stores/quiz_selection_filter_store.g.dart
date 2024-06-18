// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_selection_filter_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$QuizSelectionFilterStore on _QuizSelectionFilterStore, Store {
  late final _$quizListFilterAtom =
      Atom(name: '_QuizSelectionFilterStore.quizListFilter', context: context);

  @override
  QuizListFilter get quizListFilter {
    _$quizListFilterAtom.reportRead();
    return super.quizListFilter;
  }

  @override
  set quizListFilter(QuizListFilter value) {
    _$quizListFilterAtom.reportWrite(value, super.quizListFilter, () {
      super.quizListFilter = value;
    });
  }

  late final _$_QuizSelectionFilterStoreActionController =
      ActionController(name: '_QuizSelectionFilterStore', context: context);

  @override
  void setQuizListFilter(QuizListFilter quizListFilter) {
    final _$actionInfo = _$_QuizSelectionFilterStoreActionController
        .startAction(name: '_QuizSelectionFilterStore.setQuizListFilter');
    try {
      return super.setQuizListFilter(quizListFilter);
    } finally {
      _$_QuizSelectionFilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
quizListFilter: ${quizListFilter}
    ''';
  }
}
