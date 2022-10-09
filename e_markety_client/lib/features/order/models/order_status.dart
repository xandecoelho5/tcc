enum OrderStatus {
  placed('Order Placed'),
  confirmed('Order Confirmed'),
  shipped('Order Shipped'),
  outForDelivery('Out of Delivery'),
  delivered('Order Delivered');

  const OrderStatus(this.label);

  final String label;
}
