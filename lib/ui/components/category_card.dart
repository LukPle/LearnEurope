import 'package:flutter/material.dart';
import 'package:learn_europe/constants/colors.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/constants/strings.dart';
import 'package:learn_europe/constants/textstyles.dart';
import 'package:learn_europe/models/category_enum.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.category, required this.onTap});

  final Category category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.175,
            decoration: BoxDecoration(
              color: MediaQuery.of(context).platformBrightness == Brightness.light
                  ? AppColors.lightCard
                  : AppColors.darkCard,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.black12),
            ),
            padding: const EdgeInsets.all(AppPaddings.padding_16),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                AppStrings.getCategoryText(category),
                style: AppTextStyles.categoryTextStyle(category),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 90,
          child: Image.network(
            'https://cdn.pixabay.com/photo/2014/04/03/11/58/rocket-312767_640.png', // Replace with your image URL
            width: 100,
            height: 100,
          ),
        ),
      ],
    );
  }
}