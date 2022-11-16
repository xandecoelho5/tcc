class MonthlyOrders {
  final int month;
  final int year;
  final int count;

  const MonthlyOrders({
    required this.month,
    required this.year,
    required this.count,
  });

  factory MonthlyOrders.fromMap(dynamic map) {
    return MonthlyOrders(
      month: map['mes'],
      year: map['ano'],
      count: map['quantidade'],
    );
  }
}
