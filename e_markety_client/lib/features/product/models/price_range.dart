class PriceRange {
  final double min;
  final double max;

  const PriceRange({
    required this.min,
    required this.max,
  });

  factory PriceRange.fromMap(dynamic map) {
    return PriceRange(
      min: map['min'] ?? 0,
      max: map['max'] ?? 0.1,
    );
  }
}
