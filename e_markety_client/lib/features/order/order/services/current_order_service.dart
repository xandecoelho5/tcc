import 'dart:convert';

import 'package:e_markety_client/features/order/order/exceptions/order_exception.dart';
import 'package:e_markety_client/features/order/order/services/order_service.dart';
import 'package:e_markety_client/features/order/shopping_cart/models/cart_item.dart';

import '../../../../core/services/cache/cache_service.dart';
import '../models/order.dart';

abstract class ICurrentOrderService {
  Future<Order> getCurrentOrder();

  Future<Order> updateCartItemsOrder(List<CartItem> items);
}

class CurrentOrderService implements ICurrentOrderService {
  final IOrderService _orderService;
  final ICacheService _cacheService;

  CurrentOrderService(this._orderService, this._cacheService);

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

  @override
  Future<Order> getCurrentOrder() async {
    final order = await _cacheService.get('current_order');
    if (order != null) {
      return Order.fromJson(jsonDecode(order));
    }

    final currentOrder = await _getCurrentOrder();
    await _cacheService.save('current_order', jsonEncode(currentOrder));
    return currentOrder;
  }

  @override
  Future<Order> updateCartItemsOrder(List<CartItem> items) async {
    var order = await getCurrentOrder();
    order = order.copyWith(items: items);

    await _cacheService.save('current_order', jsonEncode(order));
    return order;
  }
}
