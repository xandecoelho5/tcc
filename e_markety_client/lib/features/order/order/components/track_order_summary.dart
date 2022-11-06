import 'package:e_markety_client/features/order/order/models/order.dart';
import 'package:flutter/material.dart';

import '../../../../shared/theme/constants.dart';
import '../../../../shared/utils/date_time_utils.dart';

class TrackOrderSummary extends StatelessWidget {
  const TrackOrderSummary({Key? key, required this.order}) : super(key: key);

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
        children: [
          const CircleAvatar(
            backgroundColor: Colors.white,
            radius: 50,
            child: Icon(
              Icons.shopping_bag_outlined,
              size: 60,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Código: #OD${order.id}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Realizado em ${DateTimeUtils.getAbbrMonth(order.createdAt!)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text(
                    'Items: ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '${order.items.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Total: ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '\$${order.total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
