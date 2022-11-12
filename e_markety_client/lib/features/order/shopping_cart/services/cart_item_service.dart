import 'dart:convert';

import 'package:e_markety_client/core/services/cache/cache_service.dart';
import 'package:e_markety_client/features/company/services/company_service.dart';
import 'package:e_markety_client/features/order/shopping_cart/models/cart_item.dart';
import 'package:e_markety_client/features/user/services/user_service.dart';
import 'package:rxdart/rxdart.dart';

abstract class ICartItemService {
  void addToCart(CartItem cartItem);

  void removeFromCart(int productId);

  Stream<List<CartItem>> getCartItems();

  void quantityIncrement(CartItem cartItem);

  void quantityDecrement(CartItem cartItem);

  void clearCart();

  Future<void> init();

  Future<List<CartItem>> getFromCache();
}

class CartItemService implements ICartItemService {
  final ICacheService _cacheService;
  final ICompanyService _companyService;
  final IUserService _userService;

  final _streamController = BehaviorSubject<List<CartItem>>.seeded(const []);
  String? _cartItemKey;

  CartItemService(this._cacheService, this._companyService, this._userService);

  @override
  Future<void> init() async {
    Future<void> _setKey() async {
      final userResponse = await _userService.getCurrentUser();
      final user = userResponse.fold((l) => null, (r) => r.id);
      final companyResponse = await _companyService.getCurrentCompany();
      final company = companyResponse.fold((l) => null, (r) => r.id);
      _cartItemKey = '__cart_item_key__${user ?? ''}${company ?? ''}';
    }

    await _setKey();
    _streamController.add(await getFromCache());
  }

  @override
  Future<List<CartItem>> getFromCache() async {
    final cartItemsJson = await _cacheService.get(_cartItemKey!);
    return cartItemsJson != null
        ? (jsonDecode(cartItemsJson) as List).map(CartItem.fromJson).toList()
        : const [];
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

    await _addToStreamAndSave(cartItems);
  }

  @override
  Future<void> removeFromCart(int productId) async {
    final cartItems = [..._streamController.value];
    final index = cartItems.indexWhere((t) => t.product.id == productId);
    if (index >= 0) {
      cartItems.removeAt(index);
      await _addToStreamAndSave(cartItems);
    }
  }

  @override
  Future<void> quantityIncrement(CartItem cartItem) async {
    await _updateQuantity(cartItem, () {
      CartItem _cartItem;
      if (cartItem.quantity + cartItem.product.weightUnit >
          cartItem.product.stock) {
        _cartItem = cartItem.copyWith(quantity: cartItem.product.stock);
      } else {
        _cartItem = cartItem.copyWith(
          quantity: cartItem.quantity + cartItem.product.weightUnit,
        );
      }
      return _cartItem;
    });
  }

  @override
  Future<void> quantityDecrement(CartItem cartItem) async {
    await _updateQuantity(cartItem, () {
      if (cartItem.quantity > cartItem.product.weightUnit) {
        return cartItem.copyWith(
          quantity: cartItem.quantity - cartItem.product.weightUnit,
        );
      }
      return cartItem;
    });
  }

  Future<void> _updateQuantity(CartItem item, CartItem Function() f) async {
    final cartItems = [..._streamController.value];
    final index = _findIndexByProductId(item);
    cartItems[index] = f();
    await _addToStreamAndSave(cartItems);
  }

  Future<void> _addToStreamAndSave(List<CartItem> cartItems) async {
    _streamController.add(cartItems);
    await _cacheService.save(_cartItemKey!, jsonEncode(cartItems));
  }

  int _findIndexByProductId(CartItem item) => [..._streamController.value]
      .indexWhere((t) => t.product.id == item.product.id);

  @override
  void clearCart() {
    _streamController.add(const []);
    _cacheService.delete(_cartItemKey!);
  }
}
