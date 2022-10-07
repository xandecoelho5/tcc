import 'package:e_markety_client/features/order/components/total_container.dart';
import 'package:flutter/material.dart';

import '../../../../shared/mocks/mocks.dart';
import '../../../../shared/theme/constants.dart';
import '../../../../shared/widgets/filled_button.dart';
import 'cart_item_list.dart';

class LoadedCart extends StatelessWidget {
  const LoadedCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: CartItemList(cartItems: cartItemsMock),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TotalContainer(order: orderMock),
                ),
                const SizedBox(height: 10),
                FilledButton(
                  color: kSecondaryColor,
                  onPressed: () {},
                  text: 'Checkout',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
