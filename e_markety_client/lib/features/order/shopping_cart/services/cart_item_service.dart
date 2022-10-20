import 'package:e_markety_client/core/services/cache/cache_service.dart';
import 'package:e_markety_client/features/order/shopping_cart/models/cart_item.dart';
import 'package:rxdart/rxdart.dart';

abstract class ICartItemService {
  void addToCart(CartItem cartItem);

  void removeFromCart(int id);

  // void clearCart();
  // List<CartItem> getCartItems();
  Stream<List<CartItem>> getCartItems();
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
    print('cartItemsJson: $cartItemsJson');
    if (cartItemsJson != null) {
      final cartItems = _decode(cartItemsJson);
      _streamController.add(cartItems);
    } else {
      _streamController.add(const []);
    }
  }

  @override
  Stream<List<CartItem>> getCartItems() =>
      _streamController.asBroadcastStream();

  @override
  Future<void> addToCart(CartItem cartItem) {
    final cartItems = [..._streamController.value];
    final index = cartItems.indexWhere(
      (t) => t.product.id == cartItem.product.id,
    );
    if (index >= 0) {
      cartItems[index] = cartItem;
    } else {
      cartItems.add(cartItem);
    }

    _streamController.add(cartItems);
    return _cacheService.save(_kCartItemKey, _encode(cartItems));
  }

  @override
  Future<void> removeFromCart(int id) async {
    final cartItems = [..._streamController.value];
    final index = cartItems.indexWhere((t) => t.id == id);
    if (index == -1) {
      throw Exception('Cart Item não encontrado');
    } else {
      cartItems.removeAt(index);
      _streamController.add(cartItems);
      return _cacheService.save(_kCartItemKey, _encode(cartItems));
    }
  }

  List<Map<String, dynamic>> _encode(List<CartItem> cartItems) =>
      cartItems.map((e) => e.toMap()).toList();

  List<CartItem> _decode(List<Map<String, dynamic>> cartItems) =>
      cartItems.map(CartItem.fromMap).toList();
}
