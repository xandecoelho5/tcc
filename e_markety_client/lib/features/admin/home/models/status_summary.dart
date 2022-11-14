import 'package:e_markety_client/features/order/order/models/order_status.dart';

class StatusSummary {
  final OrderStatus status;
  final double percentage;

  const StatusSummary({
    required this.status,
    required this.percentage,
  });

  factory StatusSummary.fromMap(dynamic map) {
    return StatusSummary(
      status: OrderStatus.fromString(map['status']),
      percentage: map['percentual'],
    );
  }
}
