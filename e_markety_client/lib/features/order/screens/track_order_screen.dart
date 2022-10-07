import 'package:e_markety_client/features/order/models/order.dart';
import 'package:e_markety_client/features/order/models/order_status.dart';
import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:e_markety_client/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

class TrackOrderScreen extends StatefulWidget {
  const TrackOrderScreen({Key? key, required this.order}) : super(key: key);

  final Order order;

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  _orderSummary() {
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
                'Order ID: #OD${widget.order.id}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Placed on Jan 26, 2021',
                style: TextStyle(
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
                    '${widget.order.items.length}',
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
                    '\$${widget.order.total.toStringAsFixed(2)}',
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

  _stepper(context) {
    final processIndex = widget.order.status.position;

    Color getColor(int index) {
      if (index <= processIndex) {
        return kSecondaryColor;
      }
      return Colors.grey.shade300; // kDarkGreyColor; // Color(0xffd1d2d7)
    }

    dotIndicator(backgroundColor, foregroundColor) {
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

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Timeline.tileBuilder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        theme: TimelineThemeData(
          direction: Axis.vertical,
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
              return dotIndicator(kWeakSecondaryColor, kSecondaryColor);
            }
            return dotIndicator(Colors.grey.shade300, kDarkGreyColor);
          },
          connectorBuilder: (_, index, type) {
            if (index > 0) {
              if (index == processIndex) {
                final prevColor = getColor(index - 1);
                final color = getColor(index);
                List<Color> gradientColors;
                if (type == ConnectorType.start) {
                  gradientColors = [Color.lerp(prevColor, color, 0.5)!, color];
                } else {
                  gradientColors = [
                    prevColor,
                    Color.lerp(prevColor, color, 0.5)!
                  ];
                }
                return DecoratedLineConnector(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: gradientColors),
                  ),
                );
              }
              return SolidLineConnector(color: getColor(index));
            }
            return null;
          },
          itemCount: OrderStatus.values.length,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(context, title: 'Track Order'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _orderSummary(),
            const SizedBox(height: 20),
            Expanded(child: _stepper(context)),
          ],
        ),
      ),
    );
  }
}
