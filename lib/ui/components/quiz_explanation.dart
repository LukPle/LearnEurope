import 'package:flutter/material.dart';
import 'package:learn_europe/constants/colors.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/constants/strings.dart';
import 'package:learn_europe/constants/textstyles.dart';
import 'package:learn_europe/ui/components/cta_button.dart';

class ExplanationArea extends StatelessWidget {
  const ExplanationArea({
    super.key,
    required this.isCorrect,
    required this.explanationText,
    required this.action,
    this.isMinHeight = false,
  });

  final bool isCorrect;
  final String explanationText;
  final VoidCallback action;
  final bool isMinHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: isMinHeight ? MainAxisSize.min : MainAxisSize.max,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isCorrect ? Icons.check_circle : Icons.cancel,
                  color: isCorrect ? AppColors.success : AppColors.error,
                ),
                const SizedBox(width: AppPaddings.padding_4),
                Text(
                  isCorrect ? AppStrings.correctAnswer : AppStrings.wrongAnswer,
                  style: AppTextStyles.standardTitleTextStyle.copyWith(
                    color: isCorrect ? AppColors.success : AppColors.error,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppPaddings.padding_8),
            Text(explanationText),
          ],
        ),
        const SizedBox(height: AppPaddings.padding_24),
        CtaButton.primary(onPressed: () => action(), label: AppStrings.continueButton),
      ],
    );
  }
}
