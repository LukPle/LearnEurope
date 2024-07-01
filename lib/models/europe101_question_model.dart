class Europe101QuestionModel {
  String question;
  List<String> answers;
  int numbCorrectAnswers;
  String hint;
  String explanation;

  Europe101QuestionModel({
    required this.question,
    required this.answers,
    required this.numbCorrectAnswers,
    required this.hint,
    required this.explanation,
  });

  factory Europe101QuestionModel.fromMap(Map<String, dynamic> data) {
    return Europe101QuestionModel(
      question: data['question'] as String,
      answers: List<String>.from(data['answers']),
      numbCorrectAnswers: data['numb_correct_answers'],
      hint: data['hint'] as String,
      explanation: data['explanation'] as String,
    );
  }
}
