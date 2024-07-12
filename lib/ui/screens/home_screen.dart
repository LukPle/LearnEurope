import 'package:flutter/material.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/constants/strings.dart';
import 'package:learn_europe/constants/textstyles.dart';
import 'package:learn_europe/network/data_fetching.dart';
import 'package:learn_europe/service_locator.dart';
import 'package:learn_europe/stores/user_store.dart';
import 'package:learn_europe/ui/components/cta_button.dart';
import 'package:learn_europe/ui/components/page_headline.dart';
import 'package:learn_europe/ui/components/quiz_card.dart';
import 'package:learn_europe/ui/components/shimmer_container.dart';
import 'package:learn_europe/constants/routes.dart' as routes;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPaddings.padding_16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PageHeadline(title: AppStrings.homeTitle(getIt<UserStore>().username)),
            const SizedBox(height: AppPaddings.padding_32),
            const Text(AppStrings.featuredNoHistoryQuizSection, style: AppTextStyles.sectionTitleTextStyle),
            const SizedBox(height: AppPaddings.padding_8),
            FutureBuilder(
              future: fetchRandomQuizWithNoHistory(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CustomShimmer();
                } else if (snapshot.hasError || !snapshot.hasData) {
                  return const SizedBox.shrink();
                } else {
                  final quiz = snapshot.data!;
                  return QuizCard(
                    title: quiz.quizModel.title,
                    onTap: () => navigateToQuestions(
                      context,
                      quiz.category,
                      quiz.quizModel.id,
                      quiz.quizModel.difficulty,
                      quiz.quizModel.pointsPerQuestion,
                      quiz.quizModel.hintPointsMinus,
                    ),
                    quizDifficulty: quiz.quizModel.difficulty,
                    numberOfTotalQuestions: quiz.quizModel.questions.length,
                    pointsPerQuestion: quiz.quizModel.pointsPerQuestion,
                    lastPlaythrough: quiz.quizHistoryModel?.completionDate,
                    performance: quiz.quizHistoryModel?.performance,
                    earnedPoints: quiz.quizHistoryModel?.earnedPoints,
                  );
                }
              },
            ),
            const SizedBox(height: AppPaddings.padding_16),
            const Text(AppStrings.featuredLowPerformanceQuizSection, style: AppTextStyles.sectionTitleTextStyle),
            const SizedBox(height: AppPaddings.padding_8),
            FutureBuilder(
              future: fetchQuizWithLowestPerformance(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CustomShimmer();
                } else if (snapshot.hasError || !snapshot.hasData) {
                  return const SizedBox.shrink();
                } else {
                  final quiz = snapshot.data!;
                  return QuizCard(
                    title: quiz.quizModel.title,
                    onTap: () => navigateToQuestions(
                      context,
                      quiz.category,
                      quiz.quizModel.id,
                      quiz.quizModel.difficulty,
                      quiz.quizModel.pointsPerQuestion,
                      quiz.quizModel.hintPointsMinus,
                    ),
                    quizDifficulty: quiz.quizModel.difficulty,
                    numberOfTotalQuestions: quiz.quizModel.questions.length,
                    pointsPerQuestion: quiz.quizModel.pointsPerQuestion,
                    lastPlaythrough: quiz.quizHistoryModel?.completionDate,
                    performance: quiz.quizHistoryModel?.performance,
                    earnedPoints: quiz.quizHistoryModel?.earnedPoints,
                  );
                }
              },
            ),
            const SizedBox(height: AppPaddings.padding_16),
            const Text('Coming Soon', style: AppTextStyles.sectionTitleTextStyle),
            const SizedBox(height: AppPaddings.padding_8),
            CtaButton.primary(onPressed: () => Navigator.of(context).pushNamed(routes.gappedText), label: 'Gapped Text Questions'),
          ],
        ),
      ),
    );
  }
}
