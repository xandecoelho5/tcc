import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../admin/shared/data_responses/product_page_response.dart';
import '../../models/product.dart';
import '../../services/product_service.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final IProductService _service;

  ProductBloc(this._service) : super(ProductInitial()) {
    on<ProductGetAllEvent>(_onProductGetAllEvent);
    on<ProductGetPageEvent>(_onProductGetPageEvent);
  }

  Future<void> _onProductGetAllEvent(ProductGetAllEvent event, emit) async {
    emit(ProductLoading());
    final response = await _service.getProducts(event.size);
    return response.fold(
      (l) => emit(ProductError(l.message)),
      (r) => emit(ProductLoaded(r)),
    );
  }

  Future<void> _onProductGetPageEvent(ProductGetPageEvent event, emit) async {
    emit(ProductLoading());
    final response = await _service.getProductsPaginated(
      size: event.size,
      page: event.page,
      order: event.order,
      asc: event.asc,
    );
    return response.fold(
      (l) => emit(ProductError(l.message)),
      (r) => emit(ProductPageLoaded(r)),
    );
  }
}
