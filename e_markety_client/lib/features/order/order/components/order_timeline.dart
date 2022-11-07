import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

import '../../../../shared/theme/constants.dart';
import '../models/order_status.dart';

class OrderTimeline extends StatelessWidget {
  OrderTimeline({
    Key? key,
    required this.process,
    required this.processes,
  })  : processIndex = processes.indexOf(process),
        super(key: key);

  final OrderStatus process;
  final List<OrderStatus> processes;
  final int processIndex;

  dynamic _getColor(int index) {
    if (index <= processIndex) return kSecondaryColor;

    return Colors.grey.shade300;
  }

  DotIndicator _dotIndicator(backgroundColor, foregroundColor) {
    return DotIndicator(
      size: 60,
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(12),
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
      padding: const EdgeInsets.only(top: 12),
      theme: TimelineThemeData(
        connectorTheme: const ConnectorThemeData(thickness: 2.3),
        nodePosition: 0.1,
      ),
      builder: TimelineTileBuilder.connected(
        connectionDirection: ConnectionDirection.before,
        itemExtent: 80,
        contentsBuilder: (context, index) {
          final notProcessed = index > processIndex;
          return Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  processes[index].label,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: notProcessed ? kDarkGreyColor : kSecondaryColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  notProcessed ? 'Pendente' : 'Jan 26, 2021',
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
        itemCount: processes.length,
      ),
    );
  }
}
