import 'package:flutter/material.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/constants/strings.dart';
import 'package:learn_europe/models/multiple_choice_content_model.dart';
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
          CtaButton.primary(onPressed: () => _navigateToResult(context), label: 'Go to Result Screen'),
        ],
      ),
    );
  }

  void _navigateToCountryBordersMultipleChoice(BuildContext context) {
    List<MultipleChoiceContentModel> multipleChoiceContentModels = [];
    multipleChoiceContentModels.add(
      MultipleChoiceContentModel(
          questionCardContent: const CountryBorderQuestionCard(
              question: 'Which country can be seen here',
              imageUrl: 'https://i.pinimg.com/originals/de/cd/15/decd15e39360f7ba7acd4077b79912de.gif'),
          answerOptions: ['Germany', 'Serbia', 'Croatia', 'Spain'],
          hint: 'THE HINT'),
    );
    Navigator.of(context).pushNamed(routes.multipleChoice, arguments: multipleChoiceContentModels);
  }

  void _navigateToLanguagesMultipleChoice(BuildContext context) {
    List<MultipleChoiceContentModel> multipleChoiceContentModels = [];
    multipleChoiceContentModels.add(
      MultipleChoiceContentModel(
          questionCardContent: const LanguagesQuestionCard(),
          answerOptions: ['Spanish', 'Portuguese', 'Greece', 'Danish'],
          hint: 'THE HINT'),
    );
    Navigator.of(context).pushNamed(routes.multipleChoice, arguments: multipleChoiceContentModels);
  }

  void _navigateToDragAnDrop(BuildContext context) {
    Navigator.of(context).pushNamed(routes.dragAndDrop);
  }

  void _navigateToResult(BuildContext context) {
    Navigator.of(context).pushNamed(routes.result);
  }
}
