import 'package:flutter/material.dart';
import 'package:learn_europe/tab_selector.dart';
import 'package:learn_europe/ui/screens/multiple_choice_screen.dart';

const String tabSelector = 'tab_selector';
const String multipleChoice = 'multiple_choice';

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
    default:
      throw ('Route ${destination.name} does not exist');
  }
}
