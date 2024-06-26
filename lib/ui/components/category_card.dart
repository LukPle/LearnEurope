import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:learn_europe/constants/colors.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/constants/strings.dart';
import 'package:learn_europe/constants/textstyles.dart';
import 'package:learn_europe/models/enums/category_enum.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.category, required this.onTap});

  final Category category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    bool isSmallScreen = MediaQuery.of(context).size.height < 700;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.175,
            decoration: BoxDecoration(
              color: brightness == Brightness.light ? AppColors.lightCard : AppColors.darkCard,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.black12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 1,
                  offset: const Offset(0.5, 1.5),
                ),
              ],
            ),
            padding: const EdgeInsets.all(AppPaddings.padding_16),
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: AppPaddings.padding_32),
                child: Text(
                  AppStrings.getCategoryText(category),
                  style: AppTextStyles.categoryTextStyle(category, brightness),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * (isSmallScreen ? 0.16 : 0.14),
            child: SvgPicture.asset(
              AppStrings.getCategoryImage(category),
              width: MediaQuery.of(context).size.width * 0.175,
              height: MediaQuery.of(context).size.width * 0.175,
            ),
          ),
        ],
      ),
    );
  }
}
