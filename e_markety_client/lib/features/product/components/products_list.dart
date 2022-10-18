import 'package:e_markety_client/features/product/components/product_card.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({
    Key? key,
    required this.products,
    this.needWrap = false,
  }) : super(key: key);

  final List<Product> products;
  final bool needWrap;

  List<ProductCard> _getProductsList() {
    return products.map((product) => ProductCard(product: product)).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (needWrap) {
      return Wrap(
        spacing: 20,
        runSpacing: 30,
        children: _getProductsList(),
      );
    }

    return GridView.builder(
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        mainAxisExtent: MediaQuery.of(context).size.height * 0.33,
      ),
      padding: const EdgeInsets.fromLTRB(18, 28, 18, 32),
      itemBuilder: (ctx, i) => ProductCard(product: products[i]),
    );
  }
}
