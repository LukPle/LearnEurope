import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Background Colors for the Scaffold Widgets
  static const Color lightBackground = Color(0xfff5f5f5); // Hex: #F5F5F5
  static const Color darkBackground = Color(0xff141414); // Hex: #141414

  // Primary and Secondary Color for Widgets and Components
  static const Color primaryColorLight = Color(0xff00457F); // Hex: #00457F
  static const Color secondaryColorLight = Color(0xff2589BD); // Hex: #2589BD
  static const Color primaryColorDark = Color(0xffFFD900); // Hex: #FFD900
  static const Color secondaryColorDark = Color(0xffFFF1D6); // Hex: #FFF1D6

  // Background Colors for the Bottom Navigation
  static const Color lightNavigation = Colors.white;
  static const Color darkNavigation = Colors.black;

  // Success and Error Color
  static const Color success = Colors.green;
  static const Color error = Colors.red;

  // Reflection Chart Colors
  static Color commuteColor = Colors.greenAccent;
  static Color wasteColor = Colors.amber;
  static Color nutritionColor = Colors.teal;

  // Activity Flame Colors
  static const List activityFlameColors = [
    Colors.amber,
    Colors.orange,
    Colors.deepOrangeAccent,
    Colors.red
  ];
}
