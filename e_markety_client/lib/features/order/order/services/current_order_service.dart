import 'dart:convert';

import 'package:e_markety_client/features/order/order/exceptions/order_exception.dart';
import 'package:e_markety_client/features/order/order/services/order_service.dart';
import 'package:e_markety_client/features/order/shopping_cart/models/cart_item.dart';

import '../../../../core/services/cache/cache_service.dart';
import '../models/order.dart';

abstract class ICurrentOrderService {
  Future<Order> getCurrentOrder();

  Future<Order> updateCartItemsOrder(List<CartItem> items);

  Future<void> clear();
}

class CurrentOrderService implements ICurrentOrderService {
  final IOrderService _orderService;
  final ICacheService _cacheService;
  final String _kCurrentOrderKey = 'current_order';

  CurrentOrderService(this._orderService, this._cacheService) {
    _cacheService.delete(_kCurrentOrderKey);
  }

  Future<Order> _getCurrentOrder() async {
    Future<Order> _createOrder(OrderException ex) async {
      final response = await _orderService.createOrder();
      return response.fold(
        (l) => throw l,
        (r) => r,
      );
    }

    final response = await _orderService.getOpenOrder();
    return response.fold(
      (l) async {
        final order = await _createOrder(l);
        return order;
      },
      (r) => r,
    );
  }

  Future<dynamic> _getItemsFromCache() async {
    final cartItemsJson = await _cacheService.get('__cart_item_key__');
    if (cartItemsJson != null) {
      return (jsonDecode(cartItemsJson) as List)
          .map((e) => CartItem.fromJson(e))
          .toList();
    }
    return null;
  }

  @override
  Future<Order> getCurrentOrder() async {
    final order = await _cacheService.get(_kCurrentOrderKey);
    if (order != null) {
      return Order.fromJson(jsonDecode(order));
    }

    var currentOrder = await _getCurrentOrder();
    if (currentOrder.items.isEmpty) {
      currentOrder = currentOrder.copyWith(items: await _getItemsFromCache());
    }

    await _cacheService.save(_kCurrentOrderKey, jsonEncode(currentOrder));
    return currentOrder;
  }

  @override
  Future<Order> updateCartItemsOrder(List<CartItem> items) async {
    var order = await getCurrentOrder();
    order = order.copyWith(items: items);
    final total = _calculateTotal(order);
    order = order.copyWith(total: total);
    print(order);

    await _cacheService.save(_kCurrentOrderKey, jsonEncode(order));
    return order;
  }

  double _calculateTotal(Order order) {
    return order.subTotal + (order.deliveryCharge ?? 0) - order.discount;
  }

  @override
  Future<void> clear() async {
    await _cacheService.delete(_kCurrentOrderKey);
  }
}
