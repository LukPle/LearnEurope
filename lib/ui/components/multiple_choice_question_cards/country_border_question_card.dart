import 'package:flutter/material.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'dart:math' as math;

import 'package:learn_europe/constants/textstyles.dart';

class CountryBorderQuestionCard extends StatelessWidget {
  const CountryBorderQuestionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Which country can be seen here?', style: AppTextStyles.questionTextStyle),
        const SizedBox(height: AppPaddings.padding_24),
        SizedBox(
          height: 225,
          child: Transform.rotate(
            angle: 0 * (math.pi / 180),
            child:
            Image.network('https://i.pinimg.com/originals/de/cd/15/decd15e39360f7ba7acd4077b79912de.gif'),
          ),
        ),
      ],
    );
  }
}