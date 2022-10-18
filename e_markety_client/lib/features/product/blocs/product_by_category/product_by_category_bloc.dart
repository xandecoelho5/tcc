import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/product.dart';
import '../../services/product_service.dart';

part 'product_by_category_event.dart';
part 'product_by_category_state.dart';

class ProductByCategoryBloc
    extends Bloc<ProductByCategoryEvent, ProductByCategoryState> {
  final IProductService _service;

  ProductByCategoryBloc(this._service) : super(ProductByCategoryInitial()) {
    on<ProductGetAllByCategoryEvent>(_onProductGetAllByCategoryEvent);
  }

  Future<void> _onProductGetAllByCategoryEvent(
    ProductGetAllByCategoryEvent event,
    emit,
  ) async {
    emit(ProductByCategoryLoading());
    final response = await _service.getProductsByCategory(event.categoryId);
    return response.fold(
      (l) => emit(ProductByCategoryError(l.message)),
      (r) => emit(ProductByCategoryLoaded(r)),
    );
  }
}
