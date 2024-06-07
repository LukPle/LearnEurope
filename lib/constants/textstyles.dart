import 'package:flutter/material.dart';
import 'package:learn_europe/constants/colors.dart';

class AppTextStyles {
  AppTextStyles._();

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
}
