import 'package:e_markety_client/features/category/models/category.dart';
import 'package:e_markety_client/shared/widgets/category_circle_avatar.dart';
import 'package:e_markety_client/shared/widgets/custom_app_bar.dart';
import 'package:e_markety_client/shared/widgets/search_bar_with_filter.dart';
import 'package:flutter/material.dart';

import '../components/products_list.dart';
import '../models/product.dart';

class ProductsByCategoryScreen extends StatelessWidget {
  const ProductsByCategoryScreen({
    Key? key,
    required this.category,
    required this.products,
  }) : super(key: key);

  final Category category;
  final List<Product> products;

  _imageContainer() {
    return Container(
      height: 258,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(category.imageUrl),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            category.color.withOpacity(0.75),
            BlendMode.darken,
          ),
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(
        context,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          SizedBox(
            height: 345,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                _imageContainer(),
                Positioned(
                  top: 170,
                  left: MediaQuery.of(context).size.width * 0.5 - 65,
                  child: CategoryCircleAvatar(
                    category: category,
                    outerRadius: 72,
                    innerRadius: 60,
                    iconSize: 85,
                    filled: false,
                  ),
                ),
                Positioned(
                  top: 70,
                  width: 270,
                  child: Text(
                    category.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          const SearchBarWithFilter(),
          Expanded(child: ProductsList(products: products)),
        ],
      ),
    );
  }
}
