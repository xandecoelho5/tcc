import 'package:e_markety_client/features/order/shopping_cart/blocs/overview/cart_item_overview_bloc.dart';
import 'package:e_markety_client/features/order/shopping_cart/models/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../shared/theme/constants.dart';
import '../../../../shared/widgets/quantity_button.dart';

class CartItemQuantity extends StatelessWidget {
  CartItemQuantity({Key? key, required this.item}) : super(key: key);

  final CartItem item;
  final cartItemBloc = Modular.get<CartItemOverviewBloc>();

  void _onMinusTapped() => cartItemBloc.add(CartItemQuantityDecrement(item));

  void _onPlusTapped() => cartItemBloc.add(CartItemQuantityIncrement(item));

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      child: Column(
        children: [
          Expanded(
            child: QuantityButton.minus(
              borderRadius:
                  const BorderRadius.only(topRight: Radius.circular(10)),
              onTap: _onMinusTapped,
            ),
          ),
          Expanded(
            child: Container(
              color: kBasicLightColor.withOpacity(0.25),
              child: Center(
                child: FittedBox(
                  child: Text(
                    item.quantity.toStringAsFixed(item.product.fractionDigits),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: QuantityButton.plus(
              borderRadius:
                  const BorderRadius.only(bottomRight: Radius.circular(10)),
              onTap: _onPlusTapped,
            ),
          ),
        ],
      ),
    );
  }
}
