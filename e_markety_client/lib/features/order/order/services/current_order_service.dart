import 'package:e_markety_client/features/order/order/exceptions/order_exception.dart';
import 'package:e_markety_client/features/order/order/services/order_service.dart';
import 'package:e_markety_client/features/order/shopping_cart/models/cart_item.dart';
import 'package:e_markety_client/features/order/shopping_cart/services/cart_item_service.dart';

import '../exceptions/current_order_exception.dart';
import '../models/order.dart';

abstract class ICurrentOrderService {
  Future<Order> getCurrentOrder();

  Future<Order> updateCartItemsOrder(List<CartItem> items);

  Stream<Order> streamCurrentOrder();

  void closeStream();
}

class CurrentOrderService implements ICurrentOrderService {
  final IOrderService _orderService;
  final ICartItemService _cartItemService;

  bool _isStreamOpen = false;

  CurrentOrderService(this._orderService, this._cartItemService);

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
    var currentOrder = await _getCurrentOrder();
    if (currentOrder.items.isEmpty) {
      currentOrder = currentOrder.copyWith(
        items: await _cartItemService.getFromCache(),
      );
      currentOrder = _orderWithTotal(currentOrder);
    }

    return currentOrder;
  }

  @override
  Future<Order> updateCartItemsOrder(List<CartItem> items) async {
    var order = await getCurrentOrder();
    order = order.copyWith(items: items);

    return _orderWithTotal(order);
  }

  Order _orderWithTotal(Order order) {
    final total = order.subTotal + (order.deliveryCharge ?? 0) - order.discount;
    return order.copyWith(total: total);
  }

  @override
  Stream<Order> streamCurrentOrder() async* {
    Stream<Order> _emit() async* {
      final response = await _orderService.getOpenOrder();
      yield response.fold(
        (l) => throw CurrentOrderException(l.message),
        (r) => r,
      );
    }

    yield* _emit();
    _isStreamOpen = true;
    while (_isStreamOpen) {
      await Future.delayed(const Duration(seconds: 5));
      if (_isStreamOpen) yield* _emit();
    }
  }

  @override
  void closeStream() => _isStreamOpen = false;
}
