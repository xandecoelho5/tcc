import 'package:e_markety_client/features/product/models/product.dart';

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

  // @override
  // String toString() {
  //   return 'CartItem{id: $id, product: $product, quantity: $quantity}';
  // }

  @override
  String toString() {
    return 'CartItem{id: $id}';
  }
}
