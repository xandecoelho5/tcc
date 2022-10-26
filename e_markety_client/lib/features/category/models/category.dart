import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  final int id;
  final String name;
  final String imageUrl;
  final String iconUrl;
  final String colorString;

  const Category({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.iconUrl,
    required this.colorString,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': name,
      'imagemUrl': imageUrl,
      'iconUrl': iconUrl,
      'cor': colorString,
    };
  }

  factory Category.fromMap(dynamic map) {
    return Category(
      id: map['id'],
      name: map['nome'],
      imageUrl: map['imagemUrl'],
      iconUrl: map['iconUrl'],
      colorString: map['cor'],
    );
  }

  Color get color => Color(int.parse(colorString));

  @override
  String toString() {
    return 'Category{id: $id, name: $name}';
  }

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
