import 'package:latlong2/latlong.dart';
import 'package:learn_europe/models/enums/category_enum.dart';

class MapContentModel {
  Category quizCategory;
  String quizId;
  String question;
  double latitude;
  double longitude;
  LatLng latLng;
  int allowedKmDifference;
  String hint;
  int hintMinus;

  MapContentModel({
    required this.quizCategory,
    required this.quizId,
    required this.question,
    required this.latitude,
    required this.longitude,
    required this.allowedKmDifference,
    required this.hint,
    required this.hintMinus,
  })  : latLng = LatLng(latitude, longitude);
}
