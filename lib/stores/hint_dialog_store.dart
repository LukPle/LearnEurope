import 'package:mobx/mobx.dart';

part 'hint_dialog_store.g.dart';

class HintDialogStore = _HintDialogStore with _$HintDialogStore;

abstract class _HintDialogStore with Store {
  @observable
  bool isHintRevealed = false;

  @action
  void revealHint() {
    isHintRevealed = true;
  }
}
