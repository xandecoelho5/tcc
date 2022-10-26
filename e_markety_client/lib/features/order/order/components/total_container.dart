import 'package:flutter/material.dart';

import '../models/delivery_tipe.dart';
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

  List<Widget> _deliveryChargeRow() {
    return order.deliveryType == DeliveryType.delivery
        ? [
            const SizedBox(height: 8),
            _row('Taxa de Entrega', order.formattedCharge),
          ]
        : [];
  }

  List<Widget> _discountRow() {
    return showDiscount && order.discount > 0
        ? [
            const SizedBox(height: 8),
            _row('Discount', '\$${order.discount.toStringAsFixed(2)}'),
          ]
        : [];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _row('Items', '${order.items.length}'),
        const SizedBox(height: 8),
        _row('Subtotal', '\$${order.subTotal.toStringAsFixed(2)}'),
        ..._deliveryChargeRow(),
        ..._discountRow(),
        const Divider(height: 20, thickness: 1),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Total',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Text(
              '\$${order.calculateTotal().toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
