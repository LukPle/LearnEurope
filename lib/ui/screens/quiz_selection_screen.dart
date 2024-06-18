import 'package:flutter/material.dart';
import 'package:learn_europe/constants/colors.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/constants/strings.dart';
import 'package:learn_europe/constants/textstyles.dart';
import 'package:learn_europe/models/category_enum.dart';
import 'package:learn_europe/ui/components/app_appbar.dart';
import 'package:learn_europe/ui/components/app_scaffold.dart';
import 'package:learn_europe/ui/components/list_fading_shader.dart';
import 'package:learn_europe/ui/components/quiz_card.dart';

class QuizSelectionScreen extends StatelessWidget {
  const QuizSelectionScreen({super.key, required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: const AppAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.getCategoryText(category),
            style: AppTextStyles.standardTitleTextStyle.copyWith(
              color: AppColors.categoryColor(category),
            ),
          ),
          const SizedBox(height: AppPaddings.padding_24),
          Row(
            children: [
              FilterButton(text: 'All', isActive: true),
              const SizedBox(width: AppPaddings.padding_8),
              FilterButton(text: 'Open', isActive: false),
              const SizedBox(width: AppPaddings.padding_8),
              FilterButton(text: 'Completed', isActive: false),
            ],
          ),
          const SizedBox(height: AppPaddings.padding_12),
          Expanded(
            child: ListFadingShaderWidget(
              color: MediaQuery.of(context).platformBrightness == Brightness.light
                  ? AppColors.lightBackground
                  : AppColors.darkBackground,
              child: ListView.builder(
                  padding: const EdgeInsets.only(top: AppPaddings.padding_12),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return const Padding(
                      padding: EdgeInsets.only(bottom: AppPaddings.padding_8),
                      child: QuizCard(),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  const FilterButton({super.key, required this.text, required this.isActive});

  final String text;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;

    return GestureDetector(
      onTap: () => {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isActive
              ? (brightness == Brightness.light ? AppColors.primaryColorLight : AppColors.primaryColorDark)
              : (brightness == Brightness.light ? AppColors.lightCard : AppColors.darkCard),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 0.5,
              offset: const Offset(0.5, 0.5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppPaddings.padding_8,
            horizontal: AppPaddings.padding_12,
          ),
          child: Text(
            text,
            style: TextStyle(
              color: isActive
                  ? brightness == Brightness.light
                      ? Colors.white
                      : Colors.black
                  : null,
              fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
