import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:e_markety_client/shared/widgets/quantity_button.dart';
import 'package:flutter/material.dart';

import '../models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({Key? key, required this.item}) : super(key: key);

  final CartItem item;

  _quantityButtons() {
    return SizedBox(
      width: 35,
      child: Column(
        children: [
          const Expanded(
            child: QuantityButton(
              icon: '-',
              borderRadius: BorderRadius.only(topRight: Radius.circular(10)),
            ),
          ),
          Expanded(
            child: Container(
              color: kBasicLightColor.withOpacity(0.25),
              child: Center(
                child: Text(
                  '${item.quantity}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const Expanded(
            child: QuantityButton(
              icon: '+',
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(10)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Image.network(
            item.product.imageUrl,
            width: 110,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\$${item.product.finalPrice.toStringAsFixed(2)} x ${item.quantity}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kSecondaryColor,
                  ),
                ),
                Text(
                  item.product.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  item.product.formattedWeight,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          _quantityButtons(),
        ],
      ),
    );
  }
}
