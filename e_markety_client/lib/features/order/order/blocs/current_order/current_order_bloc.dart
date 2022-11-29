import 'package:e_markety_client/features/order/shopping_cart/models/cart_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/order.dart';
import '../../services/current_order_service.dart';

part 'current_order_event.dart';
part 'current_order_state.dart';

class CurrentOrderBloc extends Bloc<CurrentOrderEvent, CurrentOrderState> {
  final ICurrentOrderService _service;

  CurrentOrderBloc(this._service) : super(CurrentOrderInitial()) {
    on<GetCurrentOrder>(_onGetCurrentOrder);
    on<UpdateOrderItems>(_onUpdateItemsOrder);
    on<StreamCurrentOrder>(_onStreamCurrentOrder);
    on<CloseStreamCurrentOrder>(_onCloseStreamCurrentOrder);
  }

  Future<void> _onGetCurrentOrder(GetCurrentOrder event, emit) async {
    emit(CurrentOrderLoading());
    try {
      final order = await _service.getCurrentOrder();
      emit(CurrentOrderLoaded(order));
      event.onCompleted?.call();
    } catch (e) {
      emit(CurrentOrderError(e.toString()));
    }
  }

  Future<void> _onUpdateItemsOrder(UpdateOrderItems event, emit) async {
    try {
      final order = await _service.updateCartItemsOrder(event.items);
      emit(CurrentOrderLoaded(order));
    } catch (e) {
      emit(CurrentOrderError(e.toString()));
    }
  }

  Future<void> _onStreamCurrentOrder(
    StreamCurrentOrder event,
    Emitter emit,
  ) async {
    emit(CurrentOrderLoading());
    await emit.onEach<Order>(
      _service.streamCurrentOrder(),
      onData: (order) => emit(CurrentOrderLoaded(order)),
      onError: (_, __) => emit(CurrentOrderError(_.toString())),
    );
  }

  void _onCloseStreamCurrentOrder(event, emit) {
    _service.closeStream();
  }
}
