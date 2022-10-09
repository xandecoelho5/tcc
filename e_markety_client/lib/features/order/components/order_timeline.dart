import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

import '../../../shared/theme/constants.dart';
import '../models/order_status.dart';

class OrderTimeline extends StatelessWidget {
  const OrderTimeline({Key? key, required this.processIndex}) : super(key: key);

  final int processIndex;

  _getColor(int index) {
    if (index <= processIndex) return kSecondaryColor;

    return Colors.grey.shade300;
  }

  _dotIndicator(backgroundColor, foregroundColor) {
    return DotIndicator(
      size: 72,
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Image.asset(
          'assets/icons/fruits_and_vegetables.png',
          color: foregroundColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Timeline.tileBuilder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      theme: TimelineThemeData(
        connectorTheme: const ConnectorThemeData(thickness: 2.3),
        nodePosition: 0.15,
      ),
      builder: TimelineTileBuilder.connected(
        connectionDirection: ConnectionDirection.before,
        itemExtent: 110,
        contentsBuilder: (context, index) {
          final notProcessed = index > processIndex;
          return Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  OrderStatus.values[index].label,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: notProcessed ? kDarkGreyColor : kSecondaryColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  notProcessed ? 'Pending' : 'Jan 26, 2021',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: notProcessed ? Colors.grey : kDarkGreyColor,
                  ),
                ),
              ],
            ),
          );
        },
        indicatorBuilder: (_, index) {
          if (index <= processIndex) {
            return _dotIndicator(kWeakSecondaryColor, kSecondaryColor);
          }
          return _dotIndicator(Colors.grey.shade300, kDarkGreyColor);
        },
        connectorBuilder: (_, i, __) => SolidLineConnector(color: _getColor(i)),
        itemCount: OrderStatus.values.length,
      ),
    );
  }
}
