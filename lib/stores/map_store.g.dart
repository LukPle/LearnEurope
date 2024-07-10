// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MapStore on _MapStore, Store {
  late final _$selectedLocationAtom =
      Atom(name: '_MapStore.selectedLocation', context: context);

  @override
  LatLng? get selectedLocation {
    _$selectedLocationAtom.reportRead();
    return super.selectedLocation;
  }

  @override
  set selectedLocation(LatLng? value) {
    _$selectedLocationAtom.reportWrite(value, super.selectedLocation, () {
      super.selectedLocation = value;
    });
  }

  late final _$_MapStoreActionController =
      ActionController(name: '_MapStore', context: context);

  @override
  void setLocation(LatLng newLocation) {
    final _$actionInfo =
        _$_MapStoreActionController.startAction(name: '_MapStore.setLocation');
    try {
      return super.setLocation(newLocation);
    } finally {
      _$_MapStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedLocation: ${selectedLocation}
    ''';
  }
}
