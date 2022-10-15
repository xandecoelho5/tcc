import 'dart:ui';

class Category {
  final int id;
  final String name;
  final String imageUrl;
  final String iconUrl;
  final Color color;

  const Category({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.iconUrl,
    required this.color,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'iconUrl': iconUrl,
      'color': color,
    };
  }

  factory Category.fromMap(dynamic map) {
    return Category(
      id: map['id'],
      name: map['nome'],
      imageUrl: map['imagemUrl'],
      iconUrl: map['iconUrl'],
      color: Color(int.parse(map['cor'])),
    );
  }
}
