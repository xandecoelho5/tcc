import 'package:e_markety_client/features/order/shopping_cart/components/cart_item_quantity.dart';
import 'package:e_markety_client/features/product/components/product_slidable_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../blocs/overview/cart_item_overview_bloc.dart';
import '../models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({Key? key, required this.item}) : super(key: key);

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    return ProductSlidableItem(
      product: item.product,
      onConfirmDelete: () {
        Modular.get<CartItemOverviewBloc>()
            .add(CartItemOverviewCartItemDeleted(item));
      },
      rightWidget: CartItemQuantity(item: item),
    );
  }
}
