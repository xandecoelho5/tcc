enum DeliveryType {
  pickup('Retirada'),
  delivery('Entrega');

  const DeliveryType(this.label);

  final String label;

  static DeliveryType fromString(String value) {
    switch (value.toUpperCase()) {
      case 'ENTREGA':
        return DeliveryType.delivery;
      case 'RETIRADA':
      default:
        return DeliveryType.pickup;
    }
  }

  String toRemoteName() {
    switch (this) {
      case DeliveryType.pickup:
        return 'RETIRADA';
      case DeliveryType.delivery:
        return 'ENTREGA';
    }
  }
}
