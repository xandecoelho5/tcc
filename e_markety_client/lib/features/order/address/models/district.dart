class District {
  final int id;
  final String name;

  const District({required this.id, required this.name});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': name,
    };
  }

  factory District.fromMap(Map<String, dynamic> map) {
    return District(
      id: map['id'],
      name: map['nome'],
    );
  }
}
