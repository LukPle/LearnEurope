import 'package:mobx/mobx.dart';

part 'leaderboard_store.g.dart';

class LeaderboardStore = _LeaderboardStore with _$LeaderboardStore;

abstract class _LeaderboardStore with Store {
  @observable
  bool isSheetExpanded = false;

  @action
  void toggleSheetExpansion() {
    isSheetExpanded = !isSheetExpanded;
  }
}
