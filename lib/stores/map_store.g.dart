// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MapStore on _MapStore, Store {
  late final _$isMapReadyAtom =
      Atom(name: '_MapStore.isMapReady', context: context);

  @override
  bool get isMapReady {
    _$isMapReadyAtom.reportRead();
    return super.isMapReady;
  }

  @override
  set isMapReady(bool value) {
    _$isMapReadyAtom.reportWrite(value, super.isMapReady, () {
      super.isMapReady = value;
    });
  }

  late final _$isRotatedAtom =
      Atom(name: '_MapStore.isRotated', context: context);

  @override
  bool get isRotated {
    _$isRotatedAtom.reportRead();
    return super.isRotated;
  }

  @override
  set isRotated(bool value) {
    _$isRotatedAtom.reportWrite(value, super.isRotated, () {
      super.isRotated = value;
    });
  }

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
  void setMapReady() {
    final _$actionInfo =
        _$_MapStoreActionController.startAction(name: '_MapStore.setMapReady');
    try {
      return super.setMapReady();
    } finally {
      _$_MapStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetMapReady() {
    final _$actionInfo = _$_MapStoreActionController.startAction(
        name: '_MapStore.resetMapReady');
    try {
      return super.resetMapReady();
    } finally {
      _$_MapStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRotation(bool isRotated) {
    final _$actionInfo =
        _$_MapStoreActionController.startAction(name: '_MapStore.setRotation');
    try {
      return super.setRotation(isRotated);
    } finally {
      _$_MapStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isMapReady: ${isMapReady},
isRotated: ${isRotated},
selectedLocation: ${selectedLocation}
    ''';
  }
}
