import 'package:flutter/material.dart';
import 'package:learn_europe/constants/colors.dart';
import 'package:learn_europe/models/category_enum.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle bottomNavigationActive = const TextStyle(fontSize: 12, fontWeight: FontWeight.w600);

  static TextStyle bottomNavigationPassive = const TextStyle(fontSize: 12, fontWeight: FontWeight.normal);

  static TextStyle pageHeadlineTextStyle = const TextStyle(fontSize: 30, fontWeight: FontWeight.w600);

  static TextStyle appBarTextStyle({required Brightness brightness}) {
    return TextStyle(
      fontSize: 20,
      color: brightness == Brightness.light ? Colors.black : Colors.white,
    );
  }

  static TextStyle buttonTextStyle({required bool isPrimary, required Brightness brightness}) {
    return TextStyle(
      fontWeight: isPrimary ? FontWeight.w500 : FontWeight.normal,
      color: isPrimary
          ? brightness == Brightness.light
              ? AppColors.lightBackground
              : AppColors.darkBackground
          : brightness == Brightness.light
              ? AppColors.primaryColorLight
              : AppColors.primaryColorDark,
    );
  }

  static TextStyle categoryTextStyle(Category category) {
    return TextStyle(color: AppColors.categoryColor(category), fontSize: 18, fontWeight: FontWeight.w500);
  }

  static TextStyle leaderbordCardTextStyle({required Brightness brightness}) {
    return TextStyle(color: brightness == Brightness.light ? Colors.white : Colors.black);
  }
}
