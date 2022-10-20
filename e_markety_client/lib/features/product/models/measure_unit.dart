class MeasureUnit {
  final int id;
  final String description;

  const MeasureUnit({
    required this.id,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'descricao': description,
    };
  }

  factory MeasureUnit.fromMap(Map<String, dynamic> map) {
    return MeasureUnit(
      id: map['id'],
      description: map['descricao'],
    );
  }

  @override
  String toString() {
    return 'MeasureUnit{id: $id, description: $description}';
  }
}
