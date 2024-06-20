import 'package:flutter/material.dart';
import 'package:learn_europe/constants/colors.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/constants/strings.dart';
import 'package:learn_europe/ui/components/app_appbar.dart';
import 'package:learn_europe/ui/components/app_scaffold.dart';
import 'package:learn_europe/ui/components/hint_dialog.dart';
import 'package:learn_europe/constants/routes.dart' as routes;

class MultipleChoiceScreen extends StatefulWidget {
  const MultipleChoiceScreen({
    super.key,
    required this.questionCardContent,
    required this.answerOptions,
  });

  final Widget questionCardContent;
  final List<String> answerOptions;

  @override
  MultipleChoiceScreenState createState() => MultipleChoiceScreenState();
}

class MultipleChoiceScreenState extends State<MultipleChoiceScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppAppBar(
        title: AppStrings.exitQuiz,
        centerTitle: false,
        leadingIcon: Icons.close,
        leadingIconAction: () => {
          Navigator.of(context).pop(routes.tabSelector),
        },
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppPaddings.padding_16),
            child: GestureDetector(
              onTap: () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const HintDialog(scoreReduction: -25, hint: 'THE HINT');
                  }),
              child: const Icon(Icons.question_mark),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _buildMultipleChoiceQuestionCard(
              child: widget.questionCardContent,
            ),
          ),
          const SizedBox(height: AppPaddings.padding_32),
          GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 2 / 1.65,
            mainAxisSpacing: AppPaddings.padding_16,
            crossAxisSpacing: AppPaddings.padding_16,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: List.generate(4, (index) {
              return _buildMultipleChoiceAnswerCard(child: Text(widget.answerOptions[index]), index: index);
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildMultipleChoiceQuestionCard({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: MediaQuery.of(context).platformBrightness == Brightness.light ? AppColors.lightCard : AppColors.darkCard,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black12),
      ),
      padding: const EdgeInsets.all(AppPaddings.padding_16),
      child: Center(
        child: child,
      ),
    );
  }

  Widget _buildMultipleChoiceAnswerCard({required Widget child, required int index}) {
    return GestureDetector(
      onTap: () => {
        print('Click $index'),
      },
      child: Container(
        decoration: BoxDecoration(
          color:
              MediaQuery.of(context).platformBrightness == Brightness.light ? AppColors.lightCard : AppColors.darkCard,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 1,
              offset: const Offset(0.5, 1.5),
            ),
          ],
        ),
        padding: const EdgeInsets.all(AppPaddings.padding_8),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
