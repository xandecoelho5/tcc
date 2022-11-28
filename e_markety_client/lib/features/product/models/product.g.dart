// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as int?,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      stock: (json['stock'] as num).toDouble(),
      quantitySold: (json['quantitySold'] as num).toDouble(),
      weightPrice: (json['weightPrice'] as num).toDouble(),
      weightUnit: (json['weightUnit'] as num).toDouble(),
      discountPercent: json['discountPercent'] as int,
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
      measureUnit: json['measureUnit'] == null
          ? null
          : MeasureUnit.fromJson(json['measureUnit'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'description': instance.description,
      'price': instance.price,
      'createdAt': instance.createdAt?.toIso8601String(),
      'stock': instance.stock,
      'quantitySold': instance.quantitySold,
      'weightPrice': instance.weightPrice,
      'weightUnit': instance.weightUnit,
      'discountPercent': instance.discountPercent,
      'category': instance.category?.toJson(),
      'measureUnit': instance.measureUnit?.toJson(),
    };
