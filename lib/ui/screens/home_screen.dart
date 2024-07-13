import 'package:flutter/material.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/constants/strings.dart';
import 'package:learn_europe/constants/textstyles.dart';
import 'package:learn_europe/models/gapped_text_content_model.dart';
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
            CtaButton.primary(onPressed: () => _navigateToGappedText(context), label: 'Gapped Text Questions'),
          ],
        ),
      ),
    );
  }

  void _navigateToGappedText(BuildContext context) {
    List<GappedTextContentModel> gappedTextQuestions = [];

    gappedTextQuestions.add(
      GappedTextContentModel(
        gappedText:
            'The capital of Austria is __ which is also its own state in federal republic since __.  Did you know that the tram driving through the city is called __ by the locals.',
        correctAnswers: ['vienna', '1920', 'bim'],
        pointsPerQuestion: 20,
        hint: 'The capital is called Vienna',
        hintMinus: -10,
        explanation:
            'The capital of Austria is Vienna and it became its own federal state in 1920. Locals call the city tram "Bim" because of the sound it makes when honking.',
      ),
    );
    gappedTextQuestions.add(
      GappedTextContentModel(
        gappedText: 'The largest state in Germany in terms of area is __. The capital city of this state is called __.',
        correctAnswers: ['bavaria', 'munich'],
        pointsPerQuestion: 20,
        hint: 'There is a famous soccer club located in the city called FC Bayern München',
        hintMinus: -10,
        explanation:
            'Bavaria is the largest German state in terms of area. Its capital Munich is located in the southern part of the state.',
      ),
    );

    Navigator.of(context).pushNamed(routes.gappedText, arguments: gappedTextQuestions);
  }
}
