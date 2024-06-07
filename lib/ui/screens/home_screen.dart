import 'package:flutter/material.dart';
import 'package:learn_europe/ui/components/cta_button.dart';
import 'package:learn_europe/constants/routes.dart' as routes;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CtaButton.primary(onPressed: () => _navigateToMultipleChoice(context), label: 'Go to Quiz'),
      ],
    );
  }

  void _navigateToMultipleChoice(BuildContext context) {
    Navigator.of(context).pushNamed(routes.multipleChoice);
  }
}
