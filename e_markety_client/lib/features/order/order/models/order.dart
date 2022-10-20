import 'package:e_markety_client/features/order/address/models/address.dart';

import '../../shopping_cart/models/cart_item.dart';
import 'delivery_tipe.dart';
import 'order_status.dart';

class Order {
  final int id;
  final DateTime createdAt;
  final double total;
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
    required this.total,
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

  double calculateTotal() => subTotal + (deliveryCharge ?? 0);

  String get formattedCharge => deliveryCharge != null && deliveryCharge! > 0
      ? '\$ ${deliveryCharge!.toStringAsFixed(2)}'
      : 'Free';

  double get discount => items.fold(
        0,
        (total, item) => total + item.product.discount * item.quantity,
      );

  factory Order.fromMap(dynamic map) {
    return Order(
      id: map['id'],
      createdAt: DateTime.parse(map['data']),
      total: map['total'],
      deliveryType: DeliveryType.fromString(map['tipoEntrega']),
      items: (map['items'] as List).map(CartItem.fromMap).toList(),
      notes: map['observacao'],
      deliveryAddress:
          map['endereco'] == null ? null : Address.fromMap(map['endereco']),
      deliveryTime: map['endereco'] == null
          ? null
          : DateTime.parse(map['horarioEntrega']),
      deliveryCharge: map['taxaEntrega'],
      status: OrderStatus.fromString(map['status']),
    );
  }
}
