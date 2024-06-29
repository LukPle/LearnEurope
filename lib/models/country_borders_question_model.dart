class CountryBordersQuestionModel {
  String question;
  String image_url;
  List<String> answers;
  String hint;
  String explanation;

  CountryBordersQuestionModel({
    required this.question,
    required this.image_url,
    required this.answers,
    required this.hint,
    required this.explanation,
  });

  factory CountryBordersQuestionModel.fromMap(Map<String, dynamic> data) {
    return CountryBordersQuestionModel(
      question: data['question'] as String,
      image_url: data['image_url'] as String,
      answers: List<String>.from(data['answers']),
      hint: data['hint'] as String,
      explanation: data['explanation'] as String,
    );
  }
}
