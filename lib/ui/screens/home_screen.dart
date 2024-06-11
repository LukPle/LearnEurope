import 'package:flutter/material.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/ui/components/cta_button.dart';
import 'package:learn_europe/ui/components/page_headline.dart';
import 'package:learn_europe/constants/routes.dart' as routes;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageHeadline(title: "Hello Amiin, let's start learning!"),
        const SizedBox(height: AppPaddings.padding_12),
        CtaButton.primary(onPressed: () => _navigateToMultipleChoice(context), label: 'Go to Quiz'),
      ],
    );
  }

  void _navigateToMultipleChoice(BuildContext context) {
    Navigator.of(context).pushNamed(routes.multipleChoice);
  }
}
