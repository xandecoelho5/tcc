import 'package:e_markety_client/features/order/address/models/address.dart';
import 'package:e_markety_client/shared/extensions/double_extension.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../shopping_cart/models/cart_item.dart';
import 'delivery_tipe.dart';
import 'order_status.dart';

@JsonSerializable(explicitToJson: true)
class Order {
  final int id;
  final DateTime? createdAt;
  final double total;
  final DeliveryType deliveryType;
  final List<CartItem> items;
  final String? notes;
  final Address? deliveryAddress;
  final DateTime? deliveryTime;
  final double? deliveryCharge;
  final double serviceCharge;
  final OrderStatus status;

  const Order({
    required this.id,
    this.createdAt,
    required this.total,
    required this.deliveryType,
    required this.items,
    required this.notes,
    this.deliveryAddress,
    this.deliveryTime,
    this.deliveryCharge,
    required this.serviceCharge,
    this.status = OrderStatus.placed,
  });

  double get subTotal => items.fold(
        0,
        (total, item) => total + item.unitPrice * item.quantity,
      );

  double get discount => items.fold(
        0,
        (total, item) => total + item.product.discount * item.quantity,
      );

  String get formattedCharge => deliveryCharge == null
      ? '???'
      : deliveryCharge! > 0
          ? deliveryCharge!.toReal
          : 'Grátis';

  String get formattedServiceCharge =>
      serviceCharge > 0 ? serviceCharge.toReal : 'Grátis';

  double get calculatedTotal =>
      subTotal + (deliveryCharge ?? 0) + serviceCharge - discount;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dataCriacao': createdAt?.toIso8601String(),
      'total': total,
      'tipoEntrega': deliveryType.toRemoteName(),
      'items': items.map((e) => e.toMap()).toList(),
      'observacao': notes,
      'endereco': deliveryAddress?.toMap(),
      'horarioEntrega': deliveryTime?.toIso8601String(),
      'taxaEntrega': deliveryCharge,
      'taxaServico': serviceCharge,
      'status': status.toRemoteName(),
    };
  }

  factory Order.fromMap(dynamic map) {
    return Order(
      id: map['id'],
      createdAt: DateTime.parse(map['dataCriacao']),
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
      serviceCharge: map['taxaServico'],
      status: OrderStatus.fromString(map['status']),
    );
  }

  Order copyWith({
    int? id,
    double? total,
    DeliveryType? deliveryType,
    List<CartItem>? items,
    String? notes,
    Address? deliveryAddress,
    DateTime? deliveryTime,
    double? deliveryCharge,
    double? serviceCharge,
    OrderStatus? status,
  }) {
    return Order(
      id: id ?? this.id,
      createdAt: createdAt,
      total: total ?? this.total,
      deliveryType: deliveryType ?? this.deliveryType,
      items: (items != null && items.isNotEmpty) ? items : this.items,
      notes: notes ?? this.notes,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      deliveryCharge: deliveryCharge ?? this.deliveryCharge,
      serviceCharge: serviceCharge ?? this.serviceCharge,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return 'Order{id: $id, createdAt: $createdAt, total: $total, '
        'deliveryType: $deliveryType, items: $items, notes: $notes, '
        'deliveryAddress: $deliveryAddress, deliveryTime: $deliveryTime, '
        'deliveryCharge: $deliveryCharge, serviceCharge: $serviceCharge, '
        'status: $status}';
  }
}
