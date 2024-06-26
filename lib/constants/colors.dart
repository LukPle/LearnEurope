import 'package:flutter/material.dart';
import 'package:learn_europe/models/enums/category_enum.dart';

class AppColors {
  AppColors._();

  // Background Colors for the Scaffold Widgets
  static const Color lightBackground = Color(0xfff2f2f2); // Hex: #F2F2F2
  static const Color darkBackground = Color(0xff141414); // Hex: #141414

  // Background Colors for Tiles and Cards
  static const Color lightCard = Colors.white;
  static const Color darkCard = Color(0xff2F2F2F); // Hex: #2F2F2F

  // Primary and Secondary Color for Widgets and Components
  static const Color primaryColorLight = Color(0xff001489); // Hex: #001489
  static const Color accentColorLight = Color(0xffB2BBEE); // Hex: #B2BBEE
  static const Color primaryColorDark = Color(0xffFFDD00); // Hex: #FFDD00
  static const Color accentColorDark = Color(0xffFFE4B0); // Hex: #FFE4B0

  // Success and Error Color
  static const Color success = Colors.green;
  static const Color error = Colors.red;

  // Category Colors
  static Color categoryColor(Category category, Brightness brightness) {
    bool isLightMode = brightness == Brightness.light;

    switch (category) {
      case Category.europe101:
        return isLightMode ? const Color(0xff4B96DA) : const Color(0xff9DCAF3); // Hex: #4B96DA, #9DCAF3
      case Category.languages:
        return isLightMode ? const Color(0xffE9AE00) : const Color(0xffEDD17E); // Hex: #E9AE00, #EDD17E
      case Category.countryBorders:
        return isLightMode ? const Color(0xff528F6E) : const Color(0xff6CD196); // Hex: #528F6E, #6CD196
      case Category.geoPosition:
        return isLightMode ? const Color(0xffB34535) : const Color(0xffD97588); // Hex: #B34535, #D97588
    }
  }

  // Activity Flame Colors
  static const List activityFlameColors = [Colors.amber, Colors.orange, Colors.deepOrangeAccent, Colors.red];
}
