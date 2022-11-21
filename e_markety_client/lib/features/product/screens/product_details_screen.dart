import 'package:e_markety_client/features/product/components/product_details.dart';
import 'package:e_markety_client/features/product/models/product.dart';
import 'package:e_markety_client/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../shared/theme/constants.dart';
import '../../../shared/utils/modular_utils.dart';
import '../../order/shopping_cart/models/cart_item.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late var _cartItem = CartItem.empty(product: widget.product);

  void _onQuantityChanged(double quantity) {
    _cartItem = _cartItem.copyWith(quantity: quantity);
  }

  ElevatedButton _addToCartButton() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(double.infinity, 100),
        backgroundColor: kSecondaryColor,
        foregroundColor: Colors.white,
      ),
      onPressed: () => ModularUtils.addToCart(_cartItem),
      icon: const Icon(Icons.add_shopping_cart),
      label: const Text(
        'Adicionar ao Carrinho',
        style: kHeadline6,
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(backgroundColor: Colors.transparent),
      // extendBodyBehindAppBar: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 9,
            child: SingleChildScrollView(
              child: ProductDetails(
                product: widget.product,
                onQuantityChanged: _onQuantityChanged,
              ),
            ),
          ),
          Expanded(child: _addToCartButton()),
        ],
      ),
    );
  }
}
