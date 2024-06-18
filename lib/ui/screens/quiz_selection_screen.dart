import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:learn_europe/constants/colors.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/constants/strings.dart';
import 'package:learn_europe/constants/textstyles.dart';
import 'package:learn_europe/models/category_enum.dart';
import 'package:learn_europe/models/quiz_list_filter_enum.dart';
import 'package:learn_europe/stores/quiz_selection_filter_store.dart';
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
    return AppScaffold(
      appBar: const AppAppBar(),
      body: Observer(
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.getCategoryText(category),
                style: AppTextStyles.standardTitleTextStyle.copyWith(
                  color: AppColors.categoryColor(category),
                ),
              ),
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
              Expanded(
                child: ListFadingShaderWidget(
                  color: MediaQuery.of(context).platformBrightness == Brightness.light
                      ? AppColors.lightBackground
                      : AppColors.darkBackground,
                  child: ListView.builder(
                      padding: const EdgeInsets.only(top: AppPaddings.padding_12),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: AppPaddings.padding_8),
                          child: QuizCard(
                            title: 'Quiz Title',
                            numberOfTotalQuestions: 10,
                            numberOfCorrectQuestions: 8,
                            lastPlaythrough: DateTime.now().subtract(
                              const Duration(days: 1),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ],
          );
        },
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
