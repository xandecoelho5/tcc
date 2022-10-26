enum OrderStatus {
  pending('Pedido Pendente'),
  placed('Pedido Realizado'),
  confirmed('Pedido Confirmado'),
  readyToPickup('Pronto para Retirada'),
  readyToDeliver('Pronto para Entrega'),
  outForDelivery('Saiu para Entrega'),
  delivered('Entregue');

  const OrderStatus(this.label);

  final String label;

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
