import 'package:e_markety_client/features/order/shopping_cart/models/cart_item.dart';
import 'package:flutter/material.dart';

import '../../../../shared/mocks/mocks.dart';
import '../../../../shared/theme/constants.dart';
import '../../../../shared/widgets/filled_button.dart';
import '../../order/components/total_container.dart';
import 'cart_item_list.dart';

class LoadedCart extends StatelessWidget {
  const LoadedCart({Key? key, required this.cartItems}) : super(key: key);

  final List<CartItem> cartItems;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: CartItemList(cartItems: cartItems),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TotalContainer(order: orderMock),
                ),
                const SizedBox(height: 10),
                Flexible(
                  child: FilledButton(
                    color: kSecondaryColor,
                    onPressed: () {},
                    text: 'Checkout',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
