import 'package:mobx/mobx.dart';

part 'cta_button_loading_store.g.dart';

class CtaButtonLoadingStore = _CtaButtonLoadingStore with _$CtaButtonLoadingStore;

abstract class _CtaButtonLoadingStore with Store {
  @observable
  bool isLoading = false;

  @action
  void setLoading() {
    isLoading = true;
  }

  @action
  void resetLoading() {
    isLoading = false;
  }
}
