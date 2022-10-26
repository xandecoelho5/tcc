import 'package:flutter/material.dart';

import '../models/category.dart';
import 'category_card.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    Key? key,
    required this.categories,
    this.needWrap = false,
  }) : super(key: key);

  final List<Category> categories;
  final bool needWrap;

  @override
  Widget build(BuildContext context) {
    if (needWrap) {
      return SizedBox(
        height: 138,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (ctx, i) => CategoryCard.small(category: categories[i]),
          separatorBuilder: (context, index) => const SizedBox(width: 16),
        ),
      );
    }

    return GridView.count(
      padding: const EdgeInsets.fromLTRB(18, 40, 18, 32),
      crossAxisCount: 2,
      crossAxisSpacing: 20,
      mainAxisSpacing: 30,
      childAspectRatio: 0.85,
      children: categories.map((c) => CategoryCard.big(category: c)).toList(),
    );
  }
}
