import 'package:e_markety_client/features/product/models/product.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_item.g.dart';

@JsonSerializable(explicitToJson: true)
class CartItem {
  static int _id = 1;

  final int id;
  final Product product;
  final double quantity;

  const CartItem({
    required this.id,
    required this.product,
    required this.quantity,
  });

  CartItem.empty({
    required this.product,
    this.quantity = 1,
  }) : id = _id++;

  factory CartItem.fromMap(dynamic map) {
    return CartItem(
      id: map['id'],
      product: Product.fromMap(map['produto']),
      quantity: map['quantidade'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'produto': product,
      'quantidade': quantity,
    };
  }

  CartItem copyWith({
    int? id,
    Product? product,
    double? quantity,
  }) {
    return CartItem(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  // @override
  // String toString() {
  //   return 'CartItem{id: $id, product: $product, quantity: $quantity}';
  // }

  @override
  String toString() {
    return 'CartItem{id: $id}';
  }

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}
