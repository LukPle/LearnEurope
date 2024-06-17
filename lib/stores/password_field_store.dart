import 'package:mobx/mobx.dart';

part 'password_field_store.g.dart';

class PasswordFieldStore = _PasswordFieldStore with _$PasswordFieldStore;

abstract class _PasswordFieldStore with Store {
  @observable
  bool isVisible = false;

  @action
  void toggleVisibility() {
    isVisible = !isVisible;
  }
}
