import 'package:flutter/material.dart';
import 'package:learn_europe/constants/colors.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/constants/strings.dart';
import 'package:learn_europe/constants/textstyles.dart';
import 'package:learn_europe/models/enums/difficulties_enum.dart';

class QuizCard extends StatelessWidget {
  const QuizCard({
    super.key,
    required this.title,
    required this.onTap,
    required this.quizDifficulty,
    required this.numberOfTotalQuestions,
    required this.pointsPerQuestion,
    this.lastPlaythrough,
    this.performance,
    this.earnedPoints,
  });

  final String title;
  final VoidCallback onTap;
  final QuizDifficulty quizDifficulty;
  final int numberOfTotalQuestions;
  final int pointsPerQuestion;
  final DateTime? lastPlaythrough;
  final double? performance;
  final int? earnedPoints;

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;

    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: brightness == Brightness.light ? AppColors.lightCard : AppColors.darkCard,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 0.5,
              offset: const Offset(0.5, 0.5),
            ),
          ],
        ),
        padding: const EdgeInsets.all(AppPaddings.padding_16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTextStyles.quizCardTitleTextStyle),
            const SizedBox(height: AppPaddings.padding_4),
            _buildDetailsArea(brightness),
            lastPlaythrough != null ? _buildStatsArea(context, brightness) : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsArea(Brightness brightness) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.stacked_line_chart,
              color: AppTextStyles.thinDetailTextStyle(brightness).color,
              size: AppTextStyles.thinDetailTextStyle(brightness).fontSize!.toDouble() + 2,
            ),
            const SizedBox(width: AppPaddings.padding_4),
            Text(
              AppStrings.getDifficultyText(quizDifficulty),
              style: AppTextStyles.thinDetailTextStyle(brightness),
            ),
          ],
        ),
        const SizedBox(height: AppPaddings.padding_4),
        Row(
          children: [
            Icon(
              Icons.numbers,
              color: AppTextStyles.thinDetailTextStyle(brightness).color,
              size: AppTextStyles.thinDetailTextStyle(brightness).fontSize!.toDouble() + 2,
            ),
            const SizedBox(width: AppPaddings.padding_4),
            Text(
              '${numberOfTotalQuestions.toString()} Questions • ${pointsPerQuestion.toString()} Points each',
              style: AppTextStyles.thinDetailTextStyle(brightness),
            ),
          ],
        ),
        const SizedBox(height: AppPaddings.padding_4),
        Row(
          children: [
            Icon(
              Icons.update,
              color: AppTextStyles.thinDetailTextStyle(brightness).color,
              size: AppTextStyles.thinDetailTextStyle(brightness).fontSize!.toDouble() + 2,
            ),
            const SizedBox(width: AppPaddings.padding_4),
            Text(
              AppStrings.getDateTimeText(lastPlaythrough),
              style: AppTextStyles.thinDetailTextStyle(brightness),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsArea(BuildContext context, Brightness brightness) {
    return Column(
      children: [
        const SizedBox(height: AppPaddings.padding_16),
        const Divider(height: 0, thickness: 0.5, color: Colors.grey),
        const SizedBox(height: AppPaddings.padding_16),
        if (performance != null && earnedPoints != null)
          Row(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.04,
                width: MediaQuery.of(context).size.width * 0.04,
                child: CircularProgressIndicator(
                  value: performance,
                  strokeWidth: 5.5,
                  color: brightness == Brightness.light ? AppColors.primaryColorLight : AppColors.primaryColorDark,
                  backgroundColor: brightness == Brightness.light ? Colors.grey.shade400 : Colors.grey.shade600,
                ),
              ),
              const SizedBox(width: AppPaddings.padding_12),
              Text(
                '${(performance! * 100).ceil().toString()} % correct',
                style: AppTextStyles.thinDetailTextStyle(brightness),
              ),
              const SizedBox(width: AppPaddings.padding_32),
              Text(
                earnedPoints.toString(),
                style: AppTextStyles.standardTitleTextStyle.copyWith(
                  color: brightness == Brightness.light ? AppColors.primaryColorLight : AppColors.primaryColorDark,
                ),
              ),
              const SizedBox(width: AppPaddings.padding_8),
              Text(
                'points earned',
                style: AppTextStyles.thinDetailTextStyle(brightness),
              ),
            ],
          ),
      ],
    );
  }
}
