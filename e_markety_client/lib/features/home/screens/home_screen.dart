import 'package:e_markety_client/features/category/components/category_list.dart';
import 'package:e_markety_client/features/home/components/banners.dart';
import 'package:e_markety_client/features/home/components/home_app_bar.dart';
import 'package:e_markety_client/features/product/components/products_list.dart';
import 'package:e_markety_client/shared/widgets/search_bar_with_filter.dart';
import 'package:flutter/material.dart';

import '../../../shared/mocks/mocks.dart';
import '../../user/auth/components/view_all_row.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  _categories(context) {
    return Column(
      children: const [
        ViewAllRow(text: 'Category'),
        SizedBox(height: 8),
        CategoryList(categories: categoriesMock, needWrap: true),
      ],
    );
  }

  _bestSellers() {
    return Column(
      children: [
        const ViewAllRow(text: 'Best Seller'),
        ProductsList(products: productsMock, needWrap: true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar.build(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            const SearchBarWithFilter(),
            const SizedBox(height: 32),
            const Banners(items: bannersMock),
            const SizedBox(height: 32),
            _categories(context),
            const SizedBox(height: 16),
            _bestSellers(),
            const SizedBox(height: 16),
            // _popularProducts(),
          ],
        ),
      ),
    );
  }
}
