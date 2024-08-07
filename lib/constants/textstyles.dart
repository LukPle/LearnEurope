import 'package:flutter/material.dart';
import 'package:learn_europe/constants/colors.dart';
import 'package:learn_europe/models/enums/category_enum.dart';

class AppTextStyles {
  AppTextStyles._();

  static const TextStyle standardTitleTextStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

  static const TextStyle sectionTitleTextStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w600);

  static TextStyle pageHeadlineTextStyle = const TextStyle(fontSize: 30, fontWeight: FontWeight.w600);

  static TextStyle bottomNavigationActive = const TextStyle(fontSize: 12, fontWeight: FontWeight.w600);

  static TextStyle bottomNavigationPassive = const TextStyle(fontSize: 12, fontWeight: FontWeight.normal);

  static TextStyle appBarTextStyle({required Brightness brightness}) {
    return TextStyle(
      fontSize: 20,
      color: brightness == Brightness.light ? Colors.black : Colors.white,
    );
  }

  static TextStyle thinDetailTextStyle(Brightness brightness) {
    return TextStyle(
      fontSize: 14,
      color: brightness == Brightness.light ? Colors.black54 : Colors.white54,
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

  static TextStyle categoryTextStyle(Category category, Brightness brightness) {
    return TextStyle(color: AppColors.categoryColor(category, brightness), fontSize: 18, fontWeight: FontWeight.w500);
  }

  static TextStyle leaderbordCardTextStyle({required Brightness brightness}) {
    return TextStyle(color: brightness == Brightness.light ? Colors.white : Colors.black);
  }

  static const TextStyle quizCardTitleTextStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w500);

  static const TextStyle questionTextStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w500);

  static TextStyle resultScreenHeadline({required Brightness brightness}) {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: brightness == Brightness.light ? AppColors.primaryColorLight : AppColors.primaryColorDark,
    );
  }

  static TextStyle resultScreenPointsIntro({required Brightness brightness}) {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: brightness == Brightness.light ? Colors.white : Colors.black,
    );
  }

  static const TextStyle resultScreenPointsScore = TextStyle(fontSize: 52, fontWeight: FontWeight.w600);

  static const scoreAndActivityTextStyle = TextStyle(fontWeight: FontWeight.w500);

  static const gappedTextFieldStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w600);
}
