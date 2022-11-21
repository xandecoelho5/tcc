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

  DotIndicator _dotIndicator(index, backgroundColor, foregroundColor) {
    return DotIndicator(
      size: 60,
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Image.asset(
          processes[index].icon,
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
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              processes[index].label,
              style: kHeadline6.copyWith(
                color: notProcessed ? kDarkGreyColor : kSecondaryColor,
                letterSpacing: -0.3,
              ),
            ),
          );
        },
        indicatorBuilder: (_, index) {
          if (index <= processIndex) {
            return _dotIndicator(index, kWeakSecondaryColor, kSecondaryColor);
          }
          return _dotIndicator(index, Colors.grey.shade300, kDarkGreyColor);
        },
        connectorBuilder: (_, i, __) => SolidLineConnector(color: _getColor(i)),
        itemCount: processes.length,
      ),
    );
  }
}
