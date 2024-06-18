import 'package:flutter/material.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/models/category_enum.dart';
import 'package:learn_europe/ui/components/category_card.dart';
import 'package:learn_europe/ui/components/page_headline.dart';
import 'package:learn_europe/constants/routes.dart' as routes;

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPaddings.padding_16),
      child: Column(
        children: [
          const PageHeadline(title: "Explore Europe in various categories"),
          const Spacer(),
          GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: AppPaddings.padding_48,
            crossAxisSpacing: AppPaddings.padding_16,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              CategoryCard(
                category: Category.europe101,
                onTap: () => Navigator.of(context).pushNamed(
                  routes.quizSelection,
                  arguments: Category.europe101,
                ),
              ),
              CategoryCard(
                category: Category.languages,
                onTap: () => Navigator.of(context).pushNamed(
                  routes.quizSelection,
                  arguments: Category.languages,
                ),
              ),
              CategoryCard(
                category: Category.countryBorders,
                onTap: () => Navigator.of(context).pushNamed(
                  routes.quizSelection,
                  arguments: Category.countryBorders,
                ),
              ),
              CategoryCard(
                category: Category.geoPosition,
                onTap: () => Navigator.of(context).pushNamed(
                  routes.quizSelection,
                  arguments: Category.geoPosition,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
