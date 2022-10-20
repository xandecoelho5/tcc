import 'package:dartz/dartz.dart' hide Order;
import 'package:e_markety_client/core/services/http/http_service.dart';

import '../exceptions/order_exception.dart';
import '../models/order.dart';

abstract class IOrderService {
  Future<Either<OrderException, List<Order>>> getOrders();
}

class OrderService implements IOrderService {
  final IHttpService _httpService;
  final String _baseUrl = '/pedido';

  OrderService(this._httpService);

  @override
  Future<Either<OrderException, List<Order>>> getOrders() async {
    final response = await _httpService.getAll(_baseUrl);
    return response.fold(
      (l) => Left(OrderException(l.message, l.stackTrace)),
      (r) => Right(r.map(Order.fromMap).toList()),
    );
  }
}
