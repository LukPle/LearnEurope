import 'package:mobx/mobx.dart';
import 'package:latlong2/latlong.dart';

part 'map_store.g.dart';

class MapStore = _MapStore with _$MapStore;

abstract class _MapStore with Store {
  @observable
  LatLng? selectedLocation;

  @action
  void setLocation(LatLng newLocation) {
    selectedLocation = newLocation;
  }
}
