import 'dart:convert';

import 'package:e_markety_client/core/services/cache/cache_service.dart';
import 'package:e_markety_client/features/order/shopping_cart/models/cart_item.dart';
import 'package:rxdart/rxdart.dart';

abstract class ICartItemService {
  void addToCart(CartItem cartItem);

  void removeFromCart(int productId);

  Stream<List<CartItem>> getCartItems();

  void quantityIncrement(CartItem cartItem);

  void quantityDecrement(CartItem cartItem);

  void clearCart();
}

class CartItemService implements ICartItemService {
  final ICacheService _cacheService;
  final _streamController = BehaviorSubject<List<CartItem>>.seeded(const []);
  static const _kCartItemKey = '__cart_item_key__';

  CartItemService(this._cacheService) {
    _init();
  }

  Future<void> _init() async {
    final cartItemsJson = await _cacheService.get(_kCartItemKey);
    if (cartItemsJson != null) {
      final cartItems = (jsonDecode(cartItemsJson) as List)
          .map((e) => CartItem.fromJson(e))
          .toList();
      _streamController.add(cartItems);
    } else {
      _streamController.add(const []);
    }
  }

  @override
  Stream<List<CartItem>> getCartItems() =>
      _streamController.asBroadcastStream();

  @override
  Future<void> addToCart(CartItem cartItem) async {
    final cartItems = [..._streamController.value];
    final index = _findIndexByProductId(cartItem);
    if (index >= 0) {
      cartItems[index] = cartItem;
    } else {
      cartItems.add(cartItem);
    }

    _streamController.add(cartItems);
    await _cacheService.save(_kCartItemKey, jsonEncode(cartItems));
  }

  @override
  Future<void> removeFromCart(int productId) async {
    final cartItems = [..._streamController.value];
    final index = cartItems.indexWhere((t) => t.product.id == productId);
    if (index >= 0) {
      cartItems.removeAt(index);
      _streamController.add(cartItems);
      await _cacheService.save(_kCartItemKey, jsonEncode(cartItems));
    }
  }

  @override
  Future<void> quantityIncrement(CartItem cartItem) async {
    final cartItems = [..._streamController.value];
    final index = _findIndexByProductId(cartItem);
    cartItems[index] = cartItem.copyWith(
      quantity: cartItem.quantity + cartItem.product.weightUnit,
    );

    _streamController.add(cartItems);
    await _cacheService.save(_kCartItemKey, jsonEncode(cartItems));
  }

  @override
  Future<void> quantityDecrement(CartItem cartItem) async {
    final cartItems = [..._streamController.value];
    final index = _findIndexByProductId(cartItem);
    if (cartItem.quantity > cartItem.product.weightUnit) {
      cartItems[index] = cartItem.copyWith(
        quantity: cartItem.quantity - cartItem.product.weightUnit,
      );
    }

    _streamController.add(cartItems);
    await _cacheService.save(_kCartItemKey, jsonEncode(cartItems));
  }

  int _findIndexByProductId(CartItem item) => [..._streamController.value]
      .indexWhere((t) => t.product.id == item.product.id);

  @override
  void clearCart() {
    _streamController.add(const []);
    _cacheService.delete(_kCartItemKey);
  }
}
