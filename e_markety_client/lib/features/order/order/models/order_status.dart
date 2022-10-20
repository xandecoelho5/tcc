enum OrderStatus {
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
      case 'REALIZADO':
      default:
        return OrderStatus.placed;
    }
  }
}
