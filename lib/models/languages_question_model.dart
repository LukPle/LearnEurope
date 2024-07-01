class LanguagesQuestionModel {
  String question;
  String quote;
  String languageCode;
  List<String> answers;
  String hint;
  String explanation;

  LanguagesQuestionModel({
    required this.question,
    required this.quote,
    required this.languageCode,
    required this.answers,
    required this.hint,
    required this.explanation,
  });

  factory LanguagesQuestionModel.fromMap(Map<String, dynamic> data) {
    return LanguagesQuestionModel(
      question: data['question'] as String,
      quote: data['quote'] as String,
      languageCode: data['language_code'] as String,
      answers: List<String>.from(data['answers']),
      hint: data['hint'] as String,
      explanation: data['explanation'] as String,
    );
  }
}
