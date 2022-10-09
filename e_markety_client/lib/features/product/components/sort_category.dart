import 'package:e_markety_client/features/category/models/category.dart';
import 'package:e_markety_client/features/order/checkout/components/information_container.dart';
import 'package:e_markety_client/shared/mocks/mocks.dart';
import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:flutter/material.dart';

class SortCategory extends StatefulWidget {
  const SortCategory({Key? key, required this.category}) : super(key: key);

  final Category category;

  @override
  State<SortCategory> createState() => _SortCategoryState();
}

class _SortCategoryState extends State<SortCategory> {
  late Category _category = widget.category;

  @override
  Widget build(BuildContext context) {
    return InformationContainer(
      title: 'Categories',
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Wrap(
          spacing: 8,
          runSpacing: 10,
          children: categoriesMock.map((category) {
            final selected = _category.name == category.name;
            return InkWell(
              onTap: () => setState(() => _category = category),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  color: selected ? kPrimaryColor : Colors.grey[300],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  category.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: selected ? Colors.white : Colors.grey[700],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
