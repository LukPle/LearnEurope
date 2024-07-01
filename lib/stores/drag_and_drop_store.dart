import 'package:flutter/material.dart';
import 'package:learn_europe/ui/screens/drag_and_drop_screen.dart';
import 'package:mobx/mobx.dart';

part 'drag_and_drop_store.g.dart';

class DragAndDropStore = _DragAndDropStore with _$DragAndDropStore;

abstract class _DragAndDropStore with Store {
  @observable
  ObservableList<Widget> availableItems = ObservableList<DraggableItem>();

  @observable
  ObservableList<Widget> selectedItems = ObservableList<DraggableItem>();

  @action
  void addAvailableItem(Widget item) {
    availableItems.add(item);
  }

  @action
  void removeAvailableItem(Widget item) {
    availableItems.remove(item);
  }

  @action
  void addSelectedItem(Widget item) {
    selectedItems.add(item);
  }

  @action
  void removeSelectedItem(Widget item) {
    selectedItems.remove(item);
  }
}
