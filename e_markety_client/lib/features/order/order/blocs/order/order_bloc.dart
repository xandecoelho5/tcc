import 'package:e_markety_client/features/order/shopping_cart/services/cart_item_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/order.dart';
import '../../services/order_service.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final IOrderService _orderService;
  final ICartItemService _cartItemService;
  bool _isStreamOpen = false;

  bool get isStreamOpen => _isStreamOpen;

  OrderBloc(this._orderService, this._cartItemService) : super(OrderInitial()) {
    on<OrderGetAllEvent>(_onOrderGetAllOrders);
    on<OrderPlaceEvent>(_onOrderPlace);
    on<OrderStreamEvent>(_onOrderStream);
    on<OrderCloseStreamEvent>(_onOrderCloseStream);
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
        _cartItemService.clearCart();
        emit(OrderSuccess(r));
      },
    );
  }

  Future<void> _onOrderStream(OrderStreamEvent event, Emitter emit) async {
    if (!_isStreamOpen) {
      emit(OrderLoading());
      _isStreamOpen = true;
      await emit.onEach<dynamic>(
        _orderService.streamOrders(),
        onData: (orders) {
          orders.fold(
            (l) => emit(OrderError(l.message)),
            (r) => emit(OrderLoaded(r)),
          );
        },
      );
    }
  }

  void _onOrderCloseStream(event, emit) {
    _orderService.closeStream();
    _isStreamOpen = false;
  }
}
