import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

import '../../../../shared/theme/constants.dart';
import '../models/order_status.dart';

class OrderSimplerTimeline extends StatelessWidget {
  OrderSimplerTimeline({
    Key? key,
    required this.processIndex,
  })  : delivered = processIndex == OrderStatus.delivered.index,
        super(key: key);

  final int processIndex;
  final bool delivered;

  Color _getColor(int index) {
    if (delivered) return kSecondaryColor;

    if (index <= processIndex) return kPrimaryColor;

    return Colors.grey.shade300;
  }

  @override
  Widget build(BuildContext context) {
    return Timeline.tileBuilder(
      padding: const EdgeInsets.symmetric(vertical: 12),
      theme: TimelineThemeData(nodePosition: 0.06),
      builder: TimelineTileBuilder.connected(
        connectionDirection: ConnectionDirection.before,
        itemExtent: 32,
        contentsBuilder: (context, index) {
          final notProcessed = index > processIndex;
          return Padding(
            padding: const EdgeInsets.only(left: 16, right: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  OrderStatus.values[index].label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: notProcessed
                        ? kDarkGreyColor
                        : delivered
                            ? kSecondaryColor
                            : kPrimaryColor,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  notProcessed ? 'Pending' : 'Jan 26, 2021',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kDarkGreyColor,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          );
        },
        indicatorBuilder: (_, index) => DotIndicator(
          size: 14,
          color: _getColor(index),
        ),
        connectorBuilder: (_, i, __) => SolidLineConnector(color: _getColor(i)),
        itemCount: OrderStatus.values.length,
      ),
    );
  }
}
