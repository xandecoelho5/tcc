import 'package:e_markety_client/features/product/components/sort_category.dart';
import 'package:e_markety_client/features/product/components/sort_options.dart';
import 'package:e_markety_client/shared/mocks/mocks.dart';
import 'package:e_markety_client/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../shared/theme/constants.dart';
import '../../../shared/widgets/filled_button.dart';
import '../components/price_range.dart';
import '../models/sort_type.dart';

class ApplyFiltersScreen extends StatelessWidget {
  const ApplyFiltersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(context, title: 'Apply Filters'),
      body: Column(
        children: [
          Expanded(
            flex: 9,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const PriceRange(values: RangeValues(0.0, 500.0)),
                    const SizedBox(height: 20),
                    const SortOptions(sortType: SortType.popularity),
                    const SizedBox(height: 20),
                    SortCategory(category: categoriesMock[1]),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: FilledButton(
                text: 'Apply Filters',
                color: kPrimaryColor,
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
