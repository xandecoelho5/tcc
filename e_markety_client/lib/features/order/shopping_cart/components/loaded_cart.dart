import 'package:flutter/material.dart';

import '../../../../shared/mocks/mocks.dart';
import '../../../../shared/theme/constants.dart';
import '../../../../shared/widgets/filled_button.dart';
import 'cart_item_list.dart';

class LoadedCart extends StatelessWidget {
  const LoadedCart({Key? key}) : super(key: key);

  _subTotal() {
    row(label, value) {
      final style = TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.grey.shade600,
      );

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(value, style: style),
        ],
      );
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          row('Item', '4'),
          const SizedBox(height: 8),
          row('Sub Total', '\$100.00'),
          const SizedBox(height: 8),
          row('Delivery Charge', 'Free'),
          const Divider(height: 30, thickness: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Total',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                '\$100.00',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

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
                _subTotal(),
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
