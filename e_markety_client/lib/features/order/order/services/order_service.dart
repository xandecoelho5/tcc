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

  Future<Either<OrderException, Order>> placeOrder(Order order);

  Future<Either<OrderException, void>> updateOrderStatus(int id);

  Stream<Either<OrderException, List<Order>>> streamOrders();

  void closeStream();
}

class OrderService implements IOrderService {
  final IHttpService _httpService;
  final String _baseUrl = '/pedido';
  bool _isStreamOpen = false;

  OrderService(this._httpService);

  @override
  Future<Either<OrderException, List<Order>>> getOrders() async {
    final response = await _httpService.getAll(_baseUrl);
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
        await _httpService.get('$_baseUrl/empresa/page?page=$page&size=$size'
            '${order != null ? '&order=$order' : ''}'
            '${asc != null ? '&asc=$asc' : ''}');
    return response.fold(
      (l) => Left(OrderException(l.message, l.stackTrace)),
      (r) => Right(OrderPageResponse.fromMap(r)),
    );
  }

  @override
  Future<Either<OrderException, Order>> placeOrder(Order order) async {
    final response =
        await _httpService.put('$_baseUrl/realizar', order.toMap());
    return response.fold(
      (l) => Left(OrderException(l.message, l.stackTrace)),
      (r) => Right(Order.fromMap(r)),
    );
  }

  @override
  Future<Either<OrderException, void>> updateOrderStatus(int id) async {
    final response = await _httpService.patch('$_baseUrl/$id', {});
    return response.fold(
      (l) => Left(OrderException(l.message, l.stackTrace)),
      (r) => const Right(null),
    );
  }

  @override
  Stream<Either<OrderException, List<Order>>> streamOrders() async* {
    Stream<Either<OrderException, List<Order>>> _emit() async* {
      final response = await _httpService.getAll(_baseUrl);
      yield response.fold(
        (l) => Left(OrderException(l.message, l.stackTrace)),
        (r) => Right(r.map(Order.fromMap).toList()),
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
