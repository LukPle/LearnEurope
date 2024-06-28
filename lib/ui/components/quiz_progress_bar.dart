import 'package:flutter/material.dart';
import 'package:learn_europe/constants/colors.dart';
import 'package:learn_europe/constants/paddings.dart';

class QuizProgressBar extends StatelessWidget {
  const QuizProgressBar({
    super.key,
    required this.numbQuestions,
    required this.currentQuestion,
  });

  final int numbQuestions;
  final int currentQuestion;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(numbQuestions, (index) {
        bool isCompleted = index < currentQuestion;
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: AppPaddings.padding_4),
            height: AppPaddings.padding_8,
            decoration: BoxDecoration(
              color: isCompleted
                  ? MediaQuery.of(context).platformBrightness == Brightness.light
                      ? AppColors.primaryColorLight
                      : AppColors.primaryColorDark
                  : Colors.white,
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }),
    );
  }
}
