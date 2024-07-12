import 'package:mobx/mobx.dart';

part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  @observable
  String? userId;

  @observable
  String? username;

  @observable
  String? avatar;

  @action
  Future<void> saveUserProfile(String userId, String username, String avatar) async {
    this.userId = userId;
    this.username = username;
    this.avatar = avatar;
  }

  @action
  Future<void> updateAvatar(String avatar) async {
    this.avatar = avatar;
  }

  @action
  Future<void> resetUserProfile() async {
    userId = null;
    username = null;
    avatar = null;
  }
}
