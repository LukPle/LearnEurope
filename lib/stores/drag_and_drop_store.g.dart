// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drag_and_drop_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DragAndDropStore on _DragAndDropStore, Store {
  late final _$availableItemsAtom =
      Atom(name: '_DragAndDropStore.availableItems', context: context);

  @override
  ObservableList<Widget> get availableItems {
    _$availableItemsAtom.reportRead();
    return super.availableItems;
  }

  @override
  set availableItems(ObservableList<Widget> value) {
    _$availableItemsAtom.reportWrite(value, super.availableItems, () {
      super.availableItems = value;
    });
  }

  late final _$selectedItemsAtom =
      Atom(name: '_DragAndDropStore.selectedItems', context: context);

  @override
  ObservableList<Widget> get selectedItems {
    _$selectedItemsAtom.reportRead();
    return super.selectedItems;
  }

  @override
  set selectedItems(ObservableList<Widget> value) {
    _$selectedItemsAtom.reportWrite(value, super.selectedItems, () {
      super.selectedItems = value;
    });
  }

  late final _$_DragAndDropStoreActionController =
      ActionController(name: '_DragAndDropStore', context: context);

  @override
  void addAvailableItem(Widget item) {
    final _$actionInfo = _$_DragAndDropStoreActionController.startAction(
        name: '_DragAndDropStore.addAvailableItem');
    try {
      return super.addAvailableItem(item);
    } finally {
      _$_DragAndDropStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeAvailableItem(Widget item) {
    final _$actionInfo = _$_DragAndDropStoreActionController.startAction(
        name: '_DragAndDropStore.removeAvailableItem');
    try {
      return super.removeAvailableItem(item);
    } finally {
      _$_DragAndDropStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addSelectedItem(Widget item) {
    final _$actionInfo = _$_DragAndDropStoreActionController.startAction(
        name: '_DragAndDropStore.addSelectedItem');
    try {
      return super.addSelectedItem(item);
    } finally {
      _$_DragAndDropStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeSelectedItem(Widget item) {
    final _$actionInfo = _$_DragAndDropStoreActionController.startAction(
        name: '_DragAndDropStore.removeSelectedItem');
    try {
      return super.removeSelectedItem(item);
    } finally {
      _$_DragAndDropStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
availableItems: ${availableItems},
selectedItems: ${selectedItems}
    ''';
  }
}
