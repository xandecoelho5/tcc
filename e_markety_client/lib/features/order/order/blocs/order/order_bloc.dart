import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shopping_cart/repositories/cart_item_repository.dart';
import '../../models/order.dart';
import '../../services/current_order_service.dart';
import '../../services/order_service.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final IOrderService _orderService;
  final ICurrentOrderService _currentOrderService;
  final CartItemRepository _cartItemRepository;

  OrderBloc(
    this._orderService,
    this._currentOrderService,
    this._cartItemRepository,
  ) : super(OrderInitial()) {
    on<OrderGetAllEvent>(_onOrderGetAllOrders);
    on<OrderPlaceEvent>(_onOrderPlace);
  }

  Future<void> _onOrderGetAllOrders(event, emit) async {
    emit(OrderLoading());
    final response = await _orderService.getOrders();
    response.fold(
      (l) => emit(OrderError(l.message)),
      (r) => emit(OrderLoaded(r)),
    );
  }

  Future<void> _onOrderPlace(OrderPlaceEvent event, emit) async {
    final response = await _orderService.placeOrder(event.order);
    await response.fold(
      (l) => emit(OrderError(l.message)),
      (r) async {
        _cartItemRepository.clearCart();
        await _currentOrderService.clear();
        emit(OrderSuccess(r));
      },
    );
  }
}
