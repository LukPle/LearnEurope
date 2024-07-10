import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:learn_europe/constants/colors.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/constants/strings.dart';
import 'package:learn_europe/constants/textstyles.dart';
import 'package:learn_europe/models/country_borders_question_model.dart';
import 'package:learn_europe/models/drag_and_drop_content_model.dart';
import 'package:learn_europe/models/enums/category_enum.dart';
import 'package:learn_europe/models/enums/quiz_list_filter_enum.dart';
import 'package:learn_europe/models/europe101_question_model.dart';
import 'package:learn_europe/models/geo_position_question_model.dart';
import 'package:learn_europe/models/languages_question_model.dart';
import 'package:learn_europe/models/map_content_model.dart';
import 'package:learn_europe/models/multiple_choice_content_model.dart';
import 'package:learn_europe/models/quiz_history_model.dart';
import 'package:learn_europe/models/quiz_model.dart';
import 'package:learn_europe/models/quiz_selection_content_model.dart';
import 'package:learn_europe/network/db_services.dart';
import 'package:learn_europe/network/firebase_constants.dart';
import 'package:learn_europe/network/service_locator.dart';
import 'package:learn_europe/stores/quiz_selection_filter_store.dart';
import 'package:learn_europe/stores/user_store.dart';
import 'package:learn_europe/ui/components/alert_snackbar.dart';
import 'package:learn_europe/ui/components/app_appbar.dart';
import 'package:learn_europe/ui/components/app_scaffold.dart';
import 'package:learn_europe/ui/components/list_fading_shader.dart';
import 'package:learn_europe/ui/components/multiple_choice_question_cards/country_border_question_card.dart';
import 'package:learn_europe/ui/components/multiple_choice_question_cards/languages_question_card.dart';
import 'package:learn_europe/ui/components/quiz_card.dart';
import 'package:learn_europe/constants/routes.dart' as routes;

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
        collection = FirebaseConstants.languagesQuizCollection;
      case Category.countryBorders:
        collection = FirebaseConstants.countryBordersQuizCollection;
      case Category.geoPosition:
        collection = FirebaseConstants.geoPositionQuizCollection;
    }

    final docs = await dbServices.getAllDocuments(collection: collection);
    return docs.map((doc) => QuizModel.fromMap(doc.id, doc.data() as Map<String, dynamic>)).toList();
  }

  Future<List<QuizHistoryModel>> _fetchQuizHistory() async {
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

  Future<List<QuizSelectionContentModel>> _fetchQuizzesWithHistory() async {
    List<QuizModel> quizzes = await _fetchQuizzes();
    List<QuizHistoryModel> quizHistory = await _fetchQuizHistory();

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

  Future<List<String>> _fetchQuestionList(String quizId) async {
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

  Future<List<dynamic>> _fetchQuestions(String quizId) async {
    final DatabaseServices dbServices = DatabaseServices();
    String collection;

    List<String> questionIds = await _fetchQuestionList(quizId);

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

  Future<void> _navigateToQuestions(BuildContext context, String quizId, int pointsPerQuestion, int hintMinus) async {
    switch (category) {
      case Category.europe101:
        List<Europe101QuestionModel> europe101Questions = await _fetchQuestions(quizId) as List<Europe101QuestionModel>;

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
        List<LanguagesQuestionModel> languagesQuestions = await _fetchQuestions(quizId) as List<LanguagesQuestionModel>;

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
            await _fetchQuestions(quizId) as List<CountryBordersQuestionModel>;

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
            await _fetchQuestions(quizId) as List<GeoPositionQuestionModel>;

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
              future: _fetchQuizzesWithHistory(),
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
                                            onTap: () async => await _navigateToQuestions(context, quiz.quizModel.id,
                                                quiz.quizModel.pointsPerQuestion, quiz.quizModel.hintPointsMinus),
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
