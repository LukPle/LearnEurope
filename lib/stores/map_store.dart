import 'package:mobx/mobx.dart';
import 'package:latlong2/latlong.dart';

part 'map_store.g.dart';

class MapStore = _MapStore with _$MapStore;

abstract class _MapStore with Store {
  @observable
  bool isMapReady = false;

  @observable
  bool isRotated = false;

  @observable
  bool isZoomedInOut = false;

  @observable
  LatLng? selectedLocation;

  @action
  void setLocation(LatLng newLocation) {
    selectedLocation = newLocation;
  }

  @action
  void setMapReady() {
    isMapReady = true;
  }

  @action
  void resetMapReady() {
    isMapReady = false;
  }

  @action
  void setRotation(bool isRotated) {
    this.isRotated = isRotated;
  }

  @action
  void setZoom(bool isZoomedInOut) {
    this.isZoomedInOut = isZoomedInOut;
  }
}
