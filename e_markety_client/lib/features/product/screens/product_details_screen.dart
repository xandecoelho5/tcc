import 'package:e_markety_client/features/product/components/product_details.dart';
import 'package:e_markety_client/features/product/models/product.dart';
import 'package:e_markety_client/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../shared/theme/constants.dart';
import '../../order/shopping_cart/blocs/overview/cart_item_overview_bloc.dart';
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

  void _onAddItemToCart() {
    Modular.get<CartItemOverviewBloc>()
        .add(CartItemOverviewCartItemAdd(_cartItem));
  }

  Row _addToCartButton() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(double.infinity, 100),
              backgroundColor: kSecondaryColor,
              foregroundColor: Colors.white,
            ),
            onPressed: _onAddItemToCart,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(''),
                  Text(
                    'Adicionar ao Carrinho',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Icon(Icons.shopping_bag_outlined),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(
        context,
        backgroundColor: Colors.transparent,
      ),
      // extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Expanded(
            flex: 9,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: ProductDetails(
                  product: widget.product,
                  onQuantityChanged: _onQuantityChanged,
                ),
              ),
            ),
          ),
          Expanded(child: _addToCartButton()),
        ],
      ),
    );
  }
}
