import 'package:e_markety_client/features/product/models/product.dart';

class CartItem {
  final int id;
  final Product product;
  final int quantity;

  const CartItem({
    required this.id,
    required this.product,
    required this.quantity,
  });
}
