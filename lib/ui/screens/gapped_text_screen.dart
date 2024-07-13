import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:learn_europe/constants/colors.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/constants/strings.dart';
import 'package:learn_europe/constants/textstyles.dart';
import 'package:learn_europe/stores/hint_dialog_store.dart';
import 'package:learn_europe/stores/question_store.dart';
import 'package:learn_europe/ui/components/app_appbar.dart';
import 'package:learn_europe/ui/components/app_scaffold.dart';
import 'package:learn_europe/ui/components/cta_button.dart';
import 'package:learn_europe/ui/components/hint_dialog.dart';
import 'package:learn_europe/ui/components/quiz_explanation.dart';
import 'package:learn_europe/ui/components/quiz_progress_bar.dart';
import 'package:learn_europe/constants/routes.dart' as routes;

class GappedTextScreen extends StatefulWidget {
  const GappedTextScreen({super.key});

  @override
  GappedTextScreenState createState() => GappedTextScreenState();
}

class GappedTextScreenState extends State<GappedTextScreen> {
  QuestionStore questionStore = QuestionStore();
  HintDialogStore hintDialogStore = HintDialogStore();
  List<TextEditingController> _controllers = [];

  final List<String> correctAnswers = ['vienna', '1920', 'bim'];
  List<bool> areAnswersCorrect = [false, false, false];

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(correctAnswers.length, (index) => TextEditingController());
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppAppBar(
        title: AppStrings.exitQuiz,
        centerTitle: false,
        leadingIcon: Icons.close,
        leadingIconAction: () => Navigator.of(context).pop(routes.tabSelector),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppPaddings.padding_16),
            child: GestureDetector(
              onTap: () => showDialog(
                context: context,
                builder: (BuildContext context) {
                  return HintDialog(
                    hintDialogStore: hintDialogStore,
                    scoreReduction: -10,
                    hint: 'THE HINT',
                  );
                },
              ),
              child: const Icon(Icons.question_mark),
            ),
          ),
        ],
      ),
      body: Observer(
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              QuizProgressBar(
                numbQuestions: 1,
                currentQuestion: 1,
              ),
              const SizedBox(height: AppPaddings.padding_32),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: MediaQuery.of(context).platformBrightness == Brightness.light
                      ? AppColors.lightCard
                      : AppColors.darkCard,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.black12),
                ),
                padding: const EdgeInsets.all(AppPaddings.padding_16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Fill in the gaps',
                      style: AppTextStyles.questionTextStyle,
                    ),
                    const SizedBox(height: AppPaddings.padding_16),
                    GappedTextWidget(
                      textWithGaps:
                          'The capital of Austria is __ which is also its own state in federal republic since __.  Did you know that the tram driving through the city is called __ by the locals.',
                      controllers: _controllers,
                      areFieldCorrect: areAnswersCorrect,
                      isEnabled: !questionStore.isExplained,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppPaddings.padding_16),
              questionStore.isExplained
                  ? Expanded(
                      child: ExplanationArea(
                        isCorrect: areAnswersCorrect.every((element) => element == true),
                        explanationText:
                            'The capital of Austria is Vienna and it became its own federal state in 1920. Locals call the city tram "Bim" because of the sound it makes when honking.',
                        action: () => {},
                      ),
                    )
                  : Expanded(
                      child: Column(
                        children: [
                          const Spacer(),
                          CtaButton.primary(onPressed: _checkAnswers, label: 'Check answers'),
                        ],
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }

  void _checkAnswers() {
    for (int i = 0; i < correctAnswers.length; i++) {
      if (_controllers[i].text.trim().toLowerCase() != correctAnswers[i].trim().toLowerCase()) {
        areAnswersCorrect[i] = false;
      } else {
        areAnswersCorrect[i] = true;
      }
    }
    questionStore.setExplained();
  }
}

class GappedTextWidget extends StatelessWidget {
  const GappedTextWidget({
    super.key,
    required this.textWithGaps,
    required this.controllers,
    required this.areFieldCorrect,
    required this.isEnabled,
  });

  final String textWithGaps;
  final List<TextEditingController> controllers;
  final List<bool> areFieldCorrect;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    List<String> parts = textWithGaps.split('__');
    return Text.rich(
      TextSpan(
        children: [
          for (int i = 0; i < parts.length; i++) ...[
            TextSpan(
              text: parts[i],
              style: const TextStyle(height: 3),
            ),
            if (i < parts.length - 1)
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Baseline(
                  baseline: 17.5,
                  baselineType: TextBaseline.alphabetic,
                  child: Container(
                    width: 85,
                    constraints: const BoxConstraints(maxWidth: 120),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppPaddings.padding_2),
                      child: TextField(
                        enabled: isEnabled,
                        controller: controllers[i],
                        style: isEnabled
                            ? AppTextStyles.gappedTextFieldStyle
                            : AppTextStyles.gappedTextFieldStyle.copyWith(
                                color: areFieldCorrect[i] ? AppColors.success : AppColors.error,
                              ),
                        decoration: const InputDecoration(
                          hintText: '...',
                          isDense: true,
                          contentPadding: EdgeInsets.all(AppPaddings.padding_4),
                          border: UnderlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }
}
