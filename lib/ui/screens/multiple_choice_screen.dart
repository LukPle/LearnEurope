import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:learn_europe/constants/colors.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/constants/strings.dart';
import 'package:learn_europe/models/multiple_choice_content_model.dart';
import 'package:learn_europe/models/result_content_model.dart';
import 'package:learn_europe/stores/hint_dialog_store.dart';
import 'package:learn_europe/stores/question_store.dart';
import 'package:learn_europe/ui/components/app_appbar.dart';
import 'package:learn_europe/ui/components/app_scaffold.dart';
import 'package:learn_europe/ui/components/hint_dialog.dart';
import 'package:learn_europe/ui/components/quiz_progress_bar.dart';
import 'package:learn_europe/constants/routes.dart' as routes;

class MultipleChoiceScreen extends StatefulWidget {
  const MultipleChoiceScreen({super.key, required this.multipleChoiceContentModel});

  final List<MultipleChoiceContentModel> multipleChoiceContentModel;

  @override
  MultipleChoiceScreenState createState() => MultipleChoiceScreenState();
}

class MultipleChoiceScreenState extends State<MultipleChoiceScreen> {
  final QuestionStore questionStore = QuestionStore();
  final HintDialogStore hintDialogStore = HintDialogStore();
  int score = 0;

  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.height < 700;

    return Observer(
      builder: (context) {
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
                        return HintDialog(
                          hintDialogStore: hintDialogStore,
                          scoreReduction: widget.multipleChoiceContentModel[questionStore.numbQuestion].hintMinus,
                          hint: widget.multipleChoiceContentModel[questionStore.numbQuestion].hint,
                        );
                      }),
                  child: const Icon(Icons.question_mark),
                ),
              ),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              QuizProgressBar(
                numbQuestions: widget.multipleChoiceContentModel.length,
                currentQuestion: questionStore.numbQuestion + 1,
              ),
              const SizedBox(height: AppPaddings.padding_32),
              Expanded(
                child: _buildMultipleChoiceQuestionCard(
                  child: widget.multipleChoiceContentModel[questionStore.numbQuestion].questionCardContent,
                ),
              ),
              const SizedBox(height: AppPaddings.padding_32),
              GridView.count(
                crossAxisCount: 2,
                childAspectRatio: isSmallScreen ? (2 / 1.25) : (2 / 1.65),
                mainAxisSpacing: AppPaddings.padding_16,
                crossAxisSpacing: AppPaddings.padding_16,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(4, (index) {
                  return _buildMultipleChoiceAnswerCard(
                    child: Text(
                      widget.multipleChoiceContentModel[questionStore.numbQuestion].shuffledAnswerOptions[index],
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: questionStore.isAnswered
                            ? Colors.white
                            : MediaQuery.of(context).platformBrightness == Brightness.light
                                ? Colors.black
                                : Colors.white,
                      ),
                    ),
                    correctAnswer: widget.multipleChoiceContentModel[questionStore.numbQuestion].correctAnswer,
                    index: index,
                  );
                }),
              ),
            ],
          ),
        );
      },
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

  Widget _buildMultipleChoiceAnswerCard({required Widget child, required correctAnswer, required int index}) {
    return GestureDetector(
      onTap: () => {
        questionStore.setAnswered(),
        if (widget.multipleChoiceContentModel[questionStore.numbQuestion].shuffledAnswerOptions[index] == correctAnswer)
          {
            if (hintDialogStore.isHintRevealed)
              {
                score += (widget.multipleChoiceContentModel[questionStore.numbQuestion].pointsPerQuestion +
                    widget.multipleChoiceContentModel[questionStore.numbQuestion].hintMinus),
              }
            else
              {
                score += widget.multipleChoiceContentModel[questionStore.numbQuestion].pointsPerQuestion,
              }
          },
        Future.delayed(const Duration(seconds: 3), () {
          if (widget.multipleChoiceContentModel.length > (questionStore.numbQuestion + 1)) {
            hintDialogStore.resetHint();
            questionStore.setUnanswered();
            questionStore.nextQuestion();
          } else {
            Navigator.of(context).pushNamedAndRemoveUntil(
              routes.result,
              (Route<dynamic> route) => false,
              arguments: ResultContentModel(
                numbQuestions: widget.multipleChoiceContentModel.length,
                earnedScore: score,
                availableScore: (widget.multipleChoiceContentModel.length *
                    widget.multipleChoiceContentModel.first.pointsPerQuestion),
              ),
            );
          }
        }),
      },
      child: Container(
        decoration: BoxDecoration(
          color: questionStore.isAnswered
              ? widget.multipleChoiceContentModel[questionStore.numbQuestion].shuffledAnswerOptions[index] ==
                      correctAnswer
                  ? AppColors.success
                  : AppColors.error
              : MediaQuery.of(context).platformBrightness == Brightness.light
                  ? AppColors.lightCard
                  : AppColors.darkCard,
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
