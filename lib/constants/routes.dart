import 'package:flutter/material.dart';
import 'package:learn_europe/tab_selector.dart';
import 'package:learn_europe/ui/screens/drag_and_drop_screen.dart';
import 'package:learn_europe/ui/screens/multiple_choice_screen.dart';
import 'package:learn_europe/ui/screens/result_screen.dart';

const String tabSelector = 'tab_selector';
const String multipleChoice = 'multiple_choice';
const String dragAndDrop = 'drag_and_drop';
const String result = 'result';

Route<dynamic> generateRoute(RouteSettings destination) {
  switch (destination.name) {
    case tabSelector:
      return MaterialPageRoute(
        settings: destination,
        builder: (context) => const TabSelector(),
      );
    case multipleChoice:
      return MaterialPageRoute(
        settings: destination,
        builder: (context) => const MultipleChoiceScreen(),
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
