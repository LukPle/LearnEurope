import 'package:learn_europe/models/category_enum.dart';

class AppStrings {
  AppStrings._();

  /// Bottom Navigation Strings
  static const String navHome = 'Home';
  static const String navCategories = 'Categories';
  static const String navLeaderboard = 'Leaderboard';
  static const String navProfile = 'Profile';

  /// Learning Categories String
  static String getCategoryText(Category category) {
    switch (category) {
      case Category.europe101:
        return 'Europe 101';
      case Category.languages:
        return 'Languages';
      case Category.countryBorders:
        return 'Country Borders';
      case Category.geoPosition:
        return 'Geo Position';
    }
  }
}
