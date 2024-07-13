class GappedTextContentModel {
  String gappedText;
  final List<String> correctAnswers;
  int pointsPerQuestion;
  String hint;
  int hintMinus;
  String explanation;

  GappedTextContentModel({
    required this.gappedText,
    required this.correctAnswers,
    required this.pointsPerQuestion,
    required this.hint,
    required this.hintMinus,
    required this.explanation,
  });
}
