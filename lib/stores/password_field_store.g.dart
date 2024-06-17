// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_field_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PasswordFieldStore on _PasswordFieldStore, Store {
  late final _$isVisibleAtom =
      Atom(name: '_PasswordFieldStore.isVisible', context: context);

  @override
  bool get isVisible {
    _$isVisibleAtom.reportRead();
    return super.isVisible;
  }

  @override
  set isVisible(bool value) {
    _$isVisibleAtom.reportWrite(value, super.isVisible, () {
      super.isVisible = value;
    });
  }

  late final _$_PasswordFieldStoreActionController =
      ActionController(name: '_PasswordFieldStore', context: context);

  @override
  void toggleVisibility() {
    final _$actionInfo = _$_PasswordFieldStoreActionController.startAction(
        name: '_PasswordFieldStore.toggleVisibility');
    try {
      return super.toggleVisibility();
    } finally {
      _$_PasswordFieldStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isVisible: ${isVisible}
    ''';
  }
}
