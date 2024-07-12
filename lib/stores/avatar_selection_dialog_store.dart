import 'package:mobx/mobx.dart';

part 'avatar_selection_dialog_store.g.dart';

class AvatarSelectionDialogStore = _AvatarSelectionDialogStore with _$AvatarSelectionDialogStore;

abstract class _AvatarSelectionDialogStore with Store {
  @observable
  String selectedAvatar = 'avatar_blue';

  @action
  void setAvatar(String selectedAvatar) {
    this.selectedAvatar = selectedAvatar;
  }
}
