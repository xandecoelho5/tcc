import 'package:e_markety_client/shared/widgets/custom_app_bar.dart';
import 'package:e_markety_client/shared/widgets/search_bar_with_filter.dart';
import 'package:flutter/material.dart';

import '../../../shared/mocks/mocks.dart';
import '../../../shared/theme/constants.dart';
import '../components/products_list.dart';

class SearchResultScreen extends StatelessWidget {
  const SearchResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(context, title: 'Search Result'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          const SearchBarWithFilter(),
          const SizedBox(height: 28),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              "Search Result for 'Fresh Fruits'",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kBasicDarkColor,
              ),
            ),
          ),
          Expanded(child: ProductsList(products: productsMock)),
        ],
      ),
    );
  }
}
