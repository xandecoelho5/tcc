import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../shared/utils/assets.dart';
import '../../../admin/order/notifiers/order_notifier.dart';

enum OrderStatus {
  pending('Pedido Pendente', Colors.blueGrey, Assets.placed),
  placed('Pedido Realizado', Colors.teal, Assets.placed),
  confirmed('Pedido Confirmado', Colors.deepOrange, Assets.confirmed),
  readyToPickup('Pronto para Retirada', Colors.deepPurpleAccent, Assets.ready),
  readyToDeliver('Pronto para Entrega', Colors.deepPurple, Assets.ready),
  outForDelivery('Saiu para Entrega', Colors.blue, Assets.delivery),
  delivered('Entregue', Colors.green, Assets.sent);

  const OrderStatus(this.label, this.color, this.icon);

  final String label;
  final Color color;
  final String icon;

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

  String toRemoteName() {
    switch (this) {
      case OrderStatus.pending:
        return 'PENDENTE';
      case OrderStatus.placed:
        return 'REALIZADO';
      case OrderStatus.confirmed:
        return 'CONFIRMADO';
      case OrderStatus.readyToPickup:
        return 'PRONTO_PARA_RETIRADA';
      case OrderStatus.readyToDeliver:
        return 'PRONTO_PARA_ENTREGA';
      case OrderStatus.outForDelivery:
        return 'SAIU_PARA_ENTREGA';
      case OrderStatus.delivered:
        return 'ENTREGUE';
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

  Map<String, VoidCallback> popupActions(int id) {
    final cancelar = {
      'Cancelar': () {
        print('Cancelar');
      },
    };

    Future<void> updateAction() =>
        Modular.get<OrderNotifier>().updateOrderStatus(id);

    switch (this) {
      case OrderStatus.pending:
        return {};
      case OrderStatus.placed:
        return {
          'Confirmado': updateAction,
          ...cancelar,
        };
      case OrderStatus.confirmed:
        return {
          'Pronto': updateAction,
          ...cancelar,
        };
      case OrderStatus.readyToPickup:
        return {
          'Entregue': updateAction,
          ...cancelar,
        };
      case OrderStatus.readyToDeliver:
        return {
          'Saiu para entrega': updateAction,
          ...cancelar,
        };
      case OrderStatus.outForDelivery:
        return {
          'Entregue': updateAction,
          ...cancelar,
        };
      case OrderStatus.delivered:
        return {};
    }
  }
}
