import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:e_markety_client/shared/utils/date_time_utils.dart';
import 'package:flutter/material.dart';

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

  Material _icon() {
    return Material(
      shape: const CircleBorder(
        side: BorderSide(
          color: Colors.white,
          width: 4,
        ),
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

  Column _details() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Código: #OD${widget.order.id}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Realizado em: ${DateTimeUtils.getAbbrMonth(widget.order.createdAt)}',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(
              'Items:',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.order.items.length.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 16),
            Text(
              'Total:',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '\$${widget.order.total.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }

  Material _expandIcon(onTap) {
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
          child: Icon(
            _expanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
          ),
        ),
      ),
    );
  }

  Container _firstChild() {
    return Container(
      decoration: kDecorationBottomRadiusCircularBorder,
      padding: EdgeInsets.only(
        top: 20,
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
            DateTimeUtils.getAbbrMonth(widget.order.createdAt),
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
      height: 185,
      decoration: kDecorationBottomRadiusCircularBorder,
      child: OrderSimplerTimeline(
        process: widget.order.status,
        processes: processes,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Row(
              children: [
                _icon(),
                const SizedBox(width: 20),
                _details(),
                const Spacer(),
                _expandIcon(() => setState(() => _expanded = !_expanded)),
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
    );
  }
}
