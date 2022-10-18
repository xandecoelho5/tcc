import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/product.dart';
import '../../services/product_service.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final IProductService _service;

  ProductBloc(this._service) : super(ProductInitial()) {
    on<ProductGetAllEvent>(_onProductGetAllEvent);
  }

  Future<void> _onProductGetAllEvent(ProductGetAllEvent event, emit) async {
    emit(ProductLoading());
    final response = await _service.getProducts(event.size);
    return response.fold(
      (l) => emit(ProductError(l.message)),
      (r) => emit(ProductLoaded(r)),
    );
  }
}
