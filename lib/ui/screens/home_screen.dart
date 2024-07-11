import 'dart:math';
import 'package:flutter/material.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/constants/strings.dart';
import 'package:learn_europe/constants/textstyles.dart';
import 'package:learn_europe/models/enums/category_enum.dart';
import 'package:learn_europe/models/enums/difficulties_enum.dart';
import 'package:learn_europe/models/quiz_history_model.dart';
import 'package:learn_europe/models/quiz_model.dart';
import 'package:learn_europe/network/data_fetching.dart';
import 'package:learn_europe/network/db_services.dart';
import 'package:learn_europe/network/firebase_constants.dart';
import 'package:learn_europe/service_locator.dart';
import 'package:learn_europe/stores/user_store.dart';
import 'package:learn_europe/ui/components/cta_button.dart';
import 'package:learn_europe/ui/components/page_headline.dart';
import 'package:learn_europe/ui/components/quiz_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  Category? featuredQuizCategory;
  Category? repeatedQuizCategory;

  Future<QuizModel?> _fetchQuizWithLowestPerformance() async {
    final DatabaseServices dbServices = DatabaseServices();

    final europe101Query = await dbServices.getAllDocuments(collection: FirebaseConstants.europe101HistoryCollection);
    final languagesQuery = await dbServices.getAllDocuments(collection: FirebaseConstants.languagesHistoryCollection);
    final countryBordersQuery =
        await dbServices.getAllDocuments(collection: FirebaseConstants.countryBordersHistoryCollection);
    final geoPositionQuery =
        await dbServices.getAllDocuments(collection: FirebaseConstants.geoPositionHistoryCollection);

    List<QuizHistoryModel> europe101History =
        europe101Query.map((doc) => QuizHistoryModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
    List<QuizHistoryModel> languagesHistory =
        languagesQuery.map((doc) => QuizHistoryModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
    List<QuizHistoryModel> countryBordersHistory =
        countryBordersQuery.map((doc) => QuizHistoryModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
    List<QuizHistoryModel> geoPositionHistory =
        geoPositionQuery.map((doc) => QuizHistoryModel.fromMap(doc.data() as Map<String, dynamic>)).toList();

    List<QuizHistoryModel> allHistory = [
      ...europe101History,
      ...languagesHistory,
      ...countryBordersHistory,
      ...geoPositionHistory,
    ];

    if (allHistory.isEmpty) {
      return null;
    }

    QuizHistoryModel quizWithLowestPerformance = allHistory[0];
    for (int i = 1; i < allHistory.length; i++) {
      if (allHistory[i].performance < quizWithLowestPerformance.performance) {
        quizWithLowestPerformance = allHistory[i];
      } else if (allHistory[i].performance == quizWithLowestPerformance.performance) {
        if (Random().nextBool()) {
          quizWithLowestPerformance = allHistory[i];
        }
      }
    }

    String? quizCollection;

    final europe101QuizQuery = await dbServices.getAllDocuments(collection: FirebaseConstants.europe101QuizCollection);
    if (europe101QuizQuery.any((doc) => doc.id == quizWithLowestPerformance.quizId)) {
      quizCollection = FirebaseConstants.europe101QuizCollection;
      repeatedQuizCategory = Category.europe101;
    }

    final languagesQuizQuery = await dbServices.getAllDocuments(collection: FirebaseConstants.languagesQuizCollection);
    if (languagesQuizQuery.any((doc) => doc.id == quizWithLowestPerformance.quizId)) {
      quizCollection = FirebaseConstants.languagesQuizCollection;
      repeatedQuizCategory = Category.languages;
    }

    final countryBordersQuizQuery =
        await dbServices.getAllDocuments(collection: FirebaseConstants.countryBordersQuizCollection);
    if (countryBordersQuizQuery.any((doc) => doc.id == quizWithLowestPerformance.quizId)) {
      quizCollection = FirebaseConstants.countryBordersQuizCollection;
      repeatedQuizCategory = Category.countryBorders;
    }

    final geoPositionQuizQuery =
        await dbServices.getAllDocuments(collection: FirebaseConstants.geoPositionQuizCollection);
    if (geoPositionQuizQuery.any((doc) => doc.id == quizWithLowestPerformance.quizId)) {
      quizCollection = FirebaseConstants.geoPositionQuizCollection;
      repeatedQuizCategory = Category.geoPosition;
    }

    if (quizCollection == null) {
      return null;
    }

    final quizDoc = await dbServices.getDocument(collection: quizCollection, docId: quizWithLowestPerformance.quizId);
    QuizModel quizModel = QuizModel.fromMap(quizDoc.id, quizDoc.data() as Map<String, dynamic>);
    return quizModel;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPaddings.padding_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeadline(title: AppStrings.homeTitle(getIt<UserStore>().username)),
          const SizedBox(height: AppPaddings.padding_32),
          Text('Today\'s Quiz', style: AppTextStyles.sectionTitleTextStyle),
          const SizedBox(height: AppPaddings.padding_8),
          QuizCard(
            title: 'Quiz',
            onTap: () => {},
            quizDifficulty: QuizDifficulty.beginner,
            numberOfTotalQuestions: 10,
            pointsPerQuestion: 20,
          ),
          const SizedBox(height: AppPaddings.padding_16),
          Text('Try Again?', style: AppTextStyles.sectionTitleTextStyle),
          const SizedBox(height: AppPaddings.padding_8),
          FutureBuilder(
            future: _fetchQuizWithLowestPerformance(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting || snapshot.hasError) {
                return const SizedBox.shrink();
              } else {
                final quiz = snapshot.data!;
                return QuizCard(
                  title: quiz.title,
                  onTap: () => navigateToQuestions(
                    context,
                    repeatedQuizCategory!,
                    quiz.id,
                    quiz.pointsPerQuestion,
                    quiz.hintPointsMinus,
                  ),
                  quizDifficulty: quiz.difficulty,
                  numberOfTotalQuestions: quiz.questions.length,
                  pointsPerQuestion: quiz.pointsPerQuestion,
                );
              }
            },
          ),
          const SizedBox(height: AppPaddings.padding_16),
          Text('Comming Soon', style: AppTextStyles.sectionTitleTextStyle),
          const SizedBox(height: AppPaddings.padding_8),
          CtaButton.primary(onPressed: () => {}, label: 'Gaped Text Questions'),
        ],
      ),
    );
  }
}
