enum OrderStatus {
  placed(0, 'Order Placed'),
  confirmed(1, 'Order Confirmed'),
  shipped(2, 'Order Shipped'),
  outForDelivery(3, 'Out of Delivery'),
  delivered(4, 'Order Delivered');

  const OrderStatus(this.position, this.label);

  final int position;
  final String label;
}
