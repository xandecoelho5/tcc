import 'package:e_markety_client/features/order/order/models/delivery_tipe.dart';
import 'package:flutter/material.dart';

import '../../../../shared/theme/constants.dart';

class DeliveryTypeSwitch extends StatelessWidget {
  const DeliveryTypeSwitch({
    Key? key,
    required this.deliveryType,
    required this.onDeliveryTypeChanged,
  }) : super(key: key);

  final DeliveryType deliveryType;
  final Function(bool) onDeliveryTypeChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: kElevationToShadow[1],
      ),
      child: SwitchListTile.adaptive(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        activeColor: kSecondaryColor,
        value: deliveryType == DeliveryType.delivery,
        onChanged: onDeliveryTypeChanged,
        title: Text(deliveryType.label),
        subtitle: const Text('Escolha o tipo de entrega'),
      ),
    );
  }
}
