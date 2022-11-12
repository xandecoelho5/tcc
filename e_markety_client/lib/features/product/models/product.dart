import 'package:e_markety_client/features/category/models/category.dart';
import 'package:e_markety_client/features/product/models/measure_unit.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable(explicitToJson: true)
class Product extends Equatable {
  final int? id;
  final String name;
  final String imageUrl;
  final String description;
  final double price;
  final DateTime? createdAt;
  final double stock;
  final double quantitySold;
  final double weightPrice; // In Kg, L, UN
  final double weightUnit; // Kg, L, UN

  final int discountPercent;

  final Category? category;
  final MeasureUnit? measureUnit;

  const Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.createdAt,
    required this.stock,
    required this.quantitySold,
    required this.weightPrice,
    required this.weightUnit,
    required this.discountPercent,
    required this.category,
    required this.measureUnit,
  });

  const Product.empty({
    this.id,
    this.name = '',
    this.imageUrl = '',
    this.description = '',
    this.price = 0,
    this.createdAt,
    this.stock = 0,
    this.quantitySold = 0,
    this.weightPrice = 0,
    this.weightUnit = 0,
    this.discountPercent = 0,
    this.category,
    this.measureUnit,
  });

  bool get isNew =>
      createdAt?.isAfter(DateTime.now().subtract(const Duration(days: 7))) ??
      false;

  bool get hasPromotion => discountPercent > 0;

  double get promotionPrice => price - (price * discountPercent / 100);

  double get finalPrice {
    return hasPromotion ? promotionPrice : price;
  }

  double get discount => hasPromotion ? (price - promotionPrice) : 0;

  String get formattedDiscount => hasPromotion ? '$discountPercent%' : '-';

  String get formattedWeight {
    if (weightPrice < 1) {
      return '${(weightPrice * 1000).toInt()} G';
    }

    final decimal = weightPrice - weightPrice.toInt();
    if (decimal == 0) {
      return '${weightPrice.toInt()} kg';
    }

    return '${weightPrice.toInt()} kg ${(decimal * 1000).toInt()} G';
  }

  int get fractionDigits {
    if (measureUnit?.description == 'UN') {
      return 0;
    }
    return 2;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': name,
      'imagemUrl': imageUrl,
      'descricao': description,
      'preco': price,
      'dataCriacao': createdAt?.toIso8601String(),
      'estoque': stock,
      'quantidadeVendida': quantitySold,
      'pesoPreco': weightPrice,
      'pesoUnidade': weightUnit,
      'percentualDesconto': discountPercent,
      'categoria': category?.toMap(),
      'unidadeMedida': measureUnit?.toMap(),
    };
  }

  factory Product.fromMap(dynamic map) {
    return Product(
      id: map['id'],
      name: map['nome'],
      imageUrl: map['imagemUrl'],
      description: map['descricao'],
      price: map['preco'],
      createdAt: DateTime.parse(map['dataCriacao']),
      stock: map['estoque'],
      quantitySold: map['quantidadeVendida'],
      weightPrice: map['pesoPreco'],
      weightUnit: map['pesoUnidade'],
      discountPercent: map['percentualDesconto'],
      category: Category.fromMap(map['categoria']),
      measureUnit: MeasureUnit.fromMap(map['unidadeMedida']),
    );
  }

  @override
  String toString() {
    return 'Product{id: $id, name: $name, imageUrl: $imageUrl, description: $description, price: $price, createdAt: $createdAt, stock: $stock, quantitySold: $quantitySold, weightPrice: $weightPrice, weightUnit: $weightUnit, discountPercent: $discountPercent, category: $category, measureUnit: $measureUnit}';
  }

  // @override
  // String toString() {
  //   return 'Product{id: $id}';
  // }

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  Product copyWith({
    String? name,
    String? imageUrl,
    String? description,
    double? price,
    double? stock,
    double? quantitySold,
    double? weightPrice,
    double? weightUnit,
    int? discountPercent,
    Category? category,
    MeasureUnit? measureUnit,
  }) {
    return Product(
      id: id,
      name: name ?? this.name,
      imageUrl:
          imageUrl != null && imageUrl.isNotEmpty ? imageUrl : this.imageUrl,
      description: description ?? this.description,
      price: price ?? this.price,
      createdAt: createdAt,
      stock: stock ?? this.stock,
      quantitySold: quantitySold ?? this.quantitySold,
      weightPrice: weightPrice ?? this.weightPrice,
      weightUnit: weightUnit ?? this.weightUnit,
      discountPercent: discountPercent ?? this.discountPercent,
      category: category ?? this.category,
      measureUnit: measureUnit ?? this.measureUnit,
    );
  }

  @override
  List<Object?> get props => [id];
}
