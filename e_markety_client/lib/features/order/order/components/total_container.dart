import 'package:e_markety_client/shared/extensions/double_extension.dart';
import 'package:flutter/material.dart';

import '../../../../shared/theme/constants.dart';
import '../models/delivery_tipe.dart';
import '../models/order.dart';

const spacer = SizedBox(height: 6);

class TotalContainer extends StatelessWidget {
  const TotalContainer({
    Key? key,
    required this.order,
    this.showServiceCharge = false,
  }) : super(key: key);

  final Order order;
  final bool showServiceCharge;

  Row _row(label, value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: kTitleMedium.copyWith(color: Colors.grey.shade600)),
        Text(value, style: kTitleMedium.copyWith(color: Colors.grey.shade600)),
      ],
    );
  }

  List<Widget> _deliveryChargeRow() {
    return order.deliveryType == DeliveryType.delivery
        ? [
            spacer,
            _row('Taxa de Entrega', order.formattedCharge),
          ]
        : [];
  }

  List<Widget> _discountRow() {
    return order.discount > 0
        ? [
            spacer,
            _row('Desconto', order.discount.toReal),
          ]
        : [];
  }

  List<Widget> _serviceChargeRow() {
    return showServiceCharge
        ? [
            spacer,
            _row('Taxa de Serviço', order.formattedServiceCharge),
          ]
        : [];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _row('Itens', '${order.items.length}'),
        spacer,
        _row('Subtotal', order.subTotal.toReal),
        ..._deliveryChargeRow(),
        ..._discountRow(),
        ..._serviceChargeRow(),
        const Divider(height: 16, thickness: 1),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Total', style: kHeadline6),
            const Spacer(),
            Text(order.total.toReal, style: kHeadline6),
          ],
        ),
      ],
    );
  }
}
