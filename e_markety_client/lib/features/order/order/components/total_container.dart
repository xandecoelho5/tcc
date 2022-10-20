import 'package:flutter/material.dart';

import '../models/order.dart';

class TotalContainer extends StatelessWidget {
  const TotalContainer({
    Key? key,
    required this.order,
    this.showDiscount = false,
  }) : super(key: key);

  final Order order;
  final bool showDiscount;

  Row _row(label, value) {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _row('Item', '${order.items.length}'),
        const SizedBox(height: 8),
        _row('Sub Total', '\$${order.subTotal.toStringAsFixed(2)}'),
        const SizedBox(height: 8),
        _row('Delivery Charge', order.formattedCharge),
        if (showDiscount && order.discount > 0) const SizedBox(height: 8),
        if (showDiscount && order.discount > 0)
          _row('Discount', '\$${order.discount.toStringAsFixed(2)}'),
        const Divider(height: 20, thickness: 1),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Total',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Text(
              r'$100.00',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
