import 'package:flutter/material.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/models/multiple_choice_content_model.dart';
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
          const PageHeadline(title: "Hello Amiin, let's\n start learning"),
          const SizedBox(height: AppPaddings.padding_16),
          CtaButton.primary(onPressed: () => _navigateToStart(context), label: 'Go to Start'),
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
          CtaButton.primary(onPressed: () => _navigateToResult(context), label: 'Go to Result Screen'),
        ],
      ),
    );
  }

  void _navigateToStart(BuildContext context) {
    Navigator.of(context).pushNamed(routes.start);
  }

  void _navigateToCountryBordersMultipleChoice(BuildContext context) {
    MultipleChoiceContentModel multipleChoiceContentModel = MultipleChoiceContentModel(
        questionCardContent: const CountryBorderQuestionCard(),
        answerOptions: ['Germany', 'Serbia', 'Croatia', 'Spain']);
    Navigator.of(context).pushNamed(routes.multipleChoice, arguments: multipleChoiceContentModel);
  }

  void _navigateToLanguagesMultipleChoice(BuildContext context) {
    MultipleChoiceContentModel multipleChoiceContentModel = MultipleChoiceContentModel(
        questionCardContent: const LanguagesQuestionCard(),
        answerOptions: ['Spanish', 'Portuguese', 'Greece', 'Danish']);
    Navigator.of(context).pushNamed(routes.multipleChoice, arguments: multipleChoiceContentModel);
  }

  void _navigateToDragAnDrop(BuildContext context) {
    Navigator.of(context).pushNamed(routes.dragAndDrop);
  }

  void _navigateToResult(BuildContext context) {
    Navigator.of(context).pushNamed(routes.result);
  }
}
