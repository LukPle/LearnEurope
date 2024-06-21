// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cta_button_loading_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CtaButtonLoadingStore on _CtaButtonLoadingStore, Store {
  late final _$isLoadingAtom =
      Atom(name: '_CtaButtonLoadingStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$_CtaButtonLoadingStoreActionController =
      ActionController(name: '_CtaButtonLoadingStore', context: context);

  @override
  void setLoading() {
    final _$actionInfo = _$_CtaButtonLoadingStoreActionController.startAction(
        name: '_CtaButtonLoadingStore.setLoading');
    try {
      return super.setLoading();
    } finally {
      _$_CtaButtonLoadingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetLoading() {
    final _$actionInfo = _$_CtaButtonLoadingStoreActionController.startAction(
        name: '_CtaButtonLoadingStore.resetLoading');
    try {
      return super.resetLoading();
    } finally {
      _$_CtaButtonLoadingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading}
    ''';
  }
}
