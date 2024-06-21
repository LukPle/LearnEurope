import 'package:flutter/material.dart';
import 'package:learn_europe/models/enums/category_enum.dart';
import 'package:learn_europe/models/multiple_choice_content_model.dart';
import 'package:learn_europe/tab_selector.dart';
import 'package:learn_europe/ui/screens/drag_and_drop_screen.dart';
import 'package:learn_europe/ui/screens/loading_screen.dart';
import 'package:learn_europe/ui/screens/login_screen.dart';
import 'package:learn_europe/ui/screens/multiple_choice_screen.dart';
import 'package:learn_europe/ui/screens/quiz_selection_screen.dart';
import 'package:learn_europe/ui/screens/result_screen.dart';
import 'package:learn_europe/ui/screens/signup_screen.dart';
import 'package:learn_europe/ui/screens/start_screen.dart';

const String loading = 'loading';
const String start = 'start';
const String login = 'login';
const String signup = 'signup';
const String tabSelector = 'tab_selector';
const String quizSelection = 'quiz_selection';
const String multipleChoice = 'multiple_choice';
const String dragAndDrop = 'drag_and_drop';
const String result = 'result';

Route<dynamic> generateRoute(RouteSettings destination) {
  switch (destination.name) {
    case loading:
      return MaterialPageRoute(
        settings: destination,
        builder: (context) => LoadingScreen(),
      );
    case start:
      return MaterialPageRoute(
        settings: destination,
        builder: (context) => const StartScreen(),
      );
    case login:
      return MaterialPageRoute(
        settings: destination,
        builder: (context) => const LoginScreen(),
      );
    case signup:
      return MaterialPageRoute(
        settings: destination,
        builder: (context) => const SignupScreen(),
      );
    case tabSelector:
      return MaterialPageRoute(
        settings: destination,
        builder: (context) => const TabSelector(),
      );
    case quizSelection:
      final category = destination.arguments as Category;
      return MaterialPageRoute(
        settings: destination,
        builder: (context) => QuizSelectionScreen(category: category),
      );
    case multipleChoice:
      final multipleChoiceContent = destination.arguments as MultipleChoiceContentModel;
      return MaterialPageRoute(
        settings: destination,
        builder: (context) => MultipleChoiceScreen(
          questionCardContent: multipleChoiceContent.questionCardContent,
          answerOptions: multipleChoiceContent.answerOptions,
        ),
      );
    case dragAndDrop:
      return MaterialPageRoute(
        settings: destination,
        builder: (context) => const DragAndDropScreen(),
      );
    case result:
      return MaterialPageRoute(
        settings: destination,
        builder: (context) => const ResultScreen(),
      );
    default:
      throw ('Route ${destination.name} does not exist');
  }
}
