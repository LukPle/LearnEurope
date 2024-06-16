import 'package:flutter/material.dart';
import 'package:learn_europe/constants/colors.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/constants/textstyles.dart';

class LeaderboardCard extends StatelessWidget {
  const LeaderboardCard({super.key, required this.rank, required this.name, required this.points});

  final int rank;
  final String name;
  final int points;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: MediaQuery.of(context).platformBrightness == Brightness.light
            ? AppColors.lightBackground
            : AppColors.darkBackground,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black12),
      ),
      padding: const EdgeInsets.all(AppPaddings.padding_16),
      child: Row(
        children: [
          Text('$rank.', style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(width: AppPaddings.padding_4),
          Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(vertical: AppPaddings.padding_8, horizontal: AppPaddings.padding_12),
            decoration: BoxDecoration(
              color: MediaQuery.of(context).platformBrightness == Brightness.light
                  ? AppColors.primaryColorLight
                  : AppColors.primaryColorDark,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              '${points.toString()} Points',
              style: AppTextStyles.leaderbordCardTextStyle(brightness: MediaQuery.of(context).platformBrightness),
            ),
          ),
        ],
      ),
    );
  }
}
