import 'package:mobx/mobx.dart';

part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  @observable
  String? userId;

  @observable
  String? username;

  @action
  Future<void> saveUserProfile(String userId, String username) async {
    this.userId = userId;
    this.username = username;
  }

  @action
  Future<void> resetUserProfile() async {
    userId = null;
    username = null;
  }
}
