import 'package:flutter/material.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/constants/strings.dart';
import 'package:learn_europe/models/drag_and_drop_content_model.dart';
import 'package:learn_europe/models/enums/category_enum.dart';
import 'package:learn_europe/models/map_content_model.dart';
import 'package:learn_europe/models/multiple_choice_content_model.dart';
import 'package:learn_europe/models/result_content_model.dart';
import 'package:learn_europe/network/service_locator.dart';
import 'package:learn_europe/stores/user_store.dart';
import 'package:learn_europe/ui/components/multiple_choice_question_cards/country_border_question_card.dart';
import 'package:learn_europe/ui/components/multiple_choice_question_cards/languages_question_card.dart';
import 'package:learn_europe/ui/components/cta_button.dart';
import 'package:learn_europe/ui/components/page_headline.dart';
import 'package:learn_europe/constants/routes.dart' as routes;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPaddings.padding_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeadline(title: AppStrings.homeTitle(getIt<UserStore>().username)),
          const SizedBox(height: AppPaddings.padding_16),
          CtaButton.primary(
            onPressed: () => _navigateToCountryBordersMultipleChoice(context),
            label: 'Go to Country Border Multiple Choice',
          ),
          const SizedBox(height: AppPaddings.padding_16),
          CtaButton.primary(
            onPressed: () => _navigateToLanguagesMultipleChoice(context),
            label: 'Go to Languages Multiple Choice',
          ),
          const SizedBox(height: AppPaddings.padding_16),
          CtaButton.primary(onPressed: () => _navigateToDragAnDrop(context), label: 'Go to Drag and Drop'),
          const SizedBox(height: AppPaddings.padding_16),
          CtaButton.primary(onPressed: () => _navigateToMap(context), label: 'Go to Map'),
          const SizedBox(height: AppPaddings.padding_16),
          CtaButton.primary(onPressed: () => _navigateToResult(context), label: 'Go to Result Screen'),
        ],
      ),
    );
  }

  void _navigateToCountryBordersMultipleChoice(BuildContext context) {
    List<MultipleChoiceContentModel> multipleChoiceContentModels = [];
    multipleChoiceContentModels.add(
      MultipleChoiceContentModel(
          quizCategory: Category.countryBorders,
          quizId: '36rf76f4rf',
          questionCardContent: const CountryBorderQuestionCard(
              question: 'Which country can be seen here',
              imageUrl: 'https://i.pinimg.com/originals/de/cd/15/decd15e39360f7ba7acd4077b79912de.gif'),
          answerOptions: ['Germany', 'Serbia', 'Croatia', 'Spain'],
          pointsPerQuestion: 20,
          hint: 'THE HINT',
          hintMinus: -10,
          explanation: 'I love this country.'),
    );
    Navigator.of(context).pushNamed(routes.multipleChoice, arguments: multipleChoiceContentModels);
  }

  void _navigateToLanguagesMultipleChoice(BuildContext context) {
    List<MultipleChoiceContentModel> multipleChoiceContentModels = [];
    multipleChoiceContentModels.add(
      MultipleChoiceContentModel(
          quizCategory: Category.languages,
          quizId: 'jg8zifztdf',
          questionCardContent: const LanguagesQuestionCard(
            question: 'What language is this?',
            quote: '"Estar en las nubes"',
            languageCode: 'es-ES',
          ),
          answerOptions: ['Spanish', 'Portuguese', 'Greece', 'Danish'],
          pointsPerQuestion: 40,
          hint: 'THE HINT',
          hintMinus: -20,
          explanation: 'I love this language'),
    );
    Navigator.of(context).pushNamed(routes.multipleChoice, arguments: multipleChoiceContentModels);
  }

  void _navigateToDragAnDrop(BuildContext context) {
    List<DragAndDropContentModel> dragAndDropContentModels = [];
    dragAndDropContentModels.add(
      DragAndDropContentModel(
          quizCategory: Category.languages,
          quizId: '477b78bffHG',
          question: 'Which of these countries is part of the EU?',
          answerOptions: ['Germany', 'Austria', 'Poland', 'Norway', 'United Kingdom', 'Turkey'],
          numbCorrectAnswers: 3,
          pointsPerQuestion: 40,
          hint: 'THE HINT',
          hintMinus: -20,
          explanation: 'The number of correct states is 3'),
    );
    Navigator.of(context).pushNamed(routes.dragAndDrop, arguments: dragAndDropContentModels);
  }

  void _navigateToMap(BuildContext context) {
    List<MapContentModel> mapContentModels = [];
    mapContentModels.add(
      MapContentModel(
        quizCategory: Category.geoPosition,
        quizId: '477b7thbffHG',
        question: 'Mark the capital of Germany',
        latitude: 52.520008,
        longitude: 13.404954,
        allowedKmDifference: 25,
        hint: 'THE HINT',
        hintMinus: -20,
      ),
    );
    Navigator.of(context).pushNamed(routes.map, arguments: mapContentModels);
  }

  void _navigateToResult(BuildContext context) {
    Navigator.of(context).pushNamed(routes.result,
        arguments: ResultContentModel(
            quizCategory: Category.countryBorders,
            quizId: '3483zrigfigi',
            numbQuestions: 10,
            earnedScore: 50,
            availableScore: 80));
  }
}
