import 'package:e_markety_client/features/order/order/models/order.dart';
import 'package:flutter/material.dart';

import '../../../../shared/theme/constants.dart';

const style = TextStyle(
  fontSize: 18,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

class CheckoutHeader extends StatelessWidget {
  const CheckoutHeader({Key? key, required this.order}) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: kSecondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Código do Pedido', style: style),
          Text('#OD${order.id}', style: style),
        ],
      ),
    );
  }
}
