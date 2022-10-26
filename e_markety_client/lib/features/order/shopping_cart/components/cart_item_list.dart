import 'package:e_markety_client/shared/widgets/slidable_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../blocs/overview/cart_item_overview_bloc.dart';
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
      itemBuilder: (ctx, i) => SlidableCard(
        valueKey: cartItems[i].id,
        onConfirmDelete: () {
          Modular.get<CartItemOverviewBloc>()
              .add(CartItemOverviewCartItemDeleted(cartItems[i]));
        },
        child: CartItemWidget(item: cartItems[i]),
      ),
      separatorBuilder: (ctx, i) => const SizedBox(height: 10),
    );
  }
}
