import 'db_services.dart';
import 'firebase_constants.dart';
import 'package:flutter/material.dart';
import 'package:learn_europe/models/country_borders_question_model.dart';
import 'package:learn_europe/models/drag_and_drop_content_model.dart';
import 'package:learn_europe/models/enums/category_enum.dart';
import 'package:learn_europe/models/europe101_question_model.dart';
import 'package:learn_europe/models/geo_position_question_model.dart';
import 'package:learn_europe/models/languages_question_model.dart';
import 'package:learn_europe/models/map_content_model.dart';
import 'package:learn_europe/models/multiple_choice_content_model.dart';
import 'package:learn_europe/models/quiz_history_model.dart';
import 'package:learn_europe/models/quiz_model.dart';
import 'package:learn_europe/models/quiz_selection_content_model.dart';
import 'package:learn_europe/service_locator.dart';
import 'package:learn_europe/stores/user_store.dart';
import 'package:learn_europe/ui/components/multiple_choice_question_cards/country_border_question_card.dart';
import 'package:learn_europe/ui/components/multiple_choice_question_cards/languages_question_card.dart';
import 'package:learn_europe/constants/routes.dart' as routes;

Future<List<QuizModel>> _fetchQuizzes(Category category) async {
  final DatabaseServices dbServices = DatabaseServices();
  String collection;

  switch (category) {
    case Category.europe101:
      collection = FirebaseConstants.europe101QuizCollection;
    case Category.languages:
      collection = FirebaseConstants.languagesQuizCollection;
    case Category.countryBorders:
      collection = FirebaseConstants.countryBordersQuizCollection;
    case Category.geoPosition:
      collection = FirebaseConstants.geoPositionQuizCollection;
  }

  final docs = await dbServices.getAllDocuments(collection: collection);
  return docs.map((doc) => QuizModel.fromMap(doc.id, doc.data() as Map<String, dynamic>)).toList();
}

Future<List<QuizHistoryModel>> _fetchQuizHistory(Category category) async {
  final DatabaseServices dbServices = DatabaseServices();
  String collection;

  switch (category) {
    case Category.europe101:
      collection = FirebaseConstants.europe101HistoryCollection;
    case Category.languages:
      collection = FirebaseConstants.languagesHistoryCollection;
    case Category.countryBorders:
      collection = FirebaseConstants.countryBordersHistoryCollection;
    case Category.geoPosition:
      collection = FirebaseConstants.geoPositionHistoryCollection;
  }

  final docs = await dbServices.getDocumentsByAttribute(
      collection: collection, field: 'user_id', value: getIt<UserStore>().userId);
  return docs.map((doc) => QuizHistoryModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
}

Future<List<QuizSelectionContentModel>> fetchQuizzesWithHistory(Category category) async {
  List<QuizModel> quizzes = await _fetchQuizzes(category);
  List<QuizHistoryModel> quizHistory = await _fetchQuizHistory(category);

  Map<String, QuizHistoryModel> quizHistoryMap = {for (var history in quizHistory) history.quizId: history};

  List<QuizSelectionContentModel> quizSelectionContent = quizzes.map((quiz) {
    QuizHistoryModel? matchingHistory = quizHistoryMap[quiz.id];

    return QuizSelectionContentModel(
      quizModel: quiz,
      quizHistoryModel: matchingHistory,
    );
  }).toList();

  return quizSelectionContent;
}

Future<List<String>> _fetchQuestionList(Category category, String quizId) async {
  final DatabaseServices dbServices = DatabaseServices();
  String collection;

  switch (category) {
    case Category.europe101:
      collection = FirebaseConstants.europe101QuizCollection;
      break;
    case Category.languages:
      collection = FirebaseConstants.languagesQuizCollection;
      break;
    case Category.countryBorders:
      collection = FirebaseConstants.countryBordersQuizCollection;
      break;
    case Category.geoPosition:
      collection = FirebaseConstants.geoPositionQuizCollection;
      break;
  }

  final doc = await dbServices.getDocument(collection: collection, docId: quizId);
  return List<String>.from(doc['questions']);
}

Future<List<dynamic>> _fetchQuestions(Category category, String quizId) async {
  final DatabaseServices dbServices = DatabaseServices();
  String collection;

  List<String> questionIds = await _fetchQuestionList(category, quizId);

  switch (category) {
    case Category.europe101:
      collection = FirebaseConstants.europe101QuestionsCollection;
      List<Europe101QuestionModel> questions = [];
      for (String id in questionIds) {
        final doc = await dbServices.getDocument(collection: collection, docId: id);
        questions.add(Europe101QuestionModel.fromMap(doc.data() as Map<String, dynamic>));
      }
      return questions;
    case Category.languages:
      collection = FirebaseConstants.languagesQuestionsCollection;
      List<LanguagesQuestionModel> questions = [];
      for (String id in questionIds) {
        final doc = await dbServices.getDocument(collection: collection, docId: id);
        questions.add(LanguagesQuestionModel.fromMap(doc.data() as Map<String, dynamic>));
      }
      return questions;
    case Category.countryBorders:
      collection = FirebaseConstants.countryBordersQuestionsCollection;
      List<CountryBordersQuestionModel> questions = [];
      for (String id in questionIds) {
        final doc = await dbServices.getDocument(collection: collection, docId: id);
        questions.add(CountryBordersQuestionModel.fromMap(doc.data() as Map<String, dynamic>));
      }
      return questions;
    case Category.geoPosition:
      collection = FirebaseConstants.geoPositionQuestionsCollection;
      List<GeoPositionQuestionModel> questions = [];
      for (String id in questionIds) {
        final doc = await dbServices.getDocument(collection: collection, docId: id);
        questions.add(GeoPositionQuestionModel.fromMap(doc.data() as Map<String, dynamic>));
      }
      return questions;
  }
}

Future<void> navigateToQuestions(
    BuildContext context, Category category, String quizId, int pointsPerQuestion, int hintMinus) async {
  switch (category) {
    case Category.europe101:
      List<Europe101QuestionModel> europe101Questions =
          await _fetchQuestions(category, quizId) as List<Europe101QuestionModel>;

      List<DragAndDropContentModel> dragAndDropContentModel = [];

      for (var question in europe101Questions) {
        dragAndDropContentModel.add(
          DragAndDropContentModel(
            quizCategory: category,
            quizId: quizId,
            question: question.question,
            answerOptions: question.answers,
            numbCorrectAnswers: question.numbCorrectAnswers,
            pointsPerQuestion: pointsPerQuestion,
            hint: question.hint,
            hintMinus: hintMinus,
            explanation: question.explanation,
          ),
        );
      }
      if (context.mounted) {
        Navigator.of(context).pushNamed(routes.dragAndDrop, arguments: dragAndDropContentModel);
      }
      break;
    case Category.languages:
      List<LanguagesQuestionModel> languagesQuestions =
          await _fetchQuestions(category, quizId) as List<LanguagesQuestionModel>;

      List<MultipleChoiceContentModel> multipleChoiceContentModels = [];

      for (var question in languagesQuestions) {
        multipleChoiceContentModels.add(
          MultipleChoiceContentModel(
            quizCategory: category,
            quizId: quizId,
            questionCardContent: LanguagesQuestionCard(
              question: question.question,
              quote: question.quote,
              languageCode: question.languageCode,
            ),
            answerOptions: question.answers,
            pointsPerQuestion: pointsPerQuestion,
            hint: question.hint,
            hintMinus: hintMinus,
            explanation: question.explanation,
          ),
        );
      }
      if (context.mounted) {
        Navigator.of(context).pushNamed(routes.multipleChoice, arguments: multipleChoiceContentModels);
      }
      break;
    case Category.countryBorders:
      List<CountryBordersQuestionModel> countryBordersQuestions =
          await _fetchQuestions(category, quizId) as List<CountryBordersQuestionModel>;

      List<MultipleChoiceContentModel> multipleChoiceContentModels = [];

      for (var question in countryBordersQuestions) {
        multipleChoiceContentModels.add(
          MultipleChoiceContentModel(
            quizCategory: category,
            quizId: quizId,
            questionCardContent: CountryBorderQuestionCard(
              question: question.question,
              imageUrl: question.image_url,
            ),
            answerOptions: question.answers,
            pointsPerQuestion: pointsPerQuestion,
            hint: question.hint,
            hintMinus: hintMinus,
            explanation: question.explanation,
          ),
        );
      }
      if (context.mounted) {
        Navigator.of(context).pushNamed(routes.multipleChoice, arguments: multipleChoiceContentModels);
      }
      break;
    case Category.geoPosition:
      List<GeoPositionQuestionModel> geoPositionsQuestions =
          await _fetchQuestions(category, quizId) as List<GeoPositionQuestionModel>;

      List<MapContentModel> mapContentModels = [];

      for (var question in geoPositionsQuestions) {
        mapContentModels.add(
          MapContentModel(
            quizCategory: category,
            quizId: quizId,
            question: question.question,
            latitude: question.latitude,
            longitude: question.longitude,
            allowedKmDifference: question.allowedKmDifference,
            pointsPerQuestion: pointsPerQuestion,
            hint: question.hint,
            hintMinus: hintMinus,
          ),
        );
      }
      if (context.mounted) {
        Navigator.of(context).pushNamed(routes.map, arguments: mapContentModels);
      }
      break;
  }
}
