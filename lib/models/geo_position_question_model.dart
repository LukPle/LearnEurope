class GeoPositionQuestionModel {
  String question;
  double latitude;
  double longitude;
  int allowedKmDifference;
  String hint;

  GeoPositionQuestionModel({
    required this.question,
    required this.latitude,
    required this.longitude,
    required this.allowedKmDifference,
    required this.hint,
  });

  factory GeoPositionQuestionModel.fromMap(Map<String, dynamic> data) {
    return GeoPositionQuestionModel(
      question: data['question'] as String,
      latitude: data['latitude'] as double,
      longitude: data['longitude'] as double,
      allowedKmDifference: data['allowed_km_difference'] as int,
      hint: data['hint'] as String,
    );
  }
}