import 'package:flutter/material.dart';
import 'package:learn_europe/constants/colors.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/constants/strings.dart';
import 'package:learn_europe/constants/textstyles.dart';

class QuizCard extends StatelessWidget {
  const QuizCard(
      {super.key,
      required this.title,
      required this.numberOfTotalQuestions,
      this.lastPlaythrough,
      this.numberOfCorrectQuestions});

  final String title;
  final DateTime? lastPlaythrough;
  final int numberOfTotalQuestions;
  final int? numberOfCorrectQuestions;

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;

    return Container(
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
    );
  }

  Widget _buildDetailsArea(Brightness brightness) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.numbers,
              color: AppTextStyles.quizCardDetailsTextStyle(brightness).color,
              size: AppTextStyles.quizCardDetailsTextStyle(brightness).fontSize!.toDouble() + 2,
            ),
            const SizedBox(width: AppPaddings.padding_4),
            Text(
              '${numberOfTotalQuestions.toString()} Questions',
              style: AppTextStyles.quizCardDetailsTextStyle(brightness),
            ),
          ],
        ),
        const SizedBox(height: AppPaddings.padding_4),
        Row(
          children: [
            Icon(
              Icons.stacked_line_chart,
              color: AppTextStyles.quizCardDetailsTextStyle(brightness).color,
              size: AppTextStyles.quizCardDetailsTextStyle(brightness).fontSize!.toDouble() + 2,
            ),
            const SizedBox(width: AppPaddings.padding_4),
            Text(
              'Beginner Level',
              style: AppTextStyles.quizCardDetailsTextStyle(brightness),
            ),
          ],
        ),
        const SizedBox(height: AppPaddings.padding_4),
        Row(
          children: [
            Icon(
              Icons.update,
              color: AppTextStyles.quizCardDetailsTextStyle(brightness).color,
              size: AppTextStyles.quizCardDetailsTextStyle(brightness).fontSize!.toDouble() + 2,
            ),
            const SizedBox(width: AppPaddings.padding_4),
            Text(
              AppStrings.getDateTimeText(lastPlaythrough),
              style: AppTextStyles.quizCardDetailsTextStyle(brightness),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsArea(Brightness brightness) {
    return Column(
      children: [
        const SizedBox(height: AppPaddings.padding_16),
        const Divider(height: 0, thickness: 0.5, color: Colors.grey),
        const SizedBox(height: AppPaddings.padding_16),
        Text('Crazy Stats'),
      ],
    );
  }
}
