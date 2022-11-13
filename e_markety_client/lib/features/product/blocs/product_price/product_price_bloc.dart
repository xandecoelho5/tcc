import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/price_range.dart';
import '../../services/product_service.dart';

part 'product_price_event.dart';
part 'product_price_state.dart';

class ProductPriceBloc extends Bloc<ProductPriceEvent, ProductPriceState> {
  final IProductService _service;

  ProductPriceBloc(this._service) : super(ProductPriceInitial()) {
    on<ProductPriceGetRange>(_onGetRange);
  }

  Future<void> _onGetRange(event, emit) async {
    final response = await _service.getPriceRange();
    response.fold(
      (l) => emit(ProductPriceError(l.message)),
      (r) => emit(ProductPriceLoaded(r)),
    );
  }
}
