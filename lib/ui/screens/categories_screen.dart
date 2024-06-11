import 'package:flutter/material.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/models/category_enum.dart';
import 'package:learn_europe/ui/components/category_card.dart';
import 'package:learn_europe/ui/components/page_headline.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const PageHeadline(title: "Explore Europe in various categories!"),
        const Spacer(),
        GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: AppPaddings.padding_48,
          crossAxisSpacing: AppPaddings.padding_16,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            CategoryCard(category: Category.europe101, onTap: () => {}),
            CategoryCard(category: Category.languages, onTap: () => {}),
            CategoryCard(category: Category.countryBorders, onTap: () => {}),
            CategoryCard(category: Category.geoPosition, onTap: () => {}),
          ],
        ),
      ],
    );
  }
}
