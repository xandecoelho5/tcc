import 'package:e_markety_client/features/product/models/filter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/product.dart';
import '../../services/product_service.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  final IProductService _productService;

  FilterBloc(this._productService) : super(FilterInitial()) {
    on<FilterApplyEvent>(_onApplyFilter);
  }

  Future<void> _onApplyFilter(FilterApplyEvent event, emit) async {
    emit(FilterLoading());
    final response = await _productService.getProductsByFilter(event.filter);
    await response.fold(
      (l) => emit(FilterError(l.message)),
      (r) => emit(FilterLoaded(event.filter.name, r)),
    );
  }
}
