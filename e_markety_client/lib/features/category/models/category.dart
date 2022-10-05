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
}
