import 'package:e_markety_client/features/product/models/product.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_item.g.dart';

@JsonSerializable(explicitToJson: true)
class CartItem {
  final Product product;
  final double quantity;
  final double unitPrice;

  CartItem({
    required this.product,
    required this.quantity,
    required this.unitPrice,
  });

  CartItem.empty({
    required this.product,
    this.quantity = 1,
  }) : unitPrice = product.finalPrice;

  double get subTotal => quantity * unitPrice;

  String get quantityText {
    if (product.measureUnit!.abbreviation == 'UN') {
      return quantity.toInt().toString();
    }
    return quantity.toStringAsFixed(product.fractionDigits);
  }

  factory CartItem.fromMap(dynamic map) {
    return CartItem(
      product: Product.fromMap(map['produto']),
      quantity: map['quantidade'],
      unitPrice: map['precoUnitario'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'produto': product.toMap(),
      'quantidade': quantity,
      'precoUnitario': unitPrice,
    };
  }

  Map<String, dynamic> toMapDto() {
    return {
      'produtoId': product.id,
      'produtoNome': product.name,
      'quantidade': quantity,
    };
  }

  CartItem copyWith({
    Product? product,
    double? quantity,
    double? unitPrice,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
    );
  }

  factory CartItem.fromJson(dynamic json) => _$CartItemFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}
