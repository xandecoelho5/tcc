import 'package:e_markety_client/features/order/shopping_cart/blocs/overview/cart_item_overview_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:iconsax/iconsax.dart';

import '../theme/constants.dart';

class ActionCart extends StatelessWidget {
  const ActionCart({Key? key}) : super(key: key);

  Container _badge(int quantity) {
    return Container(
      width: 13,
      height: 13,
      decoration: BoxDecoration(
        color: Colors.deepOrange,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          '$quantity',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      margin: const EdgeInsets.fromLTRB(0, 16, 16, 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: kBackgroundColor,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => Modular.to.pushNamed('/order/shopping-cart'),
              borderRadius: BorderRadius.circular(8),
              child: const Padding(
                padding: EdgeInsets.all(7),
                child: Icon(
                  Iconsax.shopping_cart,
                  color: kBasicDarkColor,
                  size: 20,
                ),
              ),
            ),
          ),
          BlocBuilder<CartItemOverviewBloc, CartItemOverviewState>(
            bloc: Modular.get<CartItemOverviewBloc>(),
            builder: (context, state) {
              if (state.status == CartItemOverviewStatus.success) {
                return Positioned(
                  top: 0,
                  right: 0,
                  child: Visibility(
                    visible: state.cartItems.isNotEmpty,
                    child: _badge(state.cartItems.length),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
