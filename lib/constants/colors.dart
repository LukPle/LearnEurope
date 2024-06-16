import 'package:flutter/material.dart';
import 'package:learn_europe/models/category_enum.dart';

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
  static const Color primaryColorDark = Color(0xffFFDD00); // Hex: #635A1A
  static const Color accentColorDark = Color(0xffFFE4B0); // Hex: #FFE4B0

  // Success and Error Color
  static const Color success = Colors.green;
  static const Color error = Colors.red;

  // Category Colors
  static Color categoryColor(Category category) {
    switch (category) {
      case Category.europe101:
        return Colors.red;
      case Category.languages:
        return Colors.green;
      case Category.countryBorders:
        return Colors.cyan;
      case Category.geoPosition:
        return Colors.purpleAccent;
    }
  }

  // Activity Flame Colors
  static const List activityFlameColors = [
    Colors.amber,
    Colors.orange,
    Colors.deepOrangeAccent,
    Colors.red
  ];
}
