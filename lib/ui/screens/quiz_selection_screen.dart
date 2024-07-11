import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:learn_europe/constants/colors.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/constants/strings.dart';
import 'package:learn_europe/constants/textstyles.dart';
import 'package:learn_europe/models/enums/category_enum.dart';
import 'package:learn_europe/models/enums/quiz_list_filter_enum.dart';
import 'package:learn_europe/models/quiz_selection_content_model.dart';
import 'package:learn_europe/network/data_fetching.dart';
import 'package:learn_europe/stores/quiz_selection_filter_store.dart';
import 'package:learn_europe/ui/components/alert_snackbar.dart';
import 'package:learn_europe/ui/components/app_appbar.dart';
import 'package:learn_europe/ui/components/app_scaffold.dart';
import 'package:learn_europe/ui/components/list_fading_shader.dart';
import 'package:learn_europe/ui/components/quiz_card.dart';

class QuizSelectionScreen extends StatelessWidget {
  QuizSelectionScreen({super.key, required this.category});

  final Category category;
  final QuizSelectionFilterStore quizSelectionFilterStore = QuizSelectionFilterStore();

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;

    return AppScaffold(
      appBar: const AppAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.getCategoryText(category),
            style: AppTextStyles.standardTitleTextStyle.copyWith(
              color: AppColors.categoryColor(category, brightness),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<QuizSelectionContentModel>>(
              future: fetchQuizzesWithHistory(category),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showAlertSnackBar(context, AppStrings.quizzesLoadingError, isError: true);
                  });
                  return _buildEmptyListComponent(context, AppStrings.noQuizzesAvailable);
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return _buildEmptyListComponent(context, AppStrings.noQuizzesAvailable);
                } else {
                  final quizzesWithHistory = snapshot.data!;
                  return Observer(
                    builder: (context) {
                      List<QuizSelectionContentModel> filteredQuizzes;
                      switch (quizSelectionFilterStore.quizListFilter) {
                        case QuizListFilter.all:
                          filteredQuizzes = quizzesWithHistory;
                          break;
                        case QuizListFilter.open:
                          filteredQuizzes = quizzesWithHistory.where((quiz) => quiz.quizHistoryModel == null).toList();
                          break;
                        case QuizListFilter.completed:
                          filteredQuizzes = quizzesWithHistory.where((quiz) => quiz.quizHistoryModel != null).toList();
                          break;
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: AppPaddings.padding_24),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () => quizSelectionFilterStore.setQuizListFilter(QuizListFilter.all),
                                child: FilterButton(
                                  text: AppStrings.allQuizzesFilter,
                                  isActive: quizSelectionFilterStore.quizListFilter == QuizListFilter.all,
                                ),
                              ),
                              const SizedBox(width: AppPaddings.padding_8),
                              GestureDetector(
                                onTap: () => quizSelectionFilterStore.setQuizListFilter(QuizListFilter.open),
                                child: FilterButton(
                                  text: AppStrings.openQuizzesFilter,
                                  isActive: quizSelectionFilterStore.quizListFilter == QuizListFilter.open,
                                ),
                              ),
                              const SizedBox(width: AppPaddings.padding_8),
                              GestureDetector(
                                onTap: () => quizSelectionFilterStore.setQuizListFilter(QuizListFilter.completed),
                                child: FilterButton(
                                  text: AppStrings.completedQuizzesFilter,
                                  isActive: quizSelectionFilterStore.quizListFilter == QuizListFilter.completed,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppPaddings.padding_12),
                          filteredQuizzes.isNotEmpty
                              ? Expanded(
                                  child: ListFadingShaderWidget(
                                    color: brightness == Brightness.light
                                        ? AppColors.lightBackground
                                        : AppColors.darkBackground,
                                    child: ListView.builder(
                                      padding: const EdgeInsets.only(top: AppPaddings.padding_12),
                                      itemCount: filteredQuizzes.length,
                                      itemBuilder: (context, index) {
                                        final quiz = filteredQuizzes[index];
                                        return Padding(
                                          padding: const EdgeInsets.only(bottom: AppPaddings.padding_12),
                                          child: QuizCard(
                                            title: quiz.quizModel.title,
                                            onTap: () async => await navigateToQuestions(
                                                context,
                                                category,
                                                quiz.quizModel.id,
                                                quiz.quizModel.pointsPerQuestion,
                                                quiz.quizModel.hintPointsMinus),
                                            quizDifficulty: quiz.quizModel.difficulty,
                                            numberOfTotalQuestions: quiz.quizModel.questions.length,
                                            pointsPerQuestion: quiz.quizModel.pointsPerQuestion,
                                            performance: quiz.quizHistoryModel?.performance,
                                            earnedPoints: quiz.quizHistoryModel?.earnedPoints,
                                            lastPlaythrough: quiz.quizHistoryModel?.completionDate,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                )
                              : Expanded(
                                  child: _buildEmptyListComponent(
                                    context,
                                    quizSelectionFilterStore.quizListFilter == QuizListFilter.all
                                        ? AppStrings.noQuizzesAvailable
                                        : quizSelectionFilterStore.quizListFilter == QuizListFilter.open
                                            ? AppStrings.noOpenQuizzesAvailable
                                            : AppStrings.noCompletedQuizzesAvailable,
                                  ),
                                ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyListComponent(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error,
            size: MediaQuery.of(context).size.width * 0.075,
            color: MediaQuery.of(context).platformBrightness == Brightness.light
                ? AppColors.primaryColorLight
                : AppColors.primaryColorDark,
          ),
          const SizedBox(height: AppPaddings.padding_8),
          Text(message),
        ],
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  const FilterButton({super.key, required this.text, required this.isActive});

  final String text;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isActive
            ? (brightness == Brightness.light ? AppColors.primaryColorLight : AppColors.primaryColorDark)
            : (brightness == Brightness.light ? AppColors.lightCard : AppColors.darkCard),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 0.5,
            offset: const Offset(0.5, 0.5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppPaddings.padding_8,
          horizontal: AppPaddings.padding_12,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isActive
                ? brightness == Brightness.light
                    ? Colors.white
                    : Colors.black
                : null,
            fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
