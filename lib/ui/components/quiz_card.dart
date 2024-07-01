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
    this.numberOfCorrectQuestions,
  });

  final String title;
  final VoidCallback onTap;
  final QuizDifficulty quizDifficulty;
  final int numberOfTotalQuestions;
  final int pointsPerQuestion;
  final DateTime? lastPlaythrough;
  final int? numberOfCorrectQuestions;

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
            lastPlaythrough != null ? _buildStatsArea(brightness) : const SizedBox.shrink(),
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

  Widget _buildStatsArea(Brightness brightness) {
    return const Column(
      children: [
        SizedBox(height: AppPaddings.padding_16),
        Divider(height: 0, thickness: 0.5, color: Colors.grey),
        SizedBox(height: AppPaddings.padding_16),
        Text('Crazy Stats'),
      ],
    );
  }
}
