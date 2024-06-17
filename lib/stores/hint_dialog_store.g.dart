// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hint_dialog_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HintDialogStore on _HintDialogStore, Store {
  late final _$isHintRevealedAtom =
      Atom(name: '_HintDialogStore.isHintRevealed', context: context);

  @override
  bool get isHintRevealed {
    _$isHintRevealedAtom.reportRead();
    return super.isHintRevealed;
  }

  @override
  set isHintRevealed(bool value) {
    _$isHintRevealedAtom.reportWrite(value, super.isHintRevealed, () {
      super.isHintRevealed = value;
    });
  }

  late final _$_HintDialogStoreActionController =
      ActionController(name: '_HintDialogStore', context: context);

  @override
  void revealHint() {
    final _$actionInfo = _$_HintDialogStoreActionController.startAction(
        name: '_HintDialogStore.revealHint');
    try {
      return super.revealHint();
    } finally {
      _$_HintDialogStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isHintRevealed: ${isHintRevealed}
    ''';
  }
}
