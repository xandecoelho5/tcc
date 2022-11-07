import 'package:e_markety_client/features/order/shopping_cart/services/cart_item_service.dart';

import '../models/cart_item.dart';

class CartItemRepository {
  final ICartItemService _cartItemService;

  CartItemRepository(this._cartItemService);

  Stream<List<CartItem>> getCartItems() => _cartItemService.getCartItems();

  void addToCart(CartItem cartItem) => _cartItemService.addToCart(cartItem);

  void removeFromCart(int id) => _cartItemService.removeFromCart(id);

  void quantityIncrement(CartItem cartItem) =>
      _cartItemService.quantityIncrement(cartItem);

  void quantityDecrement(CartItem cartItem) =>
      _cartItemService.quantityDecrement(cartItem);

  void clearCart() => _cartItemService.clearCart();
}
