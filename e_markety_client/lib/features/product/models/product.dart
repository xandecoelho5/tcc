import 'package:e_markety_client/features/category/models/category.dart';
import 'package:e_markety_client/features/product/models/measure_unit.dart';

class Product {
  final int id;
  final String name;
  final String imageUrl;
  final String description;
  final double price;
  final DateTime createdAt;
  final int stock;
  final bool isFavorite;
  final int quantitySold;
  final double weightPrice; // In Kg, L, UN
  final double weightUnit; // Kg, L, UN

  final int discountPercent;

  final Category category;
  final MeasureUnit measureUnit;

  const Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.createdAt,
    required this.stock,
    required this.isFavorite,
    required this.quantitySold,
    required this.weightPrice,
    required this.weightUnit,
    required this.discountPercent,
    required this.category,
    required this.measureUnit,
  });

  bool get isNew => createdAt.isAfter(
        DateTime.now().subtract(const Duration(days: 7)),
      );

  bool get hasPromotion => discountPercent > 0;

  double get promotionPrice => price - (price * discountPercent / 100);

  double get finalPrice {
    return hasPromotion ? promotionPrice : price;
  }

  double get discount => hasPromotion ? (price - promotionPrice) : 0;

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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': name,
      'imagemUrl': imageUrl,
      'descricao': description,
      'preco': price,
      'data': createdAt,
      'estoque': stock,
      'favorito': isFavorite,
      'quantidadeVendida': quantitySold,
      'pesoPreco': weightPrice,
      'pesoUnidade': weightUnit,
      'percentualDesconto': discountPercent,
      'categoria': category,
      'unidadeMedida': measureUnit,
    };
  }

  factory Product.fromMap(dynamic map) {
    return Product(
      id: map['id'],
      name: map['nome'],
      imageUrl: map['imagemUrl'],
      description: map['descricao'],
      price: map['preco'],
      createdAt: DateTime.parse(map['data']),
      stock: map['estoque'],
      isFavorite: map['favorito'],
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
    return 'Product{id: $id, name: $name, imageUrl: $imageUrl, description: '
        '$description, price: $price, createdAt: $createdAt, stock: $stock, '
        'isFavorite: $isFavorite, quantitySold: $quantitySold, '
        'weightPrice: $weightPrice, weightUnit: $weightUnit, '
        'discountPercent: $discountPercent, category: $category, '
        'measureUnit: $measureUnit}';
  }
}
