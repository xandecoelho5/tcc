class MeasureUnit {
  final int id;
  final String description;

  const MeasureUnit({
    required this.id,
    required this.description,
  });

  factory MeasureUnit.fromMap(Map<String, dynamic> map) {
    return MeasureUnit(
      id: map['id'],
      description: map['descricao'],
    );
  }
}
