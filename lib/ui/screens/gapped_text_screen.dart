import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:learn_europe/constants/colors.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/constants/strings.dart';
import 'package:learn_europe/constants/textstyles.dart';
import 'package:learn_europe/models/gapped_text_content_model.dart';
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
  const GappedTextScreen({super.key, required this.gappedTextContentModel});

  final List<GappedTextContentModel> gappedTextContentModel;

  @override
  GappedTextScreenState createState() => GappedTextScreenState();
}

class GappedTextScreenState extends State<GappedTextScreen> {
  QuestionStore questionStore = QuestionStore();
  HintDialogStore hintDialogStore = HintDialogStore();
  List<TextEditingController> controllers = [];
  List<bool> areAnswersCorrect = [];

  void _generateAttributes() {
    controllers = List.generate(widget.gappedTextContentModel[questionStore.numbQuestion].correctAnswers.length,
        (index) => TextEditingController());
    areAnswersCorrect = List.generate(
        widget.gappedTextContentModel[questionStore.numbQuestion].correctAnswers.length, (index) => false);
  }

  @override
  void initState() {
    super.initState();
    _generateAttributes();
  }

  @override
  void dispose() {
    for (var controller in controllers) {
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
        leadingIconAction: () => Navigator.canPop(context)
            ? Navigator.of(context).pop(routes.tabSelector)
            : Navigator.of(context).pushNamed(routes.tabSelector),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppPaddings.padding_16),
            child: GestureDetector(
              onTap: () => showDialog(
                context: context,
                builder: (BuildContext context) {
                  return HintDialog(
                    hintDialogStore: hintDialogStore,
                    scoreReduction: widget.gappedTextContentModel[questionStore.numbQuestion].hintMinus,
                    hint: widget.gappedTextContentModel[questionStore.numbQuestion].hint,
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
                numbQuestions: widget.gappedTextContentModel.length,
                currentQuestion: questionStore.numbQuestion + 1,
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
                      textWithGaps: widget.gappedTextContentModel[questionStore.numbQuestion].gappedText,
                      controllers: controllers,
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
                        explanationText: widget.gappedTextContentModel[questionStore.numbQuestion].explanation,
                        action: () => _proceedQuizOrShowResult(),
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
    for (int i = 0; i < widget.gappedTextContentModel[questionStore.numbQuestion].correctAnswers.length; i++) {
      if (controllers[i].text.trim().toLowerCase() !=
          widget.gappedTextContentModel[questionStore.numbQuestion].correctAnswers[i].trim().toLowerCase()) {
        areAnswersCorrect[i] = false;
      } else {
        areAnswersCorrect[i] = true;
      }
    }
    questionStore.setExplained();
  }

  void _proceedQuizOrShowResult() {
    if (widget.gappedTextContentModel.length > (questionStore.numbQuestion + 1)) {
      questionStore.nextQuestion();
      questionStore.setUnexplained();
      hintDialogStore.resetHint();
      _generateAttributes();
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(routes.tabSelector, (Route<dynamic> route) => false);
    }
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
