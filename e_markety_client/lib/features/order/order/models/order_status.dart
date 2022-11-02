import 'package:flutter/material.dart';

enum OrderStatus {
  pending('Pedido Pendente', Colors.blueGrey),
  placed('Pedido Realizado', Colors.teal),
  confirmed('Pedido Confirmado', Colors.deepOrange),
  readyToPickup('Pronto para Retirada', Colors.yellow),
  readyToDeliver('Pronto para Entrega', Colors.yellow),
  outForDelivery('Saiu para Entrega', Colors.blue),
  delivered('Entregue', Colors.green);

  const OrderStatus(this.label, this.color);

  final String label;
  final Color color;

  static OrderStatus fromString(String value) {
    switch (value.toUpperCase()) {
      case 'REALIZADO':
        return OrderStatus.placed;
      case 'CONFIRMADO':
        return OrderStatus.confirmed;
      case 'PRONTO_PARA_RETIRADA':
        return OrderStatus.readyToPickup;
      case 'PRONTO_PARA_ENTREGA':
        return OrderStatus.readyToDeliver;
      case 'SAIU_PARA_ENTREGA':
        return OrderStatus.outForDelivery;
      case 'ENTREGUE':
        return OrderStatus.delivered;
      case 'PENDENTE':
      default:
        return OrderStatus.pending;
    }
  }

  static List<OrderStatus> casePickup() {
    return [
      OrderStatus.placed,
      OrderStatus.confirmed,
      OrderStatus.readyToPickup,
      OrderStatus.delivered,
    ];
  }

  static List<OrderStatus> caseDelivery() {
    return [
      OrderStatus.placed,
      OrderStatus.confirmed,
      OrderStatus.readyToDeliver,
      OrderStatus.outForDelivery,
      OrderStatus.delivered,
    ];
  }
}
