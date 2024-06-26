import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:learn_europe/constants/colors.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/constants/strings.dart';
import 'package:learn_europe/constants/textstyles.dart';
import 'package:learn_europe/models/enums/category_enum.dart';
import 'package:learn_europe/models/enums/quiz_list_filter_enum.dart';
import 'package:learn_europe/models/quiz_model.dart';
import 'package:learn_europe/network/db_services.dart';
import 'package:learn_europe/network/firebase_constants.dart';
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

  Future<List<QuizModel>> _fetchQuizzes() async {
    final DatabaseServices dbServices = DatabaseServices();
    String collection;

    switch (category) {
      case Category.europe101:
        collection = FirebaseConstants.europe101QuizCollection;
      case Category.languages:
        collection = FirebaseConstants.europe101QuizCollection;
      case Category.countryBorders:
        collection = FirebaseConstants.europe101QuizCollection;
      case Category.geoPosition:
        collection = FirebaseConstants.europe101QuizCollection;
    }

    final docs = await dbServices.getAllDocuments(collection: collection);
    return docs.map((doc) => QuizModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
  }

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
            child: FutureBuilder<List<QuizModel>>(
              future: _fetchQuizzes(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showAlertSnackBar(context, AppStrings.loadingError);
                  });
                  return _buildEmptyListComponent(context);
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return _buildEmptyListComponent(context);
                } else {
                  final quizzes = snapshot.data!;
                  return Observer(
                    builder: (context) {
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
                          Expanded(
                            child: ListFadingShaderWidget(
                              color:
                                  brightness == Brightness.light ? AppColors.lightBackground : AppColors.darkBackground,
                              child: ListView.builder(
                                padding: const EdgeInsets.only(top: AppPaddings.padding_12),
                                itemCount: quizzes.length,
                                itemBuilder: (context, index) {
                                  final quiz = quizzes[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: AppPaddings.padding_8),
                                    child: QuizCard(
                                      title: quiz.title,
                                      quizDifficulty: quiz.difficulty,
                                      numberOfTotalQuestions: quiz.questions.length,
                                      pointsPerQuestion: quiz.pointsPerQuestion,
                                      numberOfCorrectQuestions: 0,
                                      lastPlaythrough: DateTime.now(),
                                    ),
                                  );
                                },
                              ),
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

  Widget _buildEmptyListComponent(BuildContext context) {
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
          const Text(AppStrings.noQuizzesAvailable),
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
