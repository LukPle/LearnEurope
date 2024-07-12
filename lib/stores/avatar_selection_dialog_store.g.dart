// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avatar_selection_dialog_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AvatarSelectionDialogStore on _AvatarSelectionDialogStore, Store {
  late final _$selectedAvatarAtom = Atom(
      name: '_AvatarSelectionDialogStore.selectedAvatar', context: context);

  @override
  String get selectedAvatar {
    _$selectedAvatarAtom.reportRead();
    return super.selectedAvatar;
  }

  @override
  set selectedAvatar(String value) {
    _$selectedAvatarAtom.reportWrite(value, super.selectedAvatar, () {
      super.selectedAvatar = value;
    });
  }

  late final _$_AvatarSelectionDialogStoreActionController =
      ActionController(name: '_AvatarSelectionDialogStore', context: context);

  @override
  void setAvatar(String selectedAvatar) {
    final _$actionInfo = _$_AvatarSelectionDialogStoreActionController
        .startAction(name: '_AvatarSelectionDialogStore.setAvatar');
    try {
      return super.setAvatar(selectedAvatar);
    } finally {
      _$_AvatarSelectionDialogStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedAvatar: ${selectedAvatar}
    ''';
  }
}
