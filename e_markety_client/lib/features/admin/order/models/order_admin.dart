import 'package:e_markety_client/features/user/models/user.dart';

import '../../../order/order/models/order.dart';
import '../../../order/order/models/order_status.dart';

class OrderAdmin extends Order {
  final User user;

  const OrderAdmin({
    required super.id,
    required super.createdAt,
    required super.total,
    required super.deliveryType,
    required super.items,
    required super.notes,
    super.deliveryAddress,
    super.deliveryTime,
    super.deliveryCharge,
    super.status = OrderStatus.placed,
    required this.user,
  });

  OrderAdmin.fromOrder(Order order, this.user)
      : super(
          id: order.id,
          createdAt: order.createdAt,
          total: order.total,
          deliveryType: order.deliveryType,
          items: order.items,
          notes: order.notes,
          deliveryAddress: order.deliveryAddress,
          deliveryTime: order.deliveryTime,
          deliveryCharge: order.deliveryCharge,
          status: order.status,
        );

  factory OrderAdmin.fromMap(dynamic map) {
    return OrderAdmin.fromOrder(
      Order.fromMap(map),
      User.fromMap(map['usuario']),
    );
  }

  @override
  String toString() {
    return 'Order{id: $id, createdAt: $createdAt, total: $total, '
        'deliveryType: $deliveryType, items: $items, notes: $notes, '
        'deliveryAddress: $deliveryAddress, deliveryTime: $deliveryTime, '
        'deliveryCharge: $deliveryCharge, status: $status, user: $user}';
  }
}
