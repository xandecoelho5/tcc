enum DeliveryType {
  pickup('Retirada'),
  delivery('Entrega');

  static DeliveryType fromString(String value) {
    switch (value.toUpperCase()) {
      case 'ENTREGA':
        return DeliveryType.delivery;
      case 'RETIRADA':
      default:
        return DeliveryType.pickup;
    }
  }

  const DeliveryType(this.label);

  final String label;
}
