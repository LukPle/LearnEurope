import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/constants/textstyles.dart';
import 'package:learn_europe/models/enums/difficulties_enum.dart';
import 'dart:math' as math;

class CountryBorderQuestionCard extends StatelessWidget {
  const CountryBorderQuestionCard({
    super.key,
    required this.question,
    required this.imageUrl,
    required this.difficulty,
  });

  final String question;
  final String imageUrl;
  final QuizDifficulty difficulty;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          difficulty == QuizDifficulty.beginner ? question : '$question (rotated)',
          style: AppTextStyles.questionTextStyle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppPaddings.padding_12),
        Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.25,
          ),
          child: Transform.rotate(
            angle: difficulty == QuizDifficulty.beginner
                ? 0 * (math.pi / 180)
                : math.Random().nextInt(361) * (math.pi / 180),
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
