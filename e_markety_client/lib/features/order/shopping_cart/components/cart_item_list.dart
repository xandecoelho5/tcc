import 'package:flutter/material.dart';

import '../models/cart_item.dart';
import 'cart_item_widget.dart';

class CartItemList extends StatelessWidget {
  const CartItemList({Key? key, required this.cartItems}) : super(key: key);

  final List<CartItem> cartItems;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: cartItems.length,
      itemBuilder: (ctx, i) => CartItemWidget(item: cartItems[i]),
      separatorBuilder: (ctx, i) => const SizedBox(height: 10),
    );
  }
}
