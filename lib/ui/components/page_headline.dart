import 'package:flutter/material.dart';
import 'package:learn_europe/constants/textstyles.dart';

class PageHeadline extends StatelessWidget {
  const PageHeadline({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title, style: AppTextStyles.pageHeadlineTextStyle),
    );
  }
}
