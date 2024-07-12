// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserStore on _UserStore, Store {
  late final _$userIdAtom = Atom(name: '_UserStore.userId', context: context);

  @override
  String? get userId {
    _$userIdAtom.reportRead();
    return super.userId;
  }

  @override
  set userId(String? value) {
    _$userIdAtom.reportWrite(value, super.userId, () {
      super.userId = value;
    });
  }

  late final _$usernameAtom =
      Atom(name: '_UserStore.username', context: context);

  @override
  String? get username {
    _$usernameAtom.reportRead();
    return super.username;
  }

  @override
  set username(String? value) {
    _$usernameAtom.reportWrite(value, super.username, () {
      super.username = value;
    });
  }

  late final _$avatarAtom = Atom(name: '_UserStore.avatar', context: context);

  @override
  String? get avatar {
    _$avatarAtom.reportRead();
    return super.avatar;
  }

  @override
  set avatar(String? value) {
    _$avatarAtom.reportWrite(value, super.avatar, () {
      super.avatar = value;
    });
  }

  late final _$saveUserProfileAsyncAction =
      AsyncAction('_UserStore.saveUserProfile', context: context);

  @override
  Future<void> saveUserProfile(String userId, String username, String avatar) {
    return _$saveUserProfileAsyncAction
        .run(() => super.saveUserProfile(userId, username, avatar));
  }

  late final _$updateAvatarAsyncAction =
      AsyncAction('_UserStore.updateAvatar', context: context);

  @override
  Future<void> updateAvatar(String avatar) {
    return _$updateAvatarAsyncAction.run(() => super.updateAvatar(avatar));
  }

  late final _$resetUserProfileAsyncAction =
      AsyncAction('_UserStore.resetUserProfile', context: context);

  @override
  Future<void> resetUserProfile() {
    return _$resetUserProfileAsyncAction.run(() => super.resetUserProfile());
  }

  @override
  String toString() {
    return '''
userId: ${userId},
username: ${username},
avatar: ${avatar}
    ''';
  }
}
