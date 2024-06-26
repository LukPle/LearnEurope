import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:learn_europe/constants/colors.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/constants/strings.dart';
import 'package:learn_europe/models/enums/category_enum.dart';

class CategoriesProgressAnalytics extends StatelessWidget {
  const CategoriesProgressAnalytics({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(AppPaddings.padding_8),
      child: Column(
        children: [
          CategoryProgressRow(category: Category.europe101, progress: 0.75),
          SizedBox(height: AppPaddings.padding_16),
          CategoryProgressRow(category: Category.languages, progress: 0.60),
          SizedBox(height: AppPaddings.padding_16),
          CategoryProgressRow(category: Category.countryBorders, progress: 0.45),
          SizedBox(height: AppPaddings.padding_16),
          CategoryProgressRow(category: Category.geoPosition, progress: 0.90),
        ],
      ),
    );
  }
}

class CategoryProgressRow extends StatelessWidget {
  const CategoryProgressRow({super.key, required this.category, required this.progress});

  final Category category;
  final double progress;

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  AppStrings.getCategoryImage(category),
                  width: MediaQuery.of(context).size.width * 0.05,
                  height: MediaQuery.of(context).size.width * 0.05,
                ),
                const SizedBox(width: AppPaddings.padding_8),
                Text(
                  AppStrings.getCategoryText(category),
                  style: TextStyle(
                    color: AppColors.categoryColor(category, brightness),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Text(
              '${(progress * 100).ceil()} %',
              style: TextStyle(
                color: AppColors.categoryColor(category, brightness),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppPaddings.padding_8),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: brightness == Brightness.light ? Colors.grey.shade400 : Colors.grey.shade600,
          borderRadius: BorderRadius.circular(10),
          color: AppColors.categoryColor(category, brightness),
          minHeight: 7.5,
        ),
      ],
    );
  }
}
