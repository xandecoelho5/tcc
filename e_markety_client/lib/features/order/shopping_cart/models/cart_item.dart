import 'package:e_markety_client/features/product/models/product.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_item.g.dart';

@JsonSerializable(explicitToJson: true)
class CartItem {
  final Product product;
  final double quantity;

  const CartItem({
    required this.product,
    required this.quantity,
  });

  CartItem.empty({
    required this.product,
    this.quantity = 1,
  });

  factory CartItem.fromMap(dynamic map) {
    return CartItem(
      product: Product.fromMap(map['produto']),
      quantity: map['quantidade'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'produto': product.toMap(),
      'quantidade': quantity,
    };
  }

  CartItem copyWith({
    Product? product,
    double? quantity,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  // @override
  // String toString() {
  //   return 'CartItem{product: $product, quantity: $quantity}';
  // }

  @override
  String toString() {
    return 'CartItem{id: ${product.id}';
  }

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}
