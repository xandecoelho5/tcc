import 'package:e_markety_client/features/order/address/models/address.dart';
import 'package:flutter/material.dart';

import '../../../../shared/theme/constants.dart';

class AddressInfo extends StatelessWidget {
  const AddressInfo({Key? key, required this.address}) : super(key: key);

  final Address address;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(address.tag.label, style: kHeadline6),
        const SizedBox(height: 8),
        Text(
          address.fullAddress,
          style: kTitleMedium.copyWith(color: Colors.grey.shade700),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Text('Telefone: ', style: kTitleMedium),
            Text(
              address.phone,
              style: kTitleMedium.copyWith(color: Colors.grey.shade700),
            ),
          ],
        ),
      ],
    );
  }
}
