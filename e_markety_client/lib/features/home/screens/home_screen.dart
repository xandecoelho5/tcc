import 'package:e_markety_client/features/category/components/category_list.dart';
import 'package:e_markety_client/features/home/components/banners.dart';
import 'package:e_markety_client/features/product/components/products_list.dart';
import 'package:e_markety_client/shared/widgets/action_cart.dart';
import 'package:e_markety_client/shared/widgets/search_bar_with_filter.dart';
import 'package:flutter/material.dart';

import '../../../shared/mocks/mocks.dart';
import '../../../shared/theme/constants.dart';
import '../../user/auth/components/view_all_row.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  AppBar _appBar() {
    title() {
      return Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Row(
          children: [
            Material(
              elevation: 1,
              borderRadius: BorderRadius.circular(50),
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                radius: 21,
                child: CircleAvatar(
                  radius: 17,
                  backgroundImage: NetworkImage(
                    'https://avatars.githubusercontent.com/u/45719696',
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hello, Lucy',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: kBasicDarkColor,
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: kPrimaryColor,
                      size: 12,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      'Mithakhali, Navrangpura',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }

    return AppBar(
      automaticallyImplyLeading: false,
      title: title(),
      actions: const [ActionCart()],
    );
  }

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
      appBar: _appBar(),
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
