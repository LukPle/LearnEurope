import 'package:learn_europe/models/enums/category_enum.dart';

class AppStrings {
  AppStrings._();

  /// Start, Login and Signup Strings
  static const String loginButton = 'Login';
  static const String signupButton = 'Signup';
  static const String signupButtonStart = 'New learner? Create an account';
  static const String loginTitle = 'Enter your login credentials here';
  static const String signupTitle = 'Create a new account';
  static const String forgotPassword = 'Forgot Password?';
  static const String emailTitle = 'Email';
  static const String emailHint = 'email@example.com';
  static const String passwordTitle = 'Password';
  static const String passwordHint = '********';
  static const String nameTitle = 'Name';
  static const String nameHint = 'Nickname';

  /// Bottom Navigation Strings
  static const String navHome = 'Home';
  static const String navCategories = 'Categories';
  static const String navLeaderboard = 'Leaderboard';
  static const String navProfile = 'Profile';

  /// Learning Categories Strings
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

  /// Quiz Selection Screen String
  static const String allQuizzesFilter = 'All';
  static const String openQuizzesFilter = 'Open';
  static const String completedQuizzesFilter = 'Completed';

  static String getDateTimeText(DateTime? dateTime) {
    return dateTime != null ? 'Last completed on ${dateTime.day}.${dateTime.month}.${dateTime.year}' : 'Open • No playthrough yet';
  }

  /// Quiz Strings
  static const exitQuiz = 'Exit Quiz';

  /// Hint Dialog Strings
  static const hintDialogTitle = 'Do you need a hint?';
}
