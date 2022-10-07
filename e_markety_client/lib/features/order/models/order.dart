import 'package:e_markety_client/features/order/address/models/address.dart';
import 'package:e_markety_client/features/order/models/delivery_tipe.dart';

import '../shopping_cart/models/cart_item.dart';
import 'order_status.dart';

class Order {
  final int id;
  final DateTime createdAt;
  final DeliveryType deliveryType;
  final List<CartItem> items;
  final String notes;
  final Address? deliveryAddress;
  final DateTime? deliveryTime; // hora da entrega
  final double? deliveryCharge;
  final OrderStatus status;

  const Order({
    required this.id,
    required this.createdAt,
    required this.deliveryType, // TODO adiconar asserts para obrigar a passar o endereço
    required this.items,
    required this.notes,
    this.deliveryAddress,
    this.deliveryTime,
    this.deliveryCharge,
    this.status = OrderStatus.placed,
  });

  double get subTotal => items.fold(
        0,
        (total, item) => total + item.product.finalPrice * item.quantity,
      );

  double get total => subTotal + (deliveryCharge ?? 0);

  String get formattedCharge => deliveryCharge != null && deliveryCharge! > 0
      ? '\$ ${deliveryCharge!.toStringAsFixed(2)}'
      : 'Free';

  double get discount => items.fold(
        0,
        (total, item) => total + item.product.discount * item.quantity,
      );
}
