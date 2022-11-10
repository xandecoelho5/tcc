import 'package:e_markety_client/features/product/components/product_card.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({
    Key? key,
    required this.products,
    this.needWrap = false,
    this.length,
  }) : super(key: key);

  final List<Product> products;
  final bool needWrap;
  final int? length;

  @override
  Widget build(BuildContext context) {
    if (needWrap) {
      return Wrap(
        spacing: 10,
        runSpacing: 15,
        children: products.map((p) => ProductCard(product: p)).take(4).toList(),
      );
    }

    // TODO - Implementar o ListView.builder com tamanho dinamico pros Produtos Cards
    return GridView.builder(
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        mainAxisExtent: MediaQuery.of(context).size.height * 0.45,
      ),
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 32),
      itemBuilder: (ctx, i) => ProductCard(product: products[i]),
    );
  }
}
