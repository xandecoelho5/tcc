import 'package:dartz/dartz.dart' hide Order;
import 'package:e_markety_client/core/services/http/http_service.dart';
import 'package:e_markety_client/features/admin/shared/data_responses/order_page_response.dart';

import '../../../admin/shared/services/paginated_service.dart';
import '../exceptions/order_exception.dart';
import '../models/order.dart';

abstract class IOrderService extends IPaginatedService {
  Future<Either<OrderException, List<Order>>> getOrders();

  Future<Either<OrderException, Order>> getOpenOrder();

  Future<Either<OrderException, Order>> createOrder();
}

class OrderService implements IOrderService {
  final IHttpService _httpService;
  final String _baseUrl = '/pedido';

  OrderService(this._httpService);

  @override
  Future<Either<OrderException, List<Order>>> getOrders() async {
    final response = await _httpService.getAll('$_baseUrl/current');
    return response.fold(
      (l) => Left(OrderException(l.message, l.stackTrace)),
      (r) => Right(r.map(Order.fromMap).toList()),
    );
  }

  @override
  Future<Either<OrderException, Order>> getOpenOrder() async {
    final response = await _httpService.get('$_baseUrl/aberto');
    return response.fold(
      (l) => Left(OrderException(l.message, l.stackTrace)),
      (r) => Right(Order.fromMap(r)),
    );
  }

  @override
  Future<Either<OrderException, Order>> createOrder() async {
    final response = await _httpService.post('$_baseUrl/novo', {});
    return response.fold(
      (l) => Left(OrderException(l.message, l.stackTrace)),
      (r) => Right(Order.fromMap(r)),
    );
  }

  @override
  Future<Either<OrderException, OrderPageResponse>> getPaginated({
    required int page,
    required int size,
    String? order,
    bool? asc,
  }) async {
    final response =
        await _httpService.get('$_baseUrl/page?page=$page&size=$size'
            '${order != null ? '&order=$order' : ''}'
            '${asc != null ? '&asc=$asc' : ''}');
    return response.fold(
      (l) => Left(OrderException(l.message, l.stackTrace)),
      (r) => Right(OrderPageResponse.fromMap(r)),
    );
  }
}
