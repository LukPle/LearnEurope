// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LeaderboardStore on _LeaderboardStore, Store {
  late final _$isSheetExpandedAtom =
      Atom(name: '_LeaderboardStore.isSheetExpanded', context: context);

  @override
  bool get isSheetExpanded {
    _$isSheetExpandedAtom.reportRead();
    return super.isSheetExpanded;
  }

  @override
  set isSheetExpanded(bool value) {
    _$isSheetExpandedAtom.reportWrite(value, super.isSheetExpanded, () {
      super.isSheetExpanded = value;
    });
  }

  late final _$_LeaderboardStoreActionController =
      ActionController(name: '_LeaderboardStore', context: context);

  @override
  void toggleSheetExpansion() {
    final _$actionInfo = _$_LeaderboardStoreActionController.startAction(
        name: '_LeaderboardStore.toggleSheetExpansion');
    try {
      return super.toggleSheetExpansion();
    } finally {
      _$_LeaderboardStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isSheetExpanded: ${isSheetExpanded}
    ''';
  }
}
