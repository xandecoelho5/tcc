import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:e_markety_client/shared/utils/date_time_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../models/delivery_tipe.dart';
import '../models/order.dart';
import '../models/order_status.dart';
import 'order_simpler_timeline.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key, required this.order}) : super(key: key);

  final Order order;

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  late bool _expanded = widget.order.status != OrderStatus.delivered;
  late Color color = widget.order.status == OrderStatus.delivered
      ? kSecondaryColor
      : kPrimaryColor;

  late final processes = widget.order.deliveryType == DeliveryType.delivery
      ? OrderStatus.caseDelivery()
      : OrderStatus.casePickup();

  Container _firstChild() {
    return Container(
      decoration: kDecorationBottomRadiusCircularBorder,
      padding: EdgeInsets.only(
        top: 16,
        left: MediaQuery.of(context).size.width * 0.05,
        bottom: 16,
        right: 24,
      ),
      child: Row(
        children: [
          Icon(Icons.circle, color: color, size: 16),
          const SizedBox(width: 15),
          Text(
            widget.order.status.label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: kDarkGreyColor,
              letterSpacing: -0.5,
            ),
          ),
          const Spacer(),
          Text(
            DateTimeUtils.getAbbrMonth(widget.order.createdAt!),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: kDarkGreyColor,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }

  Container _secondChild() {
    return Container(
      height: 38.0 * processes.length,
      decoration: kDecorationBottomRadiusCircularBorder,
      child: OrderSimplerTimeline(
        process: widget.order.status,
        processes: processes,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            boxShadow: kElevationToShadow[2],
          ),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Row(
                  children: [
                    _OrderIcon(color: color),
                    const SizedBox(width: 12),
                    _Details(order: widget.order),
                    const Spacer(),
                    _ActionButton(
                      color: color,
                      onTap: () => setState(() => _expanded = !_expanded),
                      icon: _expanded
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_up,
                    ),
                  ],
                ),
              ),
              AnimatedCrossFade(
                firstChild: _firstChild(),
                secondChild: _secondChild(),
                crossFadeState: _expanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 200),
              ),
            ],
          ),
        ),
        if (widget.order.status != OrderStatus.delivered)
          Positioned(
            top: 0,
            right: 0,
            child: _ActionButton(
              color: color,
              onTap: () => Modular.to.pushNamed('/order/track-order'),
              icon: Icons.track_changes,
            ),
          ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    Key? key,
    required this.color,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  final VoidCallback? onTap;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      elevation: 0.1,
      child: InkWell(
        onTap: onTap,
        splashColor: color,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Icon(icon),
        ),
      ),
    );
  }
}

class _OrderIcon extends StatelessWidget {
  const _OrderIcon({Key? key, required this.color}) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const CircleBorder(
        side: BorderSide(color: Colors.white, width: 4),
      ),
      elevation: 12,
      child: Container(
        decoration: ShapeDecoration(
          color: color.withOpacity(0.15),
          shape: const CircleBorder(),
        ),
        padding: const EdgeInsets.all(12),
        child: Image.asset(
          'assets/icons/fruits_and_vegetables.png',
          color: color,
          width: 35,
          height: 40,
        ),
      ),
    );
  }
}

class _Details extends StatelessWidget {
  const _Details({Key? key, required this.order}) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    final detailStyle = TextStyle(
      color: Colors.grey.shade600,
      fontWeight: FontWeight.bold,
      fontSize: 13,
    );

    return Expanded(
      flex: 4,
      child: FittedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Código: #OD${order.id}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'Data: ${DateTimeUtils.getAbbrMonth(order.createdAt!)}',
              style: detailStyle,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text('Items:', style: detailStyle),
                Text(
                  order.items.length.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 16),
                Text('Total:', style: detailStyle),
                Text(
                  '\$${order.total.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
