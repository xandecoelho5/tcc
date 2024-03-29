import 'package:e_markety_client/features/order/order/models/order.dart';
import 'package:e_markety_client/shared/extensions/double_extension.dart';
import 'package:flutter/material.dart';

import '../../../../shared/theme/constants.dart';
import '../../../../shared/utils/assets.dart';
import '../../../../shared/utils/date_time_utils.dart';

class TrackOrderSummary extends StatelessWidget {
  const TrackOrderSummary({Key? key, required this.order}) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: kSecondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 40,
            child: Image.asset(
              Assets.shoppingBag,
              width: 55,
              color: kBasicDarkColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: FittedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Código: #OD${order.id}', style: kTitleLargeLight),
                  const SizedBox(height: 4),
                  Text(
                    'Data: ${DateTimeUtils.getAbbrMonth(order.createdAt ?? DateTime.now())}',
                    style: kLabelLargeLight,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text('Items: ', style: kTitleRegular),
                      Text('${order.items.length}', style: kTitleLargeLight),
                      const SizedBox(width: 10),
                      const Text('Total: ', style: kTitleRegular),
                      Text(order.total.toReal, style: kTitleLargeLight),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
