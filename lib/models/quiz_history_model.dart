import 'package:cloud_firestore/cloud_firestore.dart';

class QuizHistoryModel {
  String quizId;
  String userId;
  DateTime completionDate;

  QuizHistoryModel({
    required this.quizId,
    required this.userId,
    required this.completionDate,
  });

  factory QuizHistoryModel.fromMap(Map<String, dynamic> data) {
    return QuizHistoryModel(
      quizId: data['quiz_id'] as String,
      userId: data['user_id'] as String,
      completionDate: (data['completion_date'] as Timestamp).toDate(),
    );
  }
}
