class ProductsSales {
  final String name;
  final double sales;

  const ProductsSales({
    required this.name,
    required this.sales,
  });

  factory ProductsSales.fromMap(dynamic map) {
    return ProductsSales(
      name: map['nome'],
      sales: map['quantidade'],
    );
  }
}
