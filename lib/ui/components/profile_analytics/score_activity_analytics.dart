import 'package:flutter/material.dart';
import 'package:learn_europe/constants/colors.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/constants/strings.dart';
import 'package:learn_europe/constants/textstyles.dart';

class ScoreAndActivityAnalytics extends StatelessWidget {
  const ScoreAndActivityAnalytics({super.key, required this.totalPoints, required this.activeDays});

  final int? totalPoints;
  final int? activeDays;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPaddings.padding_4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ScoreAndActivityAnalyticsItem(
              upperComponent: Text(
                totalPoints != null ? totalPoints.toString() : '/',
                style: TextStyle(
                  fontSize: 24,
                  color: MediaQuery.of(context).platformBrightness == Brightness.light
                      ? AppColors.primaryColorLight
                      : AppColors.primaryColorDark,
                  fontWeight: FontWeight.w500,
                ),
              ),
              lowerComponent: const Text(
                AppStrings.totalPointsAnalytics,
                style: AppTextStyles.scoreAndActivityTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(width: AppPaddings.padding_12),
          Expanded(
            child: ScoreAndActivityAnalyticsItem(
              upperComponent: Icon(
                Icons.local_fire_department_rounded,
                size: MediaQuery.of(context).size.width * 0.085,
                color: AppColors.activityFlameColors[1],
              ),
              lowerComponent: Text(
                AppStrings.activityAnalytics(activeDays != null ? activeDays! : 1),
                style: AppTextStyles.scoreAndActivityTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ScoreAndActivityAnalyticsItem extends StatelessWidget {
  const ScoreAndActivityAnalyticsItem({super.key, required this.upperComponent, required this.lowerComponent});

  final Widget upperComponent;
  final Widget lowerComponent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.125,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 1,
          color: MediaQuery.of(context).platformBrightness == Brightness.light
              ? Colors.grey.shade400
              : Colors.grey.shade600,
        ),
      ),
      padding: const EdgeInsets.all(AppPaddings.padding_4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          upperComponent,
          const SizedBox(height: AppPaddings.padding_8),
          lowerComponent,
        ],
      ),
    );
  }
}
