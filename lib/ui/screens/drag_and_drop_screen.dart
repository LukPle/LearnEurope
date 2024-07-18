import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:learn_europe/constants/colors.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/constants/strings.dart';
import 'package:learn_europe/constants/textstyles.dart';
import 'package:learn_europe/models/drag_and_drop_content_model.dart';
import 'package:learn_europe/models/result_content_model.dart';
import 'package:learn_europe/stores/drag_and_drop_store.dart';
import 'package:learn_europe/stores/hint_dialog_store.dart';
import 'package:learn_europe/stores/question_store.dart';
import 'package:learn_europe/ui/components/app_appbar.dart';
import 'package:learn_europe/ui/components/app_scaffold.dart';
import 'package:learn_europe/ui/components/cta_button.dart';
import 'package:learn_europe/ui/components/dashed_border_container.dart';
import 'package:learn_europe/ui/components/hint_dialog.dart';
import 'package:learn_europe/ui/components/list_fading_shader.dart';
import 'package:learn_europe/ui/components/quiz_explanation.dart';
import 'package:learn_europe/constants/routes.dart' as routes;

class DragAndDropScreen extends StatefulWidget {
  const DragAndDropScreen({super.key, required this.dragAndDropContentModel});

  final List<DragAndDropContentModel> dragAndDropContentModel;

  @override
  DragAndDropScreenState createState() => DragAndDropScreenState();
}

class DragAndDropScreenState extends State<DragAndDropScreen> {
  final questionStore = QuestionStore();
  final dragAndDropStore = DragAndDropStore();
  final hintDialogStore = HintDialogStore();

  bool isCorrectlyAnswered = false;
  int score = 0;

  void _addAvailableDragAndDropItems() {
    final answerOptions = widget.dragAndDropContentModel[questionStore.numbQuestion].shuffledAnswerOptions;
    for (var option in answerOptions) {
      dragAndDropStore.addAvailableItem(DraggableItem(
        text: option,
        questionStore: questionStore,
        isCorrect: widget.dragAndDropContentModel[questionStore.numbQuestion].correctAnswerOptions.contains(option),
      ));
    }
  }

  void _resetDragAndDropItems() {
    List<Widget> selectedItemsList = List.of(dragAndDropStore.selectedItems);
    List<Widget> availableItemsList = List.of(dragAndDropStore.availableItems);

    for (var item in selectedItemsList) {
      dragAndDropStore.removeSelectedItem(item);
    }

    for (var item in availableItemsList) {
      dragAndDropStore.removeAvailableItem(item);
    }
  }

  @override
  void initState() {
    super.initState();
    _addAvailableDragAndDropItems();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return AppScaffold(
          appBar: AppAppBar(
            title: AppStrings.exitQuiz,
            centerTitle: false,
            leadingIcon: Icons.close,
            leadingIconAction: () => {
              Navigator.canPop(context)
                  ? Navigator.of(context).pop(routes.tabSelector)
                  : Navigator.of(context).pushNamed(routes.tabSelector),
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
                          scoreReduction: widget.dragAndDropContentModel[questionStore.numbQuestion].hintMinus,
                          hint: widget.dragAndDropContentModel[questionStore.numbQuestion].hint,
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
              _buildQuestionCard(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.dragAndDropContentModel[questionStore.numbQuestion].question,
                      style: AppTextStyles.questionTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppPaddings.padding_8),
                    Text('${dragAndDropStore.selectedItems.length} items selected'),
                    const SizedBox(height: AppPaddings.padding_32),
                    DashedBorderContainer(
                      height: MediaQuery.of(context).size.height * 0.255,
                      backgroundColor: MediaQuery.of(context).platformBrightness == Brightness.light
                          ? AppColors.lightBackground
                          : AppColors.darkBackground,
                      borderColor: MediaQuery.of(context).platformBrightness == Brightness.light
                          ? Colors.black38
                          : Colors.white60,
                      borderRadius: 10,
                      child: DragTarget<Widget>(
                        builder: (context, candidateData, acceptedData) {
                          return Observer(
                            builder: (context) {
                              return dragAndDropStore.selectedItems.isEmpty
                                  ? const Center(
                                      child: Text(AppStrings.selectionPane),
                                    )
                                  : ListView.builder(
                                      padding: const EdgeInsets.all(AppPaddings.padding_12),
                                      itemCount: dragAndDropStore.selectedItems.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(bottom: AppPaddings.padding_8),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(child: dragAndDropStore.selectedItems[index]),
                                              questionStore.isExplained
                                                  ? Row(
                                                      children: [
                                                        const SizedBox(
                                                          width: AppPaddings.padding_8,
                                                        ),
                                                        Icon(
                                                          widget.dragAndDropContentModel[questionStore.numbQuestion]
                                                                  .correctAnswerOptions
                                                                  .contains((dragAndDropStore.selectedItems[index]
                                                                          as DraggableItem)
                                                                      .text)
                                                              ? Icons.check_circle
                                                              : Icons.cancel,
                                                          color: widget
                                                                  .dragAndDropContentModel[questionStore.numbQuestion]
                                                                  .correctAnswerOptions
                                                                  .contains((dragAndDropStore.selectedItems[index]
                                                                          as DraggableItem)
                                                                      .text)
                                                              ? AppColors.success
                                                              : AppColors.error,
                                                        ),
                                                      ],
                                                    )
                                                  : const SizedBox.shrink(),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                            },
                          );
                        },
                        onWillAcceptWithDetails: (details) =>
                            questionStore.isAnswered ? false : !dragAndDropStore.selectedItems.contains(details.data),
                        onAcceptWithDetails: (details) => {
                          dragAndDropStore.addSelectedItem(details.data),
                          dragAndDropStore.removeAvailableItem(details.data),
                        },
                      ),
                    ),
                  ],
                ),
              ),
              questionStore.isExplained ? const SizedBox(height: AppPaddings.padding_32) : const Spacer(),
              questionStore.isExplained
                  ? Expanded(
                      child: ExplanationArea(
                        isCorrect: isCorrectlyAnswered,
                        explanationText: widget.dragAndDropContentModel[questionStore.numbQuestion].explanation,
                        action: () => _navigateToNextQuestionOrResult(),
                      ),
                    )
                  : Flexible(
                      flex: 5,
                      child: DragTarget<Widget>(
                        builder: (context, candidateData, acceptedData) {
                          return Observer(
                            builder: (context) {
                              return ListFadingShaderWidget(
                                color: MediaQuery.of(context).platformBrightness == Brightness.light
                                    ? AppColors.lightBackground
                                    : AppColors.darkBackground,
                                child: GridView.builder(
                                  scrollDirection: Axis.vertical,
                                  padding: const EdgeInsets.symmetric(vertical: AppPaddings.padding_8),
                                  itemCount: dragAndDropStore.availableItems.length,
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: 1.65,
                                    crossAxisSpacing: AppPaddings.padding_8,
                                    mainAxisSpacing: AppPaddings.padding_8,
                                  ),
                                  itemBuilder: (context, index) {
                                    return dragAndDropStore.availableItems[index];
                                  },
                                ),
                              );
                            },
                          );
                        },
                        onWillAcceptWithDetails: (details) =>
                            questionStore.isAnswered ? false : !dragAndDropStore.availableItems.contains(details.data),
                        onAcceptWithDetails: (details) => {
                          dragAndDropStore.addAvailableItem(details.data),
                          dragAndDropStore.removeSelectedItem(details.data),
                        },
                      ),
                    ),
              if (!questionStore.isExplained) const Spacer(),
              if (!questionStore.isExplained)
                CtaButton.primary(
                  onPressed: dragAndDropStore.selectedItems.isEmpty
                      ? null
                      : questionStore.isAnswered
                          ? null
                          : () => {
                                questionStore.setAnswered(),
                                if (_isSelectionCorrect(
                                    widget.dragAndDropContentModel[questionStore.numbQuestion].correctAnswerOptions,
                                    dragAndDropStore.selectedItems
                                        .map((item) => (item as DraggableItem).text)
                                        .toList()))
                                  {
                                    isCorrectlyAnswered = true,
                                    _calculateScore(),
                                  },
                                Future.delayed(const Duration(seconds: 3), () {
                                  questionStore.setExplained();
                                }),
                              },
                  label: AppStrings.submitSelectionButton,
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildQuestionCard({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: MediaQuery.of(context).platformBrightness == Brightness.light ? AppColors.lightCard : AppColors.darkCard,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black12),
      ),
      padding: const EdgeInsets.all(AppPaddings.padding_24),
      child: Center(
        child: child,
      ),
    );
  }

  bool _isSelectionCorrect(List<String> correctAnswers, List<String> selectedAnswers) {
    if (correctAnswers.isEmpty && selectedAnswers.isEmpty) {
      return true;
    } else if (correctAnswers.length == selectedAnswers.length) {
      final bool isSame = correctAnswers.every(
        (e1) {
          return selectedAnswers.any(
            (e2) {
              return e1 == e2;
            },
          );
        },
      );

      return isSame;
    } else {
      return false;
    }
  }

  void _calculateScore() {
    if (hintDialogStore.isHintRevealed) {
      score += (widget.dragAndDropContentModel[questionStore.numbQuestion].pointsPerQuestion +
          widget.dragAndDropContentModel[questionStore.numbQuestion].hintMinus);
    } else {
      score += widget.dragAndDropContentModel[questionStore.numbQuestion].pointsPerQuestion;
    }
  }

  void _navigateToNextQuestionOrResult() {
    if (widget.dragAndDropContentModel.length > (questionStore.numbQuestion + 1)) {
      isCorrectlyAnswered = false;
      _resetDragAndDropItems();
      hintDialogStore.resetHint();
      questionStore.setUnanswered();
      questionStore.setUnexplained();
      questionStore.nextQuestion();
      _addAvailableDragAndDropItems();
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(
        routes.result,
        (Route<dynamic> route) => false,
        arguments: ResultContentModel(
          quizCategory: widget.dragAndDropContentModel.first.quizCategory,
          quizId: widget.dragAndDropContentModel.first.quizId,
          quizDifficulty: widget.dragAndDropContentModel.first.quizDifficulty,
          numbQuestions: widget.dragAndDropContentModel.length,
          earnedScore: score,
          availableScore:
              (widget.dragAndDropContentModel.length * widget.dragAndDropContentModel.first.pointsPerQuestion),
          hintMinus: widget.dragAndDropContentModel.first.hintMinus,
        ),
      );
    }
  }
}

class DraggableItem extends StatelessWidget {
  const DraggableItem({
    super.key,
    required this.text,
    required this.questionStore,
    required this.isCorrect,
  });

  final QuestionStore questionStore;
  final String text;
  final bool isCorrect;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Draggable<Widget>(
          key: Key(text),
          data: this,
          feedback: Material(
            borderRadius: BorderRadius.circular(15),
            child: _buildContentContainer(context),
          ),
          childWhenDragging: const SizedBox.shrink(),
          child: _buildContentContainer(context),
        );
      },
    );
  }

  Widget _buildContentContainer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPaddings.padding_8),
      decoration: BoxDecoration(
        color: questionStore.isAnswered
            ? isCorrect
                ? AppColors.success
                : AppColors.error
            : MediaQuery.of(context).platformBrightness == Brightness.light
                ? AppColors.accentColorLight
                : AppColors.accentColorDark,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(text,
          style: TextStyle(
            color: questionStore.isAnswered ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
          ),
          overflow: TextOverflow.fade),
    );
  }
}
