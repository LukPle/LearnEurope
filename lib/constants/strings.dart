import 'package:learn_europe/models/enums/category_enum.dart';
import 'package:learn_europe/models/enums/difficulties_enum.dart';

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
  static const String emptyFields = 'Please fill out all fields';
  static const String signupFail = 'Failed to create a user, please try again';
  static const String loginFail = 'Login failed, please try again';

  /// Bottom Navigation Strings
  static const String navHome = 'Home';
  static const String navCategories = 'Categories';
  static const String navLeaderboard = 'Leaderboard';
  static const String navProfile = 'Profile';

  /// Home Screen Strings
  static String homeTitle(String? username) {
    return username != null ? 'Hello $username, let\'s\nstart learning' : 'Let\'s start learning';
  }

  static const String featuredNoHistoryQuizSection = 'Today\'s Quiz';
  static const String featuredLowPerformanceQuizSection = 'Try Again?';

  /// Categories Screen Strings
  static const String categoriesTitle = 'Explore Europe in various categories';

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

  static String getCategoryImage(Category category) {
    switch (category) {
      case Category.europe101:
        return 'assets/europe_101.svg';
      case Category.languages:
        return 'assets/languages.svg';
      case Category.countryBorders:
        return 'assets/country_borders.svg';
      case Category.geoPosition:
        return 'assets/geo_position.svg';
    }
  }

  /// Quiz Selection Screen String
  static const String allQuizzesFilter = 'All';
  static const String openQuizzesFilter = 'Open';
  static const String completedQuizzesFilter = 'Completed';
  static const String quizzesLoadingError = 'Quizzes couldn\'t be loaded';
  static const String noQuizzesAvailable = 'No quizzes available';
  static const String noOpenQuizzesAvailable = 'No open quizzes left';
  static const String noCompletedQuizzesAvailable = 'No quizzes completed yet';

  static String getDifficultyText(QuizDifficulty quizDifficulty) {
    if (quizDifficulty == QuizDifficulty.beginner) {
      return 'Beginner Level';
    } else {
      return 'Expert Level';
    }
  }

  static String getDateTimeText(DateTime? dateTime) {
    return dateTime != null ? 'Last completed on ${dateTime.day}.${dateTime.month}.${dateTime.year}' : 'Open';
  }

  /// Quiz Strings
  static const String exitQuiz = 'Exit Quiz';
  static const String correctAnswer = 'Correct Answer';
  static const String wrongAnswer = 'Wrong Answer';
  static const String continueButton = 'Continue';
  static const String selectionPane = 'Drop your answer(s) here';
  static const String submitSelectionButton = 'Submit selection';
  static const String textToSpeechFail = 'Sorry, audio output not possible';
  static const String geoPositionCheckButton = 'Check position';

  static String geoPositionAllowedRadius(int allowedDifferenceInKm) {
    return 'Search for the target in a $allowedDifferenceInKm km radius';
  }

  static String geoPositionResult(double distance) {
    return 'Distance from target: ${distance.toStringAsFixed(2)} km';
  }

  /// Hint Dialog Strings
  static const String hintDialogTitle = 'Do you need a hint?';

  /// Result Screen Strings
  static const String resultTitle = 'Your result';

  static String answeredQuestion(int numbQuestions) {
    return 'After $numbQuestions answered questions';
  }

  static const String pointsIntroduction = 'Earned points';
  static const String returnToHomeButton = 'Return to home';
  static const String playAgainButton = 'Play again';

  /// Leaderboard Screen Strings
  static const String leaderboardTitle = 'Your place on the leaderboard';
  static const String leaderboardLoadingError = 'Leaderboard couldn\'t be loaded';
  static const String noLeaderboardAvailable = 'No leaderboard available';
  static const String ownCard = 'You';

  /// Profile Strings
  static const String profileTitle = 'Profile';
  static const String selectAvatarTitle = 'Choose an avatar that suits you best';
  static const String selectAvatarButton = 'Select avatar';

  static String learnerRegistrationText(DateTime? dateTime) {
    return dateTime != null
        ? 'Student of Europe\nsince ${dateTime.day}.${dateTime.month}.${dateTime.year}'
        : 'Student of Europe';
  }

  static const scoreAndActivityAnalyticsTitle = 'Score and Activity';
  static const String totalPointsAnalytics = 'Total Points';

  static String activityAnalytics(int activeDays) {
    return activeDays == 1 ? '$activeDays Day Active' : '$activeDays Days Active';
  }

  static const categoriesAnalyticsTitle = 'Categories Progress';
  static const String logoutButton = 'Logout';
  static const String logoutFail = 'Logout failed, please try again';
}
