import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learn_europe/constants/routes.dart' as routes;

import 'constants/themes.dart';

class LearnEuropeApp extends StatelessWidget {
  const LearnEuropeApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      onGenerateRoute: routes.generateRoute,
      initialRoute: routes.loading,
    );
  }
}
