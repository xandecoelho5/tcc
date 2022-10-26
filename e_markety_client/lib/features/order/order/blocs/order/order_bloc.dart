import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/order.dart';
import '../../services/order_service.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final IOrderService _orderService;

  OrderBloc(this._orderService) : super(OrderInitial()) {
    on<OrderGetAllOrders>(_onOrderGetAllOrders);
  }

  Future<void> _onOrderGetAllOrders(event, emit) async {
    emit(OrderLoading());
    final response = await _orderService.getOrders();
    response.fold(
      (l) => emit(OrderError(l.message)),
      (r) => emit(OrderLoaded(r)),
    );
  }
}
