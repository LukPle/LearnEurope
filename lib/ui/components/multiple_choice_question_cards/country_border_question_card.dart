import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/constants/textstyles.dart';
import 'dart:math' as math;

class CountryBorderQuestionCard extends StatelessWidget {
  const CountryBorderQuestionCard({
    super.key,
    required this.question,
    required this.imageUrl,
  });

  final String question;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(question, style: AppTextStyles.questionTextStyle),
        const SizedBox(height: AppPaddings.padding_12),
        Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.25,
          ),
          child: Transform.rotate(
            angle: 0 * (math.pi / 180),
            child: Image.network(
              imageUrl,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ],
    );
  }
}
