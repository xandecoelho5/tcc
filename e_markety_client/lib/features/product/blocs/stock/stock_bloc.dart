import 'package:e_markety_client/features/order/shopping_cart/models/cart_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/product_service.dart';

part 'stock_event.dart';
part 'stock_state.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  final IProductService _service;

  StockBloc(this._service) : super(StockInitial()) {
    on<VerifyStock>(_onVerifyStock);
  }

  Future<void> _onVerifyStock(VerifyStock event, Emitter emit) async {
    final resp = await _service.validateStock([event.cartItem]);
    resp.fold(
      (l) => emit(StockError(l.message)),
      (r) => emit(StockSuccess(event.cartItem)),
    );
  }
}
