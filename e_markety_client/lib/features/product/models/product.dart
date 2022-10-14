import 'package:e_markety_client/features/category/models/category.dart';
import 'package:e_markety_client/features/product/models/sell_type.dart';

class Product {
  final int id;
  final String name;
  final String imageUrl;
  final String description;
  final double price;
  final DateTime createdAt;
  final Category category;
  final SellType sellType;
  final double? weightInKg;
  final bool isFavorite;

  final int? promotionPercent;

  const Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.createdAt,
    required this.category,
    required this.sellType,
    this.weightInKg,
    this.isFavorite = false,
    this.promotionPercent,
  });

  bool get isNew => createdAt.isAfter(
        DateTime.now().subtract(const Duration(days: 7)),
      );

  bool get hasPromotion => promotionPercent != null;

  double get promotionPrice => price - (price * promotionPercent! / 100);

  double get finalPrice {
    return hasPromotion ? promotionPrice : price;
  }

  double get discount => hasPromotion ? (price - promotionPrice) : 0;

  String get formattedWeight {
    if (weightInKg! < 1) {
      return '${(weightInKg! * 1000).toInt()} G';
    }

    var decimal = weightInKg! - weightInKg!.toInt();
    if (decimal == 0) {
      return '${weightInKg!.toInt()} kg';
    }

    return '${weightInKg!.toInt()} kg ${(decimal * 1000).toInt()} G';
  }
}