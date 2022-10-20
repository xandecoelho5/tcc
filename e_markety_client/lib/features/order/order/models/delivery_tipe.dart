enum DeliveryType {
  pickup,
  delivery;

  static DeliveryType fromString(String value) {
    switch (value.toUpperCase()) {
      case 'ENTREGA':
        return DeliveryType.delivery;
      case 'RETIRADA':
      default:
        return DeliveryType.pickup;
    }
  }
}
