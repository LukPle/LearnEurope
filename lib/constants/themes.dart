import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

class AppThemes {
  AppThemes._();

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.lightBackground,
    pageTransitionsTheme: pageTransitionsTheme,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    ),
    colorScheme: const ColorScheme.light().copyWith(
      primary: AppColors.primaryColorLight,
      secondary: AppColors.accentColorLight,
    ),
    splashColor: Colors.transparent,
  );

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.darkBackground,
    pageTransitionsTheme: pageTransitionsTheme,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    ),
    colorScheme: const ColorScheme.dark().copyWith(
      primary: AppColors.primaryColorDark,
      secondary: AppColors.accentColorDark,
    ),
    splashColor: Colors.transparent,
  );

  static const pageTransitionsTheme = PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  );
}
