import 'package:flutter/material.dart';
import 'package:learn_europe/ui/components/page_headline.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const PageHeadline(title: "Ranking of the best"),
      ],
    );
  }
}