import 'package:flutter/material.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/ui/components/cta_button.dart';
import 'package:learn_europe/ui/components/page_headline.dart';
import 'package:learn_europe/constants/routes.dart' as routes;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPaddings.padding_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeadline(title: "Hello Amiin, let's\n start learning"),
          const SizedBox(height: AppPaddings.padding_16),
          CtaButton.primary(onPressed: () => _navigateToMultipleChoice(context), label: 'Go to Multiple Choice'),
          const SizedBox(height: AppPaddings.padding_16),
          CtaButton.primary(onPressed: () => _navigateToDragAnDrop(context), label: 'Go to Drag and Drop'),
          const SizedBox(height: AppPaddings.padding_16),
          CtaButton.primary(onPressed: () => _navigateToResult(context), label: 'Go to Result Screen'),
        ],
      ),
    );
  }

  void _navigateToMultipleChoice(BuildContext context) {
    Navigator.of(context).pushNamed(routes.multipleChoice);
  }

  void _navigateToDragAnDrop(BuildContext context) {
    Navigator.of(context).pushNamed(routes.dragAndDrop);
  }

  void _navigateToResult(BuildContext context) {
    Navigator.of(context).pushNamed(routes.result);
  }
}
